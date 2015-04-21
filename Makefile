BIND := ./node_modules/.bin
MOCHA ?= $(BIND)/mocha

build: clean
	rsync -rupE icons build/
	cp index.html build/
	cp index.js build/
	cp manifest.json build/
	zip -r build/build.zip build/*

clean:
	@rm -rf build/
	@echo "clean done!"

test:
	@$(MOCHA) -u exports ./test.js


.PHONY: jslint, build, test
