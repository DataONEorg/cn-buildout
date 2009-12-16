# Makefile for creating the DataONE CN build
#

# You can set these variables from the command line.
BUILDDIR      = build
DPKG_DEB      = dpkg-deb

.PHONY: help clean deb builddir

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  deb       to make debian package files from control files"
	@echo "  clean     to remove the build directory"

clean:
	-rm -rf $(BUILDDIR)/*

builddir:
	mkdir -p $(BUILDDIR)

deb: builddir
	$(DPKG_DEB) -b dataone-cn-os-core $(BUILDDIR)
	@echo "Building deb finished. The packages are in $(BUILDDIR)."
