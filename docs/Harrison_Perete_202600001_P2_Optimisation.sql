-- Run this setup once. The original library tables stay unchanged.
-- Keep the speed-test table in a named area called p2_benchmark.
CREATE SCHEMA p2_benchmark;

-- Create 100,000 made-up borrowing records automatically.
-- All use the existing member M001 and copy LIB001.
-- Borrowing times are an hour apart; each return is 30 minutes later.
-- These records are only for the speed test, not real borrowing activity.
CREATE TABLE p2_benchmark.loan_history AS
SELECT g AS loan_id, m.member_id, c.copy_id,
       TIMESTAMPTZ '2000-01-01 00:00:00+00' + g * INTERVAL '1 hour' AS borrowed_at,
       TIMESTAMPTZ '2000-01-01 00:00:00+00' + g * INTERVAL '1 hour' + INTERVAL '7 days' AS due_at,
       TIMESTAMPTZ '2000-01-01 00:00:00+00' + g * INTERVAL '1 hour' + INTERVAL '30 minutes' AS returned_at
FROM generate_series(1, 100000) AS g
CROSS JOIN public.member m CROSS JOIN public.book_copy c
WHERE m.membership_number = 'M001' AND c.barcode = 'LIB001';

-- Help PostgreSQL choose how to search the test table.
ANALYZE p2_benchmark.loan_history;

-- Check the data before comparing plans: 100000 rows, then 24 matching loans.
SELECT count(*) AS test_rows FROM p2_benchmark.loan_history;
SELECT count(*) AS loans_on_day FROM p2_benchmark.loan_history
WHERE borrowed_at >= TIMESTAMPTZ '2005-01-01 00:00:00+00'
  AND borrowed_at < TIMESTAMPTZ '2005-01-02 00:00:00+00';

-- BEFORE: run this SELECT with EXPLAIN four times.
-- Ignore the first warm-up time; record the next three Execution Time values.
EXPLAIN (ANALYZE, BUFFERS)
SELECT count(*) AS loans_on_day FROM p2_benchmark.loan_history
WHERE borrowed_at >= TIMESTAMPTZ '2005-01-01 00:00:00+00'
  AND borrowed_at < TIMESTAMPTZ '2005-01-02 00:00:00+00';

-- Add only this index. The rows and query stay the same.
CREATE INDEX loan_history_borrowed_at_idx
    ON p2_benchmark.loan_history (borrowed_at);

-- AFTER: run this identical SELECT with EXPLAIN four times.
-- Again ignore the warm-up and record three Execution Time values.
EXPLAIN (ANALYZE, BUFFERS)
SELECT count(*) AS loans_on_day FROM p2_benchmark.loan_history
WHERE borrowed_at >= TIMESTAMPTZ '2005-01-01 00:00:00+00'
  AND borrowed_at < TIMESTAMPTZ '2005-01-02 00:00:00+00';
