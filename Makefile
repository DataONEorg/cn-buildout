# Makefile for creating the DataONE CN build
# Matt Jones, 15 Dec 2009

# The list of packages to build
PKGS          = dataone-cn-os-core.deb dataone-cn-metacat.deb

# The temporary build output directory
BUILDDIR      = build

# The location of the the local APT repository used to store our built debs
APTREPOS      = /var/dataone/apt

# Location of the Packages.gz for this architecture
APTPKG        = $(APTREPOS)/dists/karmic/universe/binary-amd64

# Other settings
DPKG_DEB      = dpkg-deb
.SUFFIXES: .deb

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  deb       to make debian package files from control files"
	@echo "  clean     to remove the build directory"
	@echo "  publish   copy built deb packages to the local apt repository"
	@echo "  install   install all of the packages needed for the CN"

clean:
	-rm -rf $(BUILDDIR)

builddir:
	mkdir -p $(BUILDDIR)/sources

deb: builddir $(PKGS)

$(PKGS):
	cp -r $* $(BUILDDIR)/sources/$*
	find $(BUILDDIR)/sources/$* -name .svn | xargs rm -rf
	cd $(BUILDDIR)/sources && $(DPKG_DEB) -b $* ..

publish: deb
	cp $(BUILDDIR)/*.deb $(APTREPOS)
	cd $(APTREPOS) && dpkg-scanpackages . /dev/null | gzip -9c > $(APTPKG)/Packages.gz

install: publish
	@echo "Let's run apt-get install now."
	apt-get update
	apt-get install dataone-cn-metacat

