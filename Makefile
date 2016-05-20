DOCS_TAG = master

BLOGC_RUNSERVER ?= $(shell which blogc-runserver 2> /dev/null)
MKDIR ?= $(shell which mkdir)
CP ?= $(shell which cp)

BLOGC_RUNSERVER_HOST ?= 127.0.0.1
BLOGC_RUNSERVER_PORT ?= 8080

OUTPUT_DIR ?= _build

all: \
	$(OUTPUT_DIR)/index.html \
	$(OUTPUT_DIR)/doc \
	$(OUTPUT_DIR)/assets/main.css \
	$(OUTPUT_DIR)/assets/balde-logo.ico \
	$(OUTPUT_DIR)/assets/balde-logo.png \
	$(NULL)

$(OUTPUT_DIR)/index.html: index.html
	$(MKDIR) -p $(dir $@) && \
		$(CP) $< $@

$(OUTPUT_DIR)/assets/main.css: assets/main.css
	$(MKDIR) -p $(dir $@) && \
		$(CP) $< $@

balde/artwork/balde-logo.ico: $(OUTPUT_DIR)/doc
balde/artwork/balde-logo.png: $(OUTPUT_DIR)/doc

$(OUTPUT_DIR)/assets/balde-logo.ico: balde/artwork/balde-logo.ico
	$(MKDIR) -p $(dir $@) && \
		$(CP) $< $@

$(OUTPUT_DIR)/assets/balde-logo.png: balde/artwork/balde-logo.png
	$(MKDIR) -p $(dir $@) && \
		$(CP) $< $@

$(OUTPUT_DIR)/doc:
	./build.sh "$(OUTPUT_DIR)" "$(DOCS_TAG)"

ifneq ($(BLOGC_RUNSERVER),)
.PHONY: serve
serve: all
	$(BLOGC_RUNSERVER) \
		-t $(BLOGC_RUNSERVER_HOST) \
		-p $(BLOGC_RUNSERVER_PORT) \
		$(OUTPUT_DIR)
endif

clean:
	rm -rf "$(OUTPUT_DIR)"

clean-all: clean
	rm -rf balde

.PHONY: all clean clean-all
