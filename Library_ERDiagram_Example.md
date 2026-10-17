# Library Borrowing System ER Diagram

This diagram shows the four tables, their fields and how they connect.

```mermaid
erDiagram
    direction LR
    book ||--o{ book_copy : has
    member ||--o{ loan : borrows
    book_copy ||--o{ loan : appears_in

    member {
        bigint member_id PK
        varchar(30) membership_number UK
        varchar(120) full_name
        varchar(254) email UK
    }
    book {
        bigint book_id PK
        varchar(17) isbn UK
        varchar(200) title
    }
    book_copy {
        bigint copy_id PK
        bigint book_id FK
        varchar(30) barcode UK
    }
    loan {
        bigint loan_id PK
        bigint member_id FK
        bigint copy_id FK
        timestamptz borrowed_at
        timestamptz due_at
        timestamptz returned_at "Optional until returned"
    }
```

## Reading the diagram

- **PK** identifies one record. **FK** links to another table. **UK** means a value is unique.
- `||` means exactly one. `o{` means zero or many.
- A book can have zero or many physical copies. Each copy belongs to one book.
- A member can have zero or many loans. Each loan belongs to one member.
- A copy can appear in zero or many loans over time. Each loan refers to one copy.

For example, copy 10 can be borrowed in January and again in February. These are two separate loan records.

All fields are required except returned_at. The diagram shows loan history; the separate rule allowing only one open loan per copy is covered in the database design. Date checks and return rules are also described there.
