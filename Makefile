all: build

build:
	for f in *.applescript; do \
	    osacompile -o "$$(basename "$$f" .applescript).app" "$$f"; \
	done;

install: build
	mkdir -p ~/Library/Scripts/Applications/Finder; cp -r *.app $$_;
