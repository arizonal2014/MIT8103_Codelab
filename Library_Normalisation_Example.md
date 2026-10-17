# Library Borrowing System Normalisation

Normalisation separates information into related tables to reduce repeated details and avoid inconsistent updates. The same three loans are used below. Only the fields needed to explain the changes are shown; the full design keeps the other fields from the design document.

Dates are shortened for readability. borrowed_at represents the full borrowing date and time. Names and emails are fictional.

## Starting borrowing list

| member_id | full_name | email | Borrowed copies |
| --- | --- | --- | --- |
| 1 | Ada James | ada@example.com | Copy 10: book 5, Things Fall Apart, borrowed 2026-10-01, due 2026-10-08; Copy 11: book 5, Things Fall Apart, borrowed 2026-10-01, due 2026-10-08 |
| 2 | Ben Cole | ben@example.com | Copy 10: book 5, Things Fall Apart, borrowed 2026-10-15, due 2026-10-22 |

The first row contains two borrowings in one cell. Finding one loan or recording its return is awkward. Copy 10's first loan ends before its second borrowing.

## 1NF: One value per cell

Each borrowing has its own row. The repeated list is removed.

| copy_id | borrowed_at | member_id | full_name | email | book_id | title | due_at |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 10 | 2026-10-01 | 1 | Ada James | ada@example.com | 5 | Things Fall Apart | 2026-10-08 |
| 11 | 2026-10-01 | 1 | Ada James | ada@example.com | 5 | Things Fall Apart | 2026-10-08 |
| 10 | 2026-10-15 | 2 | Ben Cole | ben@example.com | 5 | Things Fall Apart | 2026-10-22 |

For this example, the key is **(copy_id, borrowed_at)**. Both values together identify one borrowing, assuming a copy cannot be borrowed twice at the exact same instant. copy_id alone is not enough: copy 10 appears twice.

The rows are in 1NF, but the book title is repeated. Correcting its spelling requires changing every related row.

## 2NF: Details depend on the whole key

2NF includes 1NF. A non-key field must not depend on only part of a combined key.

Here, **copy_id alone determines book_id and title**. Those details belong to the copy, regardless of when it is borrowed. They move into a separate table.

### Copy details

Key: **copy_id**.

| copy_id | book_id | title |
| --- | --- | --- |
| 10 | 5 | Things Fall Apart |
| 11 | 5 | Things Fall Apart |

### Borrowing details

Key: **(copy_id, borrowed_at)**. copy_id links to Copy details.

| copy_id | borrowed_at | member_id | full_name | email | due_at |
| --- | --- | --- | --- | --- | --- |
| 10 | 2026-10-01 | 1 | Ada James | ada@example.com | 2026-10-08 |
| 11 | 2026-10-01 | 1 | Ada James | ada@example.com | 2026-10-08 |
| 10 | 2026-10-15 | 2 | Ben Cole | ben@example.com | 2026-10-22 |

The book details no longer repeat for every borrowing of a copy. However, the title still repeats across copies, and Ada's email still repeats across her loans.

## 3NF: Keep details with the thing they describe

3NF includes 2NF. Non-key fields must not depend on another non-key field. Two remaining links explain the next split:

- **book_id determines title**: the title describes the book, not the physical copy.
- **member_id determines full_name and email**: these describe the member, not the borrowing.

### book

Key: **book_id**.

| book_id | title |
| --- | --- |
| 5 | Things Fall Apart |

### book_copy

Key: **copy_id**. book_id is a foreign key to book.

| copy_id | book_id |
| --- | --- |
| 10 | 5 |
| 11 | 5 |

### member

Key: **member_id**.

| member_id | full_name | email |
| --- | --- | --- |
| 1 | Ada James | ada@example.com |
| 2 | Ben Cole | ben@example.com |

### loan

The final design uses **loan_id** as its primary key, rather than relying on a borrowing time to identify a loan. member_id and copy_id are foreign keys. Adding an ID is a design choice, not what makes a table 3NF.

| loan_id | member_id | copy_id | borrowed_at | due_at |
| --- | --- | --- | --- | --- |
| 100 | 1 | 10 | 2026-10-01 | 2026-10-08 |
| 101 | 1 | 11 | 2026-10-01 | 2026-10-08 |
| 102 | 2 | 10 | 2026-10-15 | 2026-10-22 |

Now Ada's email is stored once in member, and the book title is stored once in book. The IDs preserve the links, so the borrowing details can still be brought together when needed.

These are the four tables in the ER diagram. The complete schema also includes membership_number, isbn, barcode and returned_at. Unique values, date checks and the one-open-loan rule remain necessary; normalisation does not enforce those rules by itself.
