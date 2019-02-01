# This work is dedicated to the public domain.

texargs = -interaction nonstopmode -halt-on-error -file-line-error

default: mthesis.pdf # default target if you just type "make"


# Resources and rules for the introductory chapter. Sample 'make' rule
# included to show how you can process data as you compile your thesis
# using standard GNU make constructs.

deps += intro/intro.tex 
cleans += intro/intro.aux

# intro/processed.tex: intro/sample.tex
# 	sed -e s/terrible/wonderful/ $< >$@

# Chapter Two

deps += methods_PS/methods_PS.tex
cleans += methods_PS/methods_PS.aux

# Chapter Three

deps += PSA64/PSA64.tex
cleans += PSA64/PSA64.aux

# Chapter Four
deps += PSA128/PSA128.tex
cleans += PSA128/PSA128.aux

# Chapter Five
deps += Future/Future.tex
cleans += Future/Future.aux

# Conclusion
deps += conclusion/conclusion.tex
cleans += conclusion/conclusion.aux

# The thesis itself. We move the PDF to a new filename so that viewers
# don't keep on trying to reload the file as it's being written and
# rewritten by pdfLaTeX.

deps += myucthesis.cls uct12.clo aasmacros.sty mydeluxetable.sty \
  setup.tex thesis.bib yahapj.bst
cleans += thesis.aux thesis.bbl thesis.blg thesis.lof thesis.log \
  thesis.lot thesis.out thesis.toc mthesis.pdf setup.aux
toplevels += mthesis.pdf

mthesis.pdf: thesis.tex $(deps)
	pdflatex $(texargs) $(basename $<) >chatter.txt
	bibtex $(basename $<)
	pdflatex $(texargs) $(basename $<) >chatter.txt
	pdflatex $(texargs) $(basename $<) >chatter.txt
	mv thesis.pdf $@


# Approval page

cleans += approvalpage.aux approvalpage.log approvalpage.pdf
toplevels += approvalpage.pdf

approvalpage.pdf: approvalpage.tex $(deps)
	pdflatex $(texargs) $(basename $<)


# Helpers

all: $(toplevels)

clean:
	-rm -f $(cleans)
