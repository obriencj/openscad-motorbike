

SOURCES = $(wildcard *.scad)


OPENSCAD = openscad


default: all


all: $(SOURCES:.scad=.stl)


clean:
	$(RM) *.stl


%.stl: %.scad
	$(OPENSCAD) $< -o $@


# The end.
