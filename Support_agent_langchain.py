"""
The SAME customer-support agent as support_agent.py, rebuilt with LangChain.

The point of this file: every seatbelt you hand-wrote in support_agent.py
(the loop, the step budget, the human-approval gate, the memory) is now a
line of CONFIGURATION. The only code that stayed the same is your tools --
because that's the one part a framework can't write for you.

Run with:
    pip install langchain langchain-anthropic langgraph
    export ANTHROPIC_API_KEY="your-key-here"
    python support_agent_langchain.py
"""

import json

from langchain.agents import create_agent
from langchain.agents.middleware import (
    HumanInTheLoopMiddleware,   # REAL-WORLD: the approval gate
    ToolCallLimitMiddleware,    # REAL-WORLD: the runaway guard
)
from langgraph.checkpoint.memory import InMemorySaver  # REAL-WORLD: memory
from langgraph.types import Command                    # to resume after approval

RETURN_WINDOW_DAYS = 30


# --- Fake backends (in real life: a database + a payments API) ---------------
ORDERS = {
    "A1001": {"customer": "Dana", "item": "Wireless earbuds", "total": 79.99,
              "status": "delivered", "days_since_delivery": 12},
    "A1002": {"customer": "Dana", "item": "Laptop stand", "total": 240.00,
              "status": "delivered", "days_since_delivery": 45},
    "A1003": {"customer": "Dana", "item": "USB-C cable", "total": 12.50,
              "status": "shipped", "days_since_delivery": None},
}
REFUND_LEDGER = []


# --- Tools: THIS is the only part that looks like support_agent.py -----------
# Plain functions. LangChain reads the type hints for the schema and the
# docstring for the description -- no hand-written JSON "cards" needed.
# We still return structured {"error": ...} results so the model can recover.
def look_up_order(order_id: str) -> str:
    """Look up an order by its ID."""
    order = ORDERS.get(order_id)
    if not order:
        return json.dumps({"error": f"No order found with id '{order_id}'."})
    return json.dumps({"order_id": order_id, **order})


def check_return_eligibility(order_id: str) -> str:
    """Decide whether an order can still be returned."""
    order = ORDERS.get(order_id)
    if not order:
        return json.dumps({"error": f"No order found with id '{order_id}'."})
    if order["status"] != "delivered":
        return json.dumps({"eligible": False,
                           "reason": f"Order is '{order['status']}', not delivered yet."})
    days = order["days_since_delivery"]
    if days is not None and days > RETURN_WINDOW_DAYS:
        return json.dumps({"eligible": False,
                           "reason": f"{days} days since delivery; window is {RETURN_WINDOW_DAYS}."})
    return json.dumps({"eligible": True, "reason": "Within the return window."})


def process_refund(order_id: str, amount: float) -> str:
    """Issue a refund for an order. This actually moves money."""
    order = ORDERS.get(order_id)
    if not order:
        return json.dumps({"error": f"No order found with id '{order_id}'."})
    if amount > order["total"]:
        return json.dumps({"error": f"Refund {amount} exceeds order total {order['total']}."})
    if any(r["order_id"] == order_id for r in REFUND_LEDGER):
        return json.dumps({"error": "This order has already been refunded."})
    REFUND_LEDGER.append({"order_id": order_id, "amount": amount})
    return json.dumps({"status": "refunded", "order_id": order_id, "amount": amount})


SYSTEM_PROMPT = (
    "You are a customer-support agent for an electronics store. "
    "Always look up real order data with your tools before answering -- "
    "never invent order details. Only offer a refund after confirming the "
    "order is return-eligible. Be concise, warm, and clear."
)


# --- The agent: the whole ~90 lines of support_agent.py, as config -----------
checkpointer = InMemorySaver()  # persists the conversation = memory across turns

agent = create_agent(
    model="anthropic:claude-sonnet-5",
    tools=[look_up_order, check_return_eligibility, process_refund],
    system_prompt=SYSTEM_PROMPT,
    checkpointer=checkpointer,
    middleware=[
        # REAL-WORLD: pause for a human before any refund fires.
        # (Note: interrupt_on gates by TOOL, not by amount. The "$50 auto-approve"
        #  tier from the hand-written version would need a tiny custom middleware.)
        HumanInTheLoopMiddleware(
            interrupt_on={"process_refund": {"allowed_decisions": ["approve", "reject"]}},
            description_prefix="Refund pending approval",
        ),
        # REAL-WORLD: the runaway guard -- at most 6 tool calls per user message.
        ToolCallLimitMiddleware(run_limit=6, exit_behavior="end"),
    ],
)
# NOTE: LangChain's tool runner already catches tool exceptions and hands the
# error back to the model, so the manual try/except from support_agent.py is gone.


# --- Multi-turn conversation -------------------------------------------------
# We DON'T track the message history ourselves anymore. The checkpointer does
# it, keyed by thread_id -- that's the framework giving us memory for free.
def show_reply(result):
    print(f"Agent: {result['messages'][-1].content}\n")


if __name__ == "__main__":
    print("Support agent ready. Try: 'I want to return order A1002'. Type 'quit' to exit.\n")
    config = {"configurable": {"thread_id": "customer-dana"}}

    while True:
        user = input("You: ").strip()
        if user.lower() in {"quit", "exit"}:
            break

        result = agent.invoke({"messages": [{"role": "user", "content": user}]}, config)

        # If a refund is pending, the run PAUSES and hands us an interrupt.
        while result.get("__interrupt__"):
            pending = result["__interrupt__"][0].value
            print(f"\n[APPROVAL NEEDED] {pending}")
            if input("Approve this refund? [y/N] ").strip().lower() == "y":
                decision = {"type": "approve"}
            else:
                decision = {"type": "reject", "message": "Human declined the refund."}
            # Resume the paused run with the human's decision.
            result = agent.invoke(Command(resume={"decisions": [decision]}), config)

        show_reply(result)
