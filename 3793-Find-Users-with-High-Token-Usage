select p.user_id,
       count(p.prompt) as prompt_count,
       round(avg(p.tokens),2) as avg_tokens
  from prompts p
group by p.user_id
having count(p.prompt) >= 3
    and max(p.tokens) > avg(p.tokens)
order by avg(p.tokens) desc,
         p.user_id asc
