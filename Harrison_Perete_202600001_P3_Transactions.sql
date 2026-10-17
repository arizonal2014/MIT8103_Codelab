-- Start from the Portfolio 1 sample data. Run the sections in order, once.
-- Commit a return for LIB002. The NULL check only changes an open loan.
BEGIN;
UPDATE public.loan
SET returned_at = TIMESTAMPTZ '2026-10-17 12:00:00+00'
WHERE copy_id = (SELECT copy_id FROM public.book_copy WHERE barcode = 'LIB002')
  AND returned_at IS NULL;
COMMIT;

-- Try to record that return again. Expected: UPDATE 0, not a new return date.
UPDATE public.loan
SET returned_at = TIMESTAMPTZ '2026-10-18 12:00:00+00'
WHERE copy_id = (SELECT copy_id FROM public.book_copy WHERE barcode = 'LIB002')
  AND returned_at IS NULL;

-- Begin another transaction and add a valid loan for LIB003.
BEGIN;
INSERT INTO public.loan (member_id, copy_id, borrowed_at, due_at)
SELECT m.member_id, c.copy_id,
       TIMESTAMPTZ '2026-10-17 13:00:00+00', TIMESTAMPTZ '2026-10-24 13:00:00+00'
FROM public.member m CROSS JOIN public.book_copy c
WHERE m.membership_number = 'M001' AND c.barcode = 'LIB003';

-- This deliberate mistake makes the due date equal the borrowing date.
-- Expected: loan_due_after_borrowing error. Run ROLLBACK next.
UPDATE public.loan SET due_at = borrowed_at
WHERE copy_id = (SELECT copy_id FROM public.book_copy WHERE barcode = 'LIB003')
  AND returned_at IS NULL;
ROLLBACK;

-- The committed return remains; the loan added in the failed transaction is gone.
SELECT returned_at::date AS saved_return FROM public.loan
WHERE copy_id = (SELECT copy_id FROM public.book_copy WHERE barcode = 'LIB002');
SELECT count(*) AS lib003_loans FROM public.loan
WHERE copy_id = (SELECT copy_id FROM public.book_copy WHERE barcode = 'LIB003');
