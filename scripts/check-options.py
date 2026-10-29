"""Compile representative public options in isolated temporary directories.

Run from any directory: python scripts/check-options.py
Requires Python 3 and latexmk on PATH. The user's main.tex is never edited.
"""
from pathlib import Path
import re
import shutil
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[1]
CASES = {
    "academic-electronic": "degree=academic,layout=electronic,subject=STEM,fontset=fandol",
    "professional-hss": "degree=professional,layout=electronic,subject=HSS,fontset=fandol,colorlinks=true,longtitle=true",
    "professional-print": "degree=professional,layout=print,subject=STEM,fontset=fandol",
    "custom-fonts": "degree=academic,layout=electronic,subject=STEM,fontset=none",
    "two-page-toc-print": "degree=academic,layout=print,subject=STEM,fontset=fandol",
    "two-page-toc-electronic": "degree=academic,layout=electronic,subject=STEM,fontset=fandol",
    "three-page-toc-print": "degree=academic,layout=print,subject=STEM,fontset=fandol",
}
source = (ROOT / "main.tex").read_text(encoding="utf-8")
for name, options in CASES.items():
    with tempfile.TemporaryDirectory(prefix="buaa-proposal-") as directory:
        work = Path(directory)
        for part in ("config", "chapters", "bibliography", "figures"):
            shutil.copytree(ROOT / part, work / part)
        for filename in ("buaa-proposal.cls", ".latexmkrc"):
            shutil.copy2(ROOT / filename, work / filename)
        variant, count = re.subn(
            r"\\documentclass\[.*?\]\{buaa-proposal\}",
            lambda _: "\\documentclass[" + options + "]{buaa-proposal}",
            source, count=1, flags=re.S,
        )
        if count != 1:
            raise RuntimeError("Could not locate the documentclass options in main.tex")
        expected_toc_pages = 1
        if name.startswith("two-page-toc"):
            variant = variant.replace(r"\input{chapters/02-literature}",
                                      r"\input{chapters/02-literature}" + "\n" +
                                      r"\addtocontents{toc}{\protect\newpage}")
            expected_toc_pages = 2
        if name == "three-page-toc-print":
            for chapter in ("01-background", "03-objectives"):
                command = r"\input{chapters/" + chapter + "}"
                variant = variant.replace(command, command + "\n" +
                                          r"\addtocontents{toc}{\protect\newpage}")
            expected_toc_pages = 3
        (work / "main.tex").write_text(variant, encoding="utf-8")
        if name == "professional-hss":
            with (work / "config/info.tex").open("a", encoding="utf-8") as stream:
                stream.write("\n\\ProposalSetup{title={面向复杂应用场景的方法设计与系统实现研究及其验证},co-supervisor={联合导师姓名\\quad 副教授},special-program={专项计划示例}}\n")
        if name == "custom-fonts":
            with (work / "config/packages.tex").open("a", encoding="utf-8") as stream:
                stream.write(r"""
\setCJKmainfont{FandolSong-Regular.otf}[BoldFont=FandolSong-Bold.otf]
\setCJKsansfont{FandolHei-Regular.otf}
\setCJKmonofont{FandolFang-Regular.otf}
\setCJKfamilyfont{zhsong}{FandolSong-Regular.otf}[BoldFont=FandolSong-Bold.otf]
\setCJKfamilyfont{zhhei}{FandolHei-Regular.otf}
\setCJKfamilyfont{zhkai}{FandolKai-Regular.otf}
\setCJKfamilyfont{zhfs}{FandolFang-Regular.otf}
""")
        result = subprocess.run(["latexmk", "-xelatex", "main.tex"], cwd=work,
                                stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        output = result.stdout.decode("utf-8", errors="replace")
        log = (work / "main.log").read_text(encoding="utf-8", errors="replace") if (work / "main.log").exists() else output
        if result.returncode or not (work / "main.pdf").exists():
            raise RuntimeError(name + " failed:\n" + output[-6000:])
        if re.search(r"undefined (?:references|citations)|Overfull \\[hv]box|Missing character:", log):
            raise RuntimeError(name + " has unresolved references, missing glyphs or overflowing content:\n" + log[-6000:])
        toc_count = re.search(r"BUAA-PROPOSAL-TOC-PAGES=(\d+)", log)
        if not toc_count or int(toc_count.group(1)) != expected_toc_pages:
            raise RuntimeError(f"{name}: expected {expected_toc_pages} TOC pages")
        if shutil.which("pdftotext"):
            text = subprocess.check_output(["pdftotext", "-layout", "main.pdf", "-"], cwd=work).decode("utf-8")
            pages = text.split("\f")
            if not pages[-1].strip():
                pages.pop()
            blank_pages = [i + 1 for i, page in enumerate(pages) if not page.strip()]
            printing = "layout=print" in options
            expected_blank = ([2] + ([3 + expected_toc_pages] if expected_toc_pages % 2 else [])) if printing else []
            if blank_pages != expected_blank:
                raise RuntimeError(f"{name}: blank pages {blank_pages}, expected {expected_blank}")
            if "SY0000000" not in pages[0] or "20XX" not in pages[0]:
                raise RuntimeError(name + ": cover information overflowed the first page")
            if "参考文献" not in pages[-1] or "lamport" not in pages[-1].casefold():
                raise RuntimeError(name + ": missing final bibliography")
            if "professional" in options and "专业学位硕士" not in pages[0]:
                raise RuntimeError(name + ": wrong degree on cover")
            body_page = 1 + int(printing) + expected_toc_pages + int(printing and expected_toc_pages % 2)
            if "本节填写" not in re.sub(r"\s+", "", pages[body_page]):
                raise RuntimeError(name + ": body did not start immediately after the expected front matter")
            print(f"{name}: OK ({len(pages)} pages; blank pages: {blank_pages})")
        else:
            print(name + ": compile OK (install Poppler for PDF content checks)")
