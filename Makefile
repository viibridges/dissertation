TARGET = dissertation 
CLEANFILES = *.aux *.bak *.brf *.bbl *.blg *.lof *.log *.lot *.out *.pdf *.toc *.fdb_latexmk *.fls

all: auto

auto:
	latexmk -pdf -pvc $(TARGET)

pdf:
	pdflatex $(TARGET)
	bibtex $(TARGET)
	@ find . -maxdepth 1 -name "*.aux" -exec bibtex {} \;
	pdflatex $(TARGET)
	pdflatex $(TARGET)

clean:
	find . \
	-not \( -path "./images" -prune \) \
	-not \( -path "./.git" -prune \) \
	-type  d \
	-exec sh -c 'cd "{}" && rm -f $(CLEANFILES)' \;

spell:
	find . -name \*.tex -exec aspell -ttex -c '{}' \;
