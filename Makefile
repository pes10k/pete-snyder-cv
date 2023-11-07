all: cv

clean:
	rm -f *.out *.aux *.log *.bbl *.blg

copy:
	cp cv.pdf ~/Sites/personal-site-env/personal-site/static/misc/peter-snyder-cv.pdf

cv: cv.tex cv.bib
	latexmk -pdf cv.tex
	bibtex cv
	latexmk -pdf cv.tex
	latexmk -pdf cv.tex
	latexmk -pdf cv.tex
