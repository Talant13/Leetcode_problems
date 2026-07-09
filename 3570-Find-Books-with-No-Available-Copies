with tab1 as(
select r.book_id,
       b.title,
       b.author,
       b.genre,
       b.publication_year,
       b.total_copies,
       count(r.borrower_name) as cnt_b
  from borrowing_records r
  inner join library_books b on b.book_id = r.book_id
 where r.return_date is null
 group by r.book_id,
       b.title,
       b.author,
       b.genre,
       b.publication_year,
       b.total_copies
)Select t.book_id,
       t.title,
       t.author,
       t.genre,
       t.publication_year,
       t.cnt_b as current_borrowers
   from tab1 t
where t.cnt_b = t.total_copies
order by t.cnt_b desc,
         t.title asc
