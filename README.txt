CN Buildout
-----------
This directory contains tools and build artifacts associated with building
the default VM for coordinating nodes.  The base distribution is a KVM
virtual machine instance running Ubuntu 10.04.4 with the default Ubuntu
install.  See the cn-packages-list.txt for a list of the deb packages that
were installed at each stage of the build.

All changes to the system are handled through the Makefile in this module.

Each package that needs to be installed on the system should be added as a
dependency to one of the dataone-cn-* debian packages.  Once there, running
'make install' will build these packages, publish them to a local apt repository,
and then install them on the system.

Please do not make manual changes or installation to the system -- we expect 
to be able to wipe the VM and run 'make install' to get a fully rebuilt system.

Also, please describe changes and updates to this build in the SystemConfiguration.txt
log file.
