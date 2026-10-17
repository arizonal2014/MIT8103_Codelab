-- Run each statement separately after SampleData.sql.
-- Each INSERT is deliberately invalid and should produce an ERROR.
-- Use the normal PostgreSQL prompt, outside BEGIN/COMMIT.

-- 1. A required full_name cannot be missing.
INSERT INTO public.member (membership_number, full_name, email)
VALUES ('TEST_NULL', NULL, 'missing@example.com');

-- 2. Ada's email cannot be used for another member.
INSERT INTO public.member (membership_number, full_name, email)
VALUES ('TEST_EMAIL', 'Test Member', 'ada@example.com');

-- 3. There is no book with ID -1 in this practice database.
INSERT INTO public.book_copy (book_id, barcode)
VALUES (-1, 'TEST_BAD_BOOK');

-- 4. Use available copy LIB003 so the date rule is the reason for rejection.
INSERT INTO public.loan (member_id, copy_id, borrowed_at, due_at)
VALUES (
    (SELECT member_id FROM public.member WHERE membership_number = 'M001'),
    (SELECT copy_id FROM public.book_copy WHERE barcode = 'LIB003'),
    '2026-10-20 09:00+00', '2026-10-19 09:00+00'
);

-- 5. A return cannot be earlier than the borrowing time.
INSERT INTO public.loan (member_id, copy_id, borrowed_at, due_at, returned_at)
VALUES (
    (SELECT member_id FROM public.member WHERE membership_number = 'M001'),
    (SELECT copy_id FROM public.book_copy WHERE barcode = 'LIB003'),
    '2026-10-20 09:00+00', '2026-10-27 09:00+00', '2026-10-19 09:00+00'
);

-- 6. LIB001 already has an open loan, so another one must be rejected.
INSERT INTO public.loan (member_id, copy_id, borrowed_at, due_at)
VALUES (
    (SELECT member_id FROM public.member WHERE membership_number = 'M001'),
    (SELECT copy_id FROM public.book_copy WHERE barcode = 'LIB001'),
    '2026-10-17 09:00+00', '2026-10-24 09:00+00'
);

-- Failed inserts must not change these counts: member 2, book 1, copies 3, loans 3.
SELECT 'member' AS table_name, count(*) AS row_count FROM public.member
UNION ALL SELECT 'book', count(*) FROM public.book
UNION ALL SELECT 'book_copy', count(*) FROM public.book_copy
UNION ALL SELECT 'loan', count(*) FROM public.loan;
