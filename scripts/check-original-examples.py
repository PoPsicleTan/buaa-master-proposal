"""Verify that retained original chapters, figures and bibliography are unchanged."""
from pathlib import Path
import hashlib
import json
import re
import shutil
import subprocess
import sys

root = Path(__file__).resolve().parents[1]
manifest = json.loads((root / 'examples/SOURCES.json').read_text(encoding='utf-8'))
for entry in manifest['files']:
    path = root / entry['path']
    if not path.is_file():
        raise SystemExit('Missing original example: ' + entry['path'])
    if hashlib.sha256(path.read_bytes()).hexdigest() != entry['sha256']:
        raise SystemExit('Original example was changed: ' + entry['path'])
print(f"Original example snapshots: OK ({len(manifest['files'])} files)")
if '--compiled' in sys.argv:
    log = (root / 'examples-original.log').read_text(encoding='utf-8', errors='replace')
    if re.search(r'undefined (?:references|citations)|Missing character:|Overfull \\[hv]box', log):
        raise SystemExit('Original example has unresolved references, missing glyphs or overflowing content')
    if shutil.which('pdftotext'):
        text = subprocess.check_output(['pdftotext', '-layout', str(root / 'examples-original.pdf'), '-']).decode('utf-8')
        pages = text.split('\f')
        if not pages[-1].strip():
            pages.pop()
        toc = int(re.search(r'BUAA-PROPOSAL-TOC-PAGES=(\d+)', log).group(1))
        expected = [2] + ([toc + 3] if toc % 2 else [])
        body_index = 2 + toc + toc % 2
        blanks = [i + 1 for i, page in enumerate(pages[:body_index]) if not page.strip()]
        if blanks != expected or '这是北航论文' not in re.sub(r'\s+', '', pages[body_index]):
            raise SystemExit('Original example front-matter pagination is incorrect')
        print(f'Original example PDF: OK ({len(pages)} pages; TOC: {toc} pages; front-matter blanks: {blanks})')
