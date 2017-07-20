all: cv

clean:
	rm -f *.out *.aux *.log *.bbl *.blg

cv: cv.tex cv.bib
	latexmk -pdf cv.tex
	bibtex cv
	latexmk -pdf cv.tex
	latexmk -pdf cv.tex
	latexmk -pdf cv.tex
