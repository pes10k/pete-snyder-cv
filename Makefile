all: cv

clean:
	rm -f *.out *.aux *.log *.bbl *.blg

research: research.tex bib.bib
	pdflatex research.tex
	bibtex research
	pdflatex research.tex
	pdflatex research.tex
	pdflatex research.tex

cv: cv.tex bib.bib
	pdflatex cv.tex
	bibtex cv
	pdflatex cv.tex
	pdflatex cv.tex
	pdflatex cv.tex

combined: research.pdf teaching.pdf
	gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=statements.pdf teaching.pdf research.pdf
