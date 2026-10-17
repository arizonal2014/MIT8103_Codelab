-- Library borrowing system: four tables from the agreed design.
-- Run once in the empty library_portfolio database.
BEGIN;

-- Each member has a separate ID, membership number and email.
CREATE TABLE public.member (
    member_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    membership_number VARCHAR(30) NOT NULL UNIQUE,
    full_name VARCHAR(120) NOT NULL,
    email VARCHAR(254) NOT NULL UNIQUE
);

-- Store the edition details once, even when there are several copies.
CREATE TABLE public.book (
    book_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    isbn VARCHAR(17) NOT NULL UNIQUE,
    title VARCHAR(200) NOT NULL
);

-- The barcode identifies the physical copy, not the book edition.
CREATE TABLE public.book_copy (
    copy_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    book_id BIGINT NOT NULL,
    barcode VARCHAR(30) NOT NULL UNIQUE,
    CONSTRAINT book_copy_book_fk
        FOREIGN KEY (book_id) REFERENCES public.book (book_id)
);

-- Each loan links one member to one copy. A missing return date means open.
CREATE TABLE public.loan (
    loan_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    member_id BIGINT NOT NULL,
    copy_id BIGINT NOT NULL,
    borrowed_at TIMESTAMPTZ NOT NULL,
    due_at TIMESTAMPTZ NOT NULL,
    returned_at TIMESTAMPTZ,
    CONSTRAINT loan_member_fk
        FOREIGN KEY (member_id) REFERENCES public.member (member_id),
    CONSTRAINT loan_copy_fk
        FOREIGN KEY (copy_id) REFERENCES public.book_copy (copy_id),
    CONSTRAINT loan_due_after_borrowing
        CHECK (due_at > borrowed_at),
    CONSTRAINT loan_return_not_before_borrowing
        CHECK (returned_at IS NULL OR returned_at >= borrowed_at)
);

-- Check only open loans: the same copy cannot be lent twice at once.
-- Closed loans are kept, so a copy can be borrowed again later.
CREATE UNIQUE INDEX loan_one_open_copy
    ON public.loan (copy_id)
    WHERE returned_at IS NULL;

COMMIT;
