# Step 11 Update the README and save Portfolio 1

Portfolio 1 is worth **7 marks**. Section 4 of the [assessment brief](https://lms-assets.miva.university/course-materials/mit-8103-advanced-database-systems-ca-september-cohort-2026.pdf) asks for the six items below. Check yours before starting Portfolio 2.

## 1. Update your existing Portfolio 1 README

In Step 4, you wrote the case study, users, operations, business rules and scope. Now add a short account of what you created and tested. Section 8 of the brief asks the README to explain implementation and testing.

1. In Codespaces Explorer, open `portfolio-1-database-design`.
2. Open **your** `Surname_Firstname_StudentID_P1_README.md`. This is not the README at the top of the repository.
3. Keep your existing description. Below `## Scope`, add the three sections shown below: **Design and implementation files**, **Implementation** and **Test results**.
4. If those sections already exist, update them instead of adding them twice.

Do not rerun the SQL.

### Library example: sections to add

This example uses the library results from Steps 8–10. For a different case study, use the prompt below rather than copying the library results.

```markdown
## Design and implementation files

| File | Contents |
| --- | --- |
| [Design](Harrison_Perete_202600001_P1_Design.md) | Entities, attributes, keys and relationships. |
| [ER diagram](Harrison_Perete_202600001_P1_ERDiagram.md) | The four tables and their relationships. |
| [Normalisation](Harrison_Perete_202600001_P1_Normalisation.md) | Example tables showing 1NF, 2NF and 3NF. |
| [Schema](Harrison_Perete_202600001_P1_Schema.sql) | Table definitions, keys and constraints. |
| [Sample records](Harrison_Perete_202600001_P1_SampleData.sql) | Fictional members, a book, copies and loans. |
| [Constraint tests](Harrison_Perete_202600001_P1_ConstraintTests.sql) | Invalid inserts and the final count query. |
| [Screenshots](screenshots/) | Saved commands and results. |

## Implementation

The database runs on PostgreSQL in GitHub Codespaces. Its name is library_portfolio. It contains member, book, book_copy and loan. Each table has a primary key. Foreign keys connect copies to books and loans to members and copies.

Membership numbers, emails, ISBNs and barcodes are unique. Date checks reject invalid loan dates. A unique partial index prevents two open loans for the same copy. The schema and sample records were committed before the invalid inserts were tested separately.

## Test results

Six invalid inserts were rejected: a missing name, repeated email, nonexistent book link, invalid due date, invalid return date and a second open loan for LIB001.

The final counts are 2 members, 1 book, 3 copies and 3 loans. The failed inserts added no rows. One loan is returned and two remain open.

The return-once workflow is not enforced by the table definitions alone. It needs transaction logic and testing in Portfolio 3.

Reference: [PostgreSQL constraints](https://www.postgresql.org/docs/16/ddl-constraints.html).
```

In `[Design](filename.md)`, replace `filename.md` with your exact filename. Keep `screenshots/` if that is your folder name. No separate evidence index is needed.

### Prompt for your own case study

Use this after completing Step 10. Supply your existing README, SQL files, filenames and actual results. Replace each bracketed instruction before sending the prompt.

```text
Help me update my existing MIT 8103 Portfolio 1 README after testing.
Follow the library example's three-section structure, not its library facts.

EXISTING README
[PASTE MY CURRENT PORTFOLIO 1 README]

FILES
[PASTE THE EXACT FILENAMES IN MY PORTFOLIO 1 FOLDER]

IMPLEMENTATION
[ATTACH MY SCHEMA, SAMPLE-DATA AND CONSTRAINT-TEST SQL FILES.
STATE MY DATABASE NAME AND WHERE POSTGRESQL RUNS.]

OBSERVED RESULTS
[PASTE THE OUTPUTS FROM MY TESTS AND FINAL ROW-COUNT QUERY.
STATE WHICH SCREENSHOTS I SAVED IN THE screenshots FOLDER.]

Return only these sections as Markdown to add below my existing Scope:
## Design and implementation files
## Implementation
## Test results

- First section: a two-column table, File and Contents. Link my existing
  design, ER diagram, normalisation, schema, sample-data and test files
  using their exact relative filenames. Link screenshots/ directly.
- Implementation: at most two short paragraphs describing my actual
  setup, tables, keys, constraints and how I ran the supplied tests.
- Test results: at most three short paragraphs describing the observed
  rejected or accepted records, final counts and any untested rules.
- Add a reference only for documentation actually used and supplied.
- Keep the language simple and suitable for an individual assessment.
- Do not rewrite my original case study, users, operations, rules or scope.
- Do not copy library names, counts or results unless they are mine.
- Do not invent files, screenshots, successful tests or execution steps.
- If essential input is missing or the results contradict the SQL, first
  list what needs checking and stop. Do not produce a completion claim.
- If these headings already exist, return replacement sections, not
  another copy of them. Do not add a new title or further sections.
```

Check the response against your terminal output before pasting it. A rejected insert must fail for the intended rule. If results are missing or unexpected, return to Step 10.

Save the file with **Cmd+S** on Mac or **Ctrl+S** on Windows.

## 2. Check the required work

| Requirement | What to check in your Portfolio 1 folder |
| --- | --- |
| Case study description | The README names the system, its users, the information stored and the main operations. |
| ER diagram | The diagram opens on GitHub. Its tables, fields and relationships match the design. |
| Relational schema | The Schema.sql file creates the agreed tables. |
| Keys | Each table has a primary key. Foreign keys connect the correct tables. |
| Constraints | Required fields, unique values and other rules match the design. Screenshots show the definitions and tests. |
| Normalisation explanation | Actual example tables show 1NF, 2NF and 3NF. The final tables match the schema. |

Also check that your screenshots are readable and use your filename prefix.

## 3. Save to GitHub

In the terminal with the `$` prompt, run each line separately. If you see `library_portfolio=#` instead, you are in PostgreSQL: use the other terminal for these Git commands.

```bash
git diff --check
git diff
git add portfolio-1-database-design/
git diff --cached --stat
git commit -m "Review Portfolio 1 documentation and evidence"
git push origin main
git status
```

Review `git diff`; press **q** to leave a scrolling view. Check the staged file list before committing. If there is nothing to commit, skip the commit command and continue with push and status.

Open your Portfolio 1 README on GitHub. Check that the new sections appear and every link opens. If a link fails, correct its filename or path in Codespaces, then save, commit and push again.

**Next: [Step 12 — Run useful SQL queries](12_Run_SQL_Queries.md).**

[Back to Step 10](10_Insert_And_Test_Data.md)
