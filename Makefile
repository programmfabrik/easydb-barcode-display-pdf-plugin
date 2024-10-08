PLUGIN_NAME = easydb-barcode-display-pdf
PLUGIN_PATH = easydb-barcode-display-pdf-plugin

EASYDB_LIB = easydb-library
L10N_FILES = l10n/$(PLUGIN_NAME).csv
L10N_GOOGLE_KEY = 1Z3UPJ6XqLBp-P8SUf-ewq4osNJ3iZWKJB83tc6Wrfn0
L10N_GOOGLE_GID = 1002482024

INSTALL_FILES = \
	$(WEB)/l10n/cultures.json \
	$(WEB)/l10n/de-DE.json \
	$(WEB)/l10n/en-US.json \
	$(JS) \
	manifest.yml

COFFEE_FILES = src/webfrontend/pdf-creator/node/BarcodeNode.coffee

all: build

include $(EASYDB_LIB)/tools/base-plugins.make

build: code $(L10N) buildinfojson

code: $(JS)

clean: clean-base

wipe: wipe-base
