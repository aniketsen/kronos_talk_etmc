NAMES=presentation handout

title=rename_me

all: $(addprefix ${title}_, $(addsuffix .pdf, $(NAMES)))

$(addsuffix .pdf, $(NAMES)): $(addsuffix .tex, $(NAMES)) talk.tex Makefile graphics/*.pdf
	latexmk -shell-escape -pdf -pdflatex="lualatex -interaction=nonstopmode" -use-make $(subst .pdf,.tex,$@)

${title}_presentation.pdf: presentation.pdf Makefile
	cp $< $@

${title}_handout.pdf: handout.pdf Makefile
	cp $< $@

clean:
	latexmk -f -c
	rm -f ${title}_handout.pdf ${title}_presentation.pdf
	rm -rf _minted*

distclean:
	latexmk -f -CA
	rm -f $(addsuffix .pdf,$(NAMES))
	rm -f $(addsuffix .nav,$(NAMES))
	rm -f $(addsuffix .snm,$(NAMES))
	rm -f talk.nav
	rm -f talk.snm
