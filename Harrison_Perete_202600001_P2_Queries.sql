-- Q1: Copies that are still on loan.
SELECT m.full_name, c.barcode, l.due_at::date AS due_date
FROM public.loan l JOIN public.member m USING (member_id)
JOIN public.book_copy c USING (copy_id)
WHERE l.returned_at IS NULL ORDER BY c.barcode;

-- Q2: A copy is available when it has no open loan.
SELECT c.barcode, b.title
FROM public.book_copy c JOIN public.book b USING (book_id)
WHERE NOT EXISTS (
    SELECT 1 FROM public.loan l
    WHERE l.copy_id = c.copy_id AND l.returned_at IS NULL
)
ORDER BY c.barcode;

-- Q3: Count each member's loans, including returned ones.
-- LEFT JOIN also keeps members who have no loans.
SELECT m.full_name, count(l.loan_id) AS total_loans
FROM public.member m LEFT JOIN public.loan l USING (member_id)
GROUP BY m.member_id, m.full_name ORDER BY m.full_name;
