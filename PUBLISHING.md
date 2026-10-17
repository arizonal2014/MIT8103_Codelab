# Publishing the codelab

Read the tutorial: https://arizonal2014.github.io/MIT8103_Codelab/

The 19 numbered Markdown files are the tutorial source. Examples, images and the final summary are included. The library demonstration portfolio is separate: https://github.com/arizonal2014/Harrison_Perete_202600001.

To update the published tutorial after editing a source file:

```bash
npm ci
npm run build
```

Review the generated pages in `docs/`, then commit the edited source files and regenerated `docs/` files and push to `main`. GitHub Pages publishes from **main /docs**. Do not edit the generated HTML directly.

The build checks local links and keeps the SQL examples and screenshot filenames unchanged. It does not rerun the database exercises.
