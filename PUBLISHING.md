# Publishing the codelab

Read and share the tutorial now: https://github.com/arizonal2014/MIT8103_Codelab#readme

The GitHub guide is the primary shared version. Its README links to all 19 steps, and each step links to the next. No custom domain is needed.

The 19 numbered Markdown files are the tutorial source. Examples, images and the final summary are included. The library demonstration portfolio is separate: https://github.com/arizonal2014/Harrison_Perete_202600001.

To update the published tutorial after editing a source file:

```bash
npm ci
npm run build
```

Review the generated pages in `docs/`, then commit the edited source files and regenerated `docs/` files and push to `main`. Share the GitHub URL above. The compiled HTML is also retained for optional static hosting; do not edit it directly.

The build checks local links and keeps the SQL examples and screenshot filenames unchanged. It does not rerun the database exercises.
