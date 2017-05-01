DOCS_TAG = master

CP ?= $(shell which cp)

ALL = \
	doc \
	assets/balde-logo.ico \
	assets/balde-logo.png \
	$(NULL)

all: $(ALL)

balde/artwork/balde-logo.ico: doc
balde/artwork/balde-logo.png: doc

assets/balde-logo.ico: balde/artwork/balde-logo.ico
	$(CP) $< $@

assets/balde-logo.png: balde/artwork/balde-logo.png
	$(CP) $< $@

doc:
	./build.sh . "$(DOCS_TAG)"

clean:
	rm -rf $(ALL)

clean-all: clean
	rm -rf balde

.PHONY: all clean clean-all
