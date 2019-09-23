INSTALL_ARGS := $(if $(PREFIX),--prefix $(PREFIX),)

all:
	dune build

install:
	dune install $(INSTALL_ARGS)

uninstall:
	dune uninstall $(INSTALL_ARGS)

reinstall: uninstall reinstall

test:
	dune runtest

clean:
	dune clean

.PHONY: all install uninstall reinstall test clean
