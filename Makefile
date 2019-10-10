

TOPTARGETS := all clean


SUBDIRS := motorbike


$(TOPTARGETS): $(SUBDIRS)


$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)


.PHONY: $(TOPTARGETS) $(SUBDIRS)


default: all


# The end.
