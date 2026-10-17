# Step 19 Prepare the final 2-3-page summary

Final documentation is worth **6 marks**. Sections 4 and 6 of the [assessment brief](https://lms-assets.miva.university/course-materials/mit-8103-advanced-database-systems-ca-september-cohort-2026.pdf) ask for a **2-3-page summary** of all five activities, your selected case study, GitHub link and supporting evidence. Sections 8 and 11 require an individual technical reflection and acknowledgement of sources and AI assistance where used.

The summary explains the work. Keep the full SQL, scripts and screenshot collections in GitHub.

## 1. Open the library example

Read the [worked summary](Harrison_Perete_202600001_FinalSummary.md), or open its [three-page PDF](output/pdf/Harrison_Perete_202600001_FinalSummary.pdf).

It uses the results already recorded in the codelab. For example, Portfolio 2 returns **24** before and after indexing, while the median times change from **7.941 ms** to **0.039 ms**. Portfolio 5 describes a proposal, not an implemented replica set.

Use the structure, not the library's results or reflection. Your measurements may differ.

## 2. Create your summary

Open Word or Google Docs and create a blank document. Start with your name, student ID, case-study title and GitHub repository link. Use these headings:

```text
Case study
Portfolio 1: Database Design and Modelling
Portfolio 2: Query Processing and Optimisation
Portfolio 3: Transactions and Concurrency
Portfolio 4: NoSQL and Advanced Data Models
Portfolio 5: Distributed and Cloud Database Exercise
Evidence
Individual reflection
References
AI-use declaration
```

A simple three-page layout:

| Page | What to include |
| --- | --- |
| 1 | Your details, case study, Portfolio 1 and a readable ER diagram |
| 2 | Portfolios 2-4, including a small before/after results table |
| 3 | Portfolio 5, evidence links, your reflection, references and AI declaration |

This layout is a suggestion, not an extra assessment rule. Use readable 11-12-point text. Do not add a separate cover page. Check the exported PDF's page count, not just the word count.

For each portfolio, state **what you did, the main result and what it means**. Example: “The second insert waited, then failed after the first session committed. The unique index prevented two open loans for LIB003.”

Reuse existing evidence. Link to the correct portfolio folders or individual screenshot files; do not take new screenshots just for this step. If an LMS field specifically requests an embedded image, use a clear existing image with a short caption. Keep it readable and within the page limit.

## 3. Write your own reflection and declaration

Write about **one design choice, one difficulty, what you did and what you learned**. A short paragraph is enough. Use something you actually experienced.

For example, if this happened in your run: “Session B waited, so I checked the other session and found it had not committed. After the commit, B received a duplicate-key error. This helped me understand why checking availability is not enough.” Do not use this as a personal claim if it did not happen to you.

For the AI declaration, this is **sample wording if AI provided guidance and you executed the work yourself**. Replace the tool name and adapt the description to what really happened:

```text
I used [AI tool name] to explain database concepts and help review the
structure and wording of my portfolio. I executed the database commands
myself, checked the results against the assessment requirements and
corrected issues before submission. I understand the work and remain
responsible for its accuracy.
```

Include assistance with scripts, analysis or execution if it was used. Do not claim that you ran or checked something unless you did. If you used no AI, state that only if true.

Add your ER diagram from Portfolio 1 beneath the design section. On GitHub, open its rendered preview, take a screenshot of the diagram, then insert that image in Word or Google Docs. Crop out unrelated browser controls if needed, but keep every table and relationship readable. The library PDF includes a clean rendering of the same four-table design; no diagram code belongs in the summary.

## 4. Prompt for your own case study

Attach the five portfolio READMEs, your result tables or outputs, and the assessment brief. Copy your repository URL into the prompt. No passwords or connection secrets are needed.

```text
Help me prepare the MIT 8103 final portfolio summary.

MY DETAILS
Name: [MY NAME]
Student ID: [MY STUDENT ID]
Repository: [MY GITHUB URL]

MY WORK
[ATTACH MY FIVE PORTFOLIO READMES, RESULTS AND THE ASSESSMENT BRIEF.]

MY OWN REFLECTION NOTES
Design choice: [ONE CHOICE I MADE AND WHY]
Difficulty: [SOMETHING I FOUND DIFFICULT]
Action: [WHAT I DID ABOUT IT]
Lesson: [WHAT I LEARNED]

MY AI USE
Tools: [TOOLS USED, OR NONE]
Help received: [WHAT THEY ACTUALLY HELPED WITH]
My verification: [WHAT I PERSONALLY REVIEWED, RAN OR CORRECTED]

Use the title "MIT 8103 Advanced Database Systems: Portfolio Summary"
and include my case-study name, name, student ID and repository URL.
Use exactly these headings:
Case study
Portfolio 1: Database Design and Modelling
Portfolio 2: Query Processing and Optimisation
Portfolio 3: Transactions and Concurrency
Portfolio 4: NoSQL and Advanced Data Models
Portfolio 5: Distributed and Cloud Database Exercise
Evidence
Individual reflection
References
AI-use declaration

Use simple language. Aim for about 900-1,100 words, including references,
then I will check that the exported document fits 2-3 readable pages.
This word range is guidance, not an assessment requirement.

Summarise what was done, a verified result and its meaning for each
portfolio. Include a small before/after table using my actual measured
plans and times. Preserve the units and explain measurement limits.
Distinguish earlier database states from later transaction changes.
Clearly label proposed distributed designs and tests not performed.
Link to my actual GitHub evidence; do not invent screenshot filenames.
Use references already consulted in my portfolios, with in-text citations.

Use only my reflection notes for the reflection. If they are blank,
ask me for one short answer at a time; do not invent my experience.
Likewise, do not invent personal verification or hide assistance in
the AI declaration. If results are missing or inconsistent, ask for
the relevant existing file or output before drafting that section.
Do not copy the library example's results into my different case study.
Return the document text only, with no teaching notes or extra sections.
```

Compare the draft with your actual outputs. Correct mismatches before exporting. Only cite sources you used; add any external code, datasets or tutorial material that informed your work.

## 5. Export, name and save

1. Save the editable document as `Surname_Firstname_StudentID_FinalSummary.docx`, using your own details. In Google Docs, rename the document, then use **File → Download → Microsoft Word (.docx)** if you need an editable local copy.
2. Export a PDF. Word: **File → Save As/Export → PDF**. Google Docs: **File → Download → PDF Document (.pdf)**.
3. Name it `Surname_Firstname_StudentID_FinalSummary.pdf`. Open it and confirm it has **2 or 3 pages**, readable text, working links and no unfinished brackets or example identity.
4. In Codespaces Explorer, right-click your repository's top-level folder → **Upload…**. Upload the PDF. You may also upload the editable copy. Neither file belongs inside the question PDF.

For the demo, the files are `Harrison_Perete_202600001_FinalSummary.md` and `Harrison_Perete_202600001_FinalSummary.pdf`. The Markdown is an editable source; students can write directly in Word or Google Docs instead.

Use the `$` terminal, replacing the filename with yours. Run each line separately:

```bash
git status
git add Harrison_Perete_202600001_FinalSummary.pdf
git diff --cached --stat
git commit -m "Add final portfolio summary"
git push origin main
git status
```

If you also uploaded an editable copy, stage its exact filename before the commit. Check that the staged files contain no credentials or unrelated documents.

**Expected result:** the summary appears at the top level of your GitHub repository, and Git reports a clean working tree after all intended files are committed. Open the PDF on GitHub to check it.

If the export exceeds three pages, remove repeated details and long SQL blocks rather than shrinking the text. If a link fails, copy its actual GitHub URL and export again.

## 6. Before submission

Confirm the summary covers all five activities, your reflection and sources, and that the assessor can access the repository. Section 5 specifies a **private student repository**; give the assessor access as instructed. The public library repository is a demonstration, not a change to that requirement.

Follow the current LMS/form instructions for the required upload format. Submit your own final document, not this worked example. The supplied submission instructions allow **one attempt**, so review the actual upload before submitting.

## What you built

You now have five related database activities, their practical evidence and a short document that directs the assessor to the work. The final task is to review your own files and submit through the stated LMS/form route.

[Back to Step 18](18_Explain_Distributed_And_Cloud_Databases.md)
