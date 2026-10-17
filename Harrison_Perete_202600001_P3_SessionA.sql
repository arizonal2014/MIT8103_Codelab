-- Follow the codelab's order across TWO terminals. Do not run this whole file at once.
-- A1: Use the first PostgreSQL terminal, after the transaction examples.
SET application_name = 'p3_session_a';
BEGIN ISOLATION LEVEL READ COMMITTED;
SHOW transaction_isolation;
INSERT INTO public.loan (member_id, copy_id, borrowed_at, due_at)
SELECT m.member_id, c.copy_id,
       TIMESTAMPTZ '2026-10-17 14:00:00+00', TIMESTAMPTZ '2026-10-24 14:00:00+00'
FROM public.member m CROSS JOIN public.book_copy c
WHERE m.membership_number = 'M002' AND c.barcode = 'LIB003';
-- STOP. Leave this transaction open. Run B1 in the second terminal now.

-- A2: After Session B's INSERT is waiting, run this in Session A.
SELECT application_name, wait_event_type FROM pg_stat_activity
WHERE application_name = 'p3_session_b';
-- Expected: p3_session_b | Lock. Take the waiting screenshot, then continue.
COMMIT;
-- Switch to Session B: its INSERT should now fail on loan_one_open_copy.
