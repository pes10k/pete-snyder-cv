all: cv

clean:
	rm -f *.out *.aux *.log *.bbl *.blg

cv: cv.tex cv.bib
	pdflatex cv.tex
	bibtex cv
	pdflatex cv.tex
	pdflatex cv.tex
	pdflatex cv.tex
