-- Fictional library records. Run once after creating the four empty tables.
BEGIN;

INSERT INTO public.member (membership_number, full_name, email)
VALUES ('M001', 'Ada James', 'ada@example.com'),
       ('M002', 'Ben Cole', 'ben@example.com');

INSERT INTO public.book (isbn, title)
VALUES ('9780385474542', 'Things Fall Apart');

-- Find the book's generated ID using its unique ISBN.
INSERT INTO public.book_copy (book_id, barcode)
VALUES ((SELECT book_id FROM public.book WHERE isbn = '9780385474542'), 'LIB001'),
       ((SELECT book_id FROM public.book WHERE isbn = '9780385474542'), 'LIB002'),
       ((SELECT book_id FROM public.book WHERE isbn = '9780385474542'), 'LIB003');

-- A returned loan: this copy can be borrowed again.
INSERT INTO public.loan (member_id, copy_id, borrowed_at, due_at, returned_at)
VALUES (
    (SELECT member_id FROM public.member WHERE membership_number = 'M001'),
    (SELECT copy_id FROM public.book_copy WHERE barcode = 'LIB001'),
    '2026-10-01 09:00+00', '2026-10-08 09:00+00', '2026-10-07 10:00+00'
);

-- Another member now has LIB001. LIB002 is also on loan; LIB003 is available.
INSERT INTO public.loan (member_id, copy_id, borrowed_at, due_at)
VALUES (
    (SELECT member_id FROM public.member WHERE membership_number = 'M002'),
    (SELECT copy_id FROM public.book_copy WHERE barcode = 'LIB001'),
    '2026-10-15 09:00+00', '2026-10-22 09:00+00'
), (
    (SELECT member_id FROM public.member WHERE membership_number = 'M001'),
    (SELECT copy_id FROM public.book_copy WHERE barcode = 'LIB002'),
    '2026-10-01 09:00+00', '2026-10-08 09:00+00'
);

COMMIT;
