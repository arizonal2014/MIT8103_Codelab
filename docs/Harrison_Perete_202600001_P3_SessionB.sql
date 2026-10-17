-- Follow the codelab's order across TWO terminals. Do not run this whole file at once.
-- B1: Run only after Session A has inserted LIB003 but has NOT committed.
SET application_name = 'p3_session_b';
BEGIN ISOLATION LEVEL READ COMMITTED;
SHOW transaction_isolation;
SELECT count(*) AS visible_open_loans FROM public.loan
WHERE copy_id = (SELECT copy_id FROM public.book_copy WHERE barcode = 'LIB003')
  AND returned_at IS NULL;
-- Expected: 0. Session A's new loan is not committed yet.
INSERT INTO public.loan (member_id, copy_id, borrowed_at, due_at)
SELECT m.member_id, c.copy_id,
       TIMESTAMPTZ '2026-10-17 14:00:00+00', TIMESTAMPTZ '2026-10-24 14:00:00+00'
FROM public.member m CROSS JOIN public.book_copy c
WHERE m.membership_number = 'M001' AND c.barcode = 'LIB003';
-- WAIT here. Switch to Session A for A2 and COMMIT.

-- B2: After the duplicate-key error, clear the failed transaction.
ROLLBACK;
-- Exactly one open loan remains, belonging to Ben (M002), not Ada (M001).
SELECT m.full_name, c.barcode, count(*) AS open_loans
FROM public.loan l JOIN public.member m USING (member_id)
JOIN public.book_copy c USING (copy_id)
WHERE c.barcode = 'LIB003' AND l.returned_at IS NULL
GROUP BY m.full_name, c.barcode;
