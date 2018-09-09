TALK=JuliaCon2018_lapeyre
SHELL=/bin/bash

$(TALK): $(TALK).pdf clean

$(TALK).tex: $(TALK).md
	pandoc -f markdown -t beamer --variable urlcolor=cyan -s -o $(TALK).tex  $(TALK).md &> ./pandoc.log

$(TALK).pdf: $(TALK).tex
	pdflatex $(TALK).tex &> ./latex.log
	pdflatex $(TALK).tex &> ./latex.log

clean:
	-rm -f *.nav *.log *.aux *.toc *.vrb *.out *.snm
	-rm $(TALK).tex
