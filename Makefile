# Makefile for creating the DataONE CN build
# Matt Jones, 15 Dec 2009

# The list of packages to build
PKGS          = dataone-cn-os-core.deb dataone-cn-metacat.deb dataone-cn-mercury.deb dataone-cn-rest-service.deb

# The temporary build output directory
BUILDDIR      = build

# The location of the the local APT repository used to store our built debs
APTREPOS      = /var/dataone/apt

# Location of the Packages.gz for this architecture
APTPKG        = $(APTREPOS)/dists/karmic/universe/binary-amd64


TESTCRT = $(shell /bin/sh -c '/usr/bin/test -e /etc/ssl/certs/dataone.org.crt; echo $$?')


#HELLO = $(shell ls /etc)
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
	-rm ${APTREPOS}/*.deb

builddir: clean
	mkdir -p $(BUILDDIR)/sources

deb: builddir $(PKGS)

$(PKGS):
	cp -r $* $(BUILDDIR)/sources/$*
	find $(BUILDDIR)/sources/$* -name .svn | xargs rm -rf
	cd $(BUILDDIR)/sources && $(DPKG_DEB) -b $* ..

publish: deb
	cp -f $(BUILDDIR)/*.deb $(APTREPOS)
	cd $(APTREPOS) && dpkg-scanpackages . /dev/null | gzip -9c > $(APTPKG)/Packages.gz

install: publish
	@echo "Let's run apt-get install now."
	apt-get update
	apt-get install dataone-cn-rest-service dataone-cn-metacat dataone-cn-mercury

install-dev: publish
	@echo "Let's run apt-get install for dev environment now."
ifeq ($(TESTCRT), 0)
	apt-get update
	apt-get install dataone-cn-os-core
	cp /etc/ssl/certs/dataone.org.crt /etc/ssl/certs/_.dataone.org.crt
	apt-get install dataone-cn-rest-service dataone-cn-metacat dataone-cn-mercury
else
	@echo "The self-signed cert procedure has not been followed. apt-get will fail!"
endif

upgrade-rpw: publish
ifeq ($(TESTCRT), 0)
	/etc/init.d/tomcat6 stop
	/etc/init.d/apache2 stop
	apt-get purge dataone-cn-os-core
	apt-get purge postgresql
	apt-get autoremove
	$(shell rm -rf /var/mercury)
	$(shell rm -rf /var/lib/tomcat6)
	$(shell rm -rf /var/metacat)
	$(shell su postgres -c "psql -c \"DROP USER metacat\"")
	$(shell su postgres -c "dropdb metacat")
	apt-get update
	apt-get install dataone-cn-os-core
	/etc/init.d/tomcat6 stop
	/etc/init.d/apache2 stop
	cp /etc/ssl/certs/dataone.org.crt /etc/ssl/certs/_.dataone.org.crt
	apt-get install dataone-cn-rest-service dataone-cn-metacat dataone-cn-mercury
else
	@echo "The self-signed cert procedure has not been followed. apt-get will fail!"
endif



