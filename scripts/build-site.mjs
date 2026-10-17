// Compile the existing Markdown, examples and images into a static tutorial.
import fs from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { Marked } from 'marked';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const out = path.join(root, 'docs');
await fs.mkdir(out, { recursive: true });
const files = (await fs.readdir(root)).filter(f => f.endsWith('.md')).sort();
const steps = files.filter(f => /^\d\d_/.test(f));
if (steps.length !== 19) throw new Error('Expected all 19 codelab steps');
const esc = s => s.replaceAll('&','&amp;').replaceAll('<','&lt;').replaceAll('>','&gt;').replaceAll('"','&quot;');
const href = f => f === 'README.md' ? 'index.html' : f.replace(/\.md$/, '.html');
const titles = new Map();
for (const f of files) titles.set(f, (await fs.readFile(path.join(root,f),'utf8')).match(/^# (.+)/m)?.[1] ?? f);
const markdown = new Marked({ gfm: true });
const standardCode = markdown.defaults.renderer?.code;
markdown.use({ renderer: {
  code({ text, lang }) {
    if (lang === 'mermaid') return `<img src="images/Library_ERDiagram.svg" alt="Library ER diagram showing all four tables and relationships"><details><summary>Diagram source</summary><pre><code>${esc(text)}</code></pre></details>`;
    return `<pre><code class="language-${esc((lang ?? '').split(' ')[0])}">${esc(text)}</code></pre>`;
  }
}});
const style = await fs.readFile(path.join(root,'scripts/site.css'),'utf8');
await fs.writeFile(path.join(out,'site.css'), style);
const client = `document.querySelectorAll('pre').forEach(pre=>{const b=document.createElement('button');b.textContent='Copy';b.className='copy';b.type='button';b.setAttribute('aria-label','Copy this code block');b.onclick=async()=>{try{await navigator.clipboard.writeText(pre.querySelector('code').textContent);b.textContent='Copied';setTimeout(()=>b.textContent='Copy',1600)}catch{b.textContent='Select text to copy'}};pre.appendChild(b)});`;
await fs.writeFile(path.join(out,'site.js'), client);
for (const f of files) {
  const source = await fs.readFile(path.join(root,f),'utf8');
  let body = markdown.parse(source);
  // Rewrite rendered links only, never the commands and prompts in code blocks.
  body = body.replace(/href="([^"#]+\.md)(#[^"]*)?"/g, (all, target, fragment='') => /^https?:/.test(target) ? all : `href="${href(target)}${fragment}"`);
  const index = steps.indexOf(f);
  const current = index < 0 ? 'Contents' : `Step ${index+1} of 19`;
  const prev = index > 0 ? steps[index-1] : 'README.md';
  const next = index >= 0 && index < steps.length-1 ? steps[index+1] : index < 0 ? steps[0] : null;
  const pager = `<nav class="pager" aria-label="Step navigation"><a href="${href(prev)}">← ${index>0?'Previous':'Contents'}</a>${next?`<a href="${href(next)}">${index<0?'Start the codelab':'Next step'} →</a>`:'<a href="index.html">Back to contents</a>'}</nav>`;
  const sidebar = steps.map((s,i)=>`<a ${s===f?'aria-current="page"':''} href="${href(s)}"><span>${String(i+1).padStart(2,'0')}</span>${esc(titles.get(s).replace(/^Step \d+ /,''))}</a>`).join('');
  const html = `<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>${esc(titles.get(f))} | MIT 8103 Codelab</title><link rel="stylesheet" href="site.css"></head><body><header><a href="index.html">MIT 8103 <strong>Codelab</strong></a><a href="https://github.com/arizonal2014/MIT8103_Codelab">GitHub source ↗</a></header><div class="layout"><aside><details open><summary>All 19 steps</summary><nav aria-label="Codelab steps"><a href="index.html">Overview</a>${sidebar}</nav></details></aside><main id="main"><div class="eyebrow">${current} · Library Borrowing System</div>${pager}<article>${body}</article>${pager}<footer>Led by Perete Harrison · Use your own case study, records and results.</footer></main></div><script src="site.js" defer></script></body></html>`;
  await fs.writeFile(path.join(out,href(f)),html);
}
for (const folder of ['images','output']) await fs.cp(path.join(root,folder),path.join(out,folder),{recursive:true});
for (const f of await fs.readdir(root)) if (/\.(sql|js|list|jpg)$/.test(f)) await fs.copyFile(path.join(root,f),path.join(out,f));
await fs.writeFile(path.join(out,'.nojekyll'),'');

// Check every compiled local link and asset before publishing.
let checked = 0;
for (const f of files) {
  const html = await fs.readFile(path.join(out,href(f)),'utf8');
  for (const match of html.matchAll(/(?:href|src)="([^"#]+)(?:#[^"]*)?"/g)) {
    const target = match[1];
    if (/^(https?:|mailto:|data:)/.test(target)) continue;
    await fs.access(path.join(out,decodeURIComponent(target)));
    checked++;
  }
}
console.log(`Built ${files.length} pages, including all ${steps.length} steps. Checked ${checked} local links and assets.`);
