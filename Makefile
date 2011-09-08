# Makefile for creating the DataONE CN build
# Matt Jones, 15 Dec 2009

# The list of packages to build
PKGS          = dataone-cn-os-core.deb dataone-cn-metacat.deb dataone-cn-mercury.deb dataone-cn-mnsynchronization.deb dataone-cn-rest-service.deb dataone-cn-portal.deb 

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
	apt-get install dataone-cn-rest-service dataone-cn-metacat dataone-cn-mercury dataone-cn-mnsynchronization dataone-cn-portal

upgrade: publish
	@echo $(shell printf "Stopping Tomcat\n")
	@echo $(shell /etc/init.d/tomcat6 stop)
	@echo $(shell printf "Stopping Apache\n")
	@echo $(shell /etc/init.d/apache2 stop)
	@echo $(shell printf "%b\n" "SLEEP 15 to allow tomcat to stop")
	@echo $(shell sleep 15)
	@echo $(shell su postgres -c "dropdb metacat")
	@echo $(shell su postgres -c "psql --command \"DROP USER metacat\"")
	apt-get remove dataone-cn-rest-service dataone-cn-metacat dataone-cn-mercury dataone-cn-mnsynchronization dataone-cn-portal
	apt-get autoremove
	@echo $(shell rm -rf /var/mercury)
	@echo $(shell rm -rf /var/metacat)
	apt-get update
	apt-get install dataone-cn-os-core
	@echo $(shell /etc/init.d/tomcat6 stop)
	@echo $(shell /etc/init.d/apache2 stop)
	apt-get install dataone-cn-rest-service dataone-cn-metacat dataone-cn-mercury dataone-cn-mnsynchronization dataone-cn-portal

install-rpw: publish
	@echo "Let's run apt-get install for dev environment now."
ifeq ($(TESTCRT), 0)
	apt-get update
	apt-get install dataone-cn-os-core
	/etc/init.d/tomcat6 stop
	/etc/init.d/apache2 stop
	cp /etc/ssl/certs/dataone.org.crt /etc/ssl/certs/_.dataone.org.crt
	apt-get install dataone-cn-rest-service dataone-cn-metacat dataone-cn-mercury dataone-cn-mnsynchronization dataone-cn-portal
else
	@echo "The self-signed cert procedure has not been followed. apt-get will fail!"
endif

upgrade-rpw: publish
ifeq ($(TESTCRT), 0)
	@echo $(shell printf "%b\n" "-Stopping Tomcat-")
	@echo $(shell /etc/init.d/tomcat6 stop)
	@echo $(shell printf "%b\n" "-Stopping Apache-")
	@echo $(shell /etc/init.d/apache2 stop)
	@echo $(shell printf "%b\n" "SLEEP 15 to allow tomcat to stop")
	@echo $(shell sleep 15)
	@echo $(shell su postgres -c "dropdb metacat")
	@echo $(shell su postgres -c "psql --command \"DROP USER metacat\"")
	apt-get remove dataone-cn-os-core
#	apt-get remove dataone-cn-rest-service dataone-cn-metacat dataone-cn-mercury
	apt-get autoremove
	@echo $(shell rm -rf /var/mercury)
	@echo $(shell rm -rf /var/metacat)
	@echo $(shell rm -rf /var/lib/dataone)
	@echo $(shell rm -rf /etc/dataone)
	@echo $(shell rm -rf /etc/init.d/mn-sychronize)
	@echo $(shell rm -rf /var/log/dataone)
	apt-get update
	apt-get install dataone-cn-os-core
	@echo $(shell /etc/init.d/tomcat6 stop)
	@echo $(shell /etc/init.d/apache2 stop)
	cp /etc/ssl/certs/dataone.org.crt /etc/ssl/certs/_.dataone.org.crt
	apt-get install dataone-cn-rest-service dataone-cn-metacat dataone-cn-mercury dataone-cn-mnsynchronization dataone-cn-portal
else
	@echo "The self-signed cert procedure has not been followed. apt-get will fail!"
endif

