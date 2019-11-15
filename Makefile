PLUGIN_NAME = easydb-barcode-display-pdf

EASYDB_LIB = easydb-library
L10N_FILES = l10n/$(PLUGIN_NAME).csv
L10N_GOOGLE_KEY = 1Z3UPJ6XqLBp-P8SUf-ewq4osNJ3iZWKJB83tc6Wrfn0
L10N_GOOGLE_GID = 1002482024
L10N2JSON = python $(EASYDB_LIB)/tools/l10n2json.py

INSTALL_FILES = \
	$(WEB)/l10n/cultures.json \
	$(WEB)/l10n/de-DE.json \
	$(WEB)/l10n/en-US.json \
	$(JS) \
	easydb-barcode-display-pdf.yml

COFFEE_FILES = \
	src/webfrontend/pdf-creator/node/BarcodeNode.coffee

all: build

include $(EASYDB_LIB)/tools/base-plugins.make

build: code $(L10N)

code: $(JS)

clean: clean-base

wipe: wipe-base
