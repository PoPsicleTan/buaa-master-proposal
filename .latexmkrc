# XeLaTeX + BibTeX. Keeping output in the root also works on Overleaf.
$pdf_mode = 5;
$xelatex = 'xelatex -interaction=nonstopmode -halt-on-error -file-line-error %O %S';
$bibtex_use = 2;
