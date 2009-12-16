# Makefile for creating the DataONE CN build
# Matt Jones, 15 Dec 2009

# The list of packages to build
PKGS          = dataone-cn-os-core.deb dataone-cn-metacat.deb

# The output directory for debian files
BUILDDIR      = build

# Other settings
DPKG_DEB      = dpkg-deb
.SUFFIXES: .deb

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  deb       to make debian package files from control files"
	@echo "  clean     to remove the build directory"

clean:
	-rm -rf $(BUILDDIR)

builddir:
	mkdir -p $(BUILDDIR)

deb: builddir $(PKGS)

$(PKGS):
	$(DPKG_DEB) -b $* $(BUILDDIR)
