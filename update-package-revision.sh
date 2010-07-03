#!/bin/sh
# Run by Hudson during automated package building.
#
# This script updates the Version information of packages prior to building
# with the last changed revision number of the package content.  This ensure 
# that apt will pick up the new version of content and update as necessary. 
#

SOURCES="dataone-cn-os-core dataone-cn-metacat dataone-cn-mercury dataone-cn-rest-service"
SRCDIR="$WORKSPACE/cn-buildout"
BUILDDIR="$WORKSPACE/cn-buildout/build"
for f in $SOURCES; do
  SVNREVISION=`svn info $SRCDIR/$f | awk '/^Last Changed Rev:/{print $4}'`;  
  echo "$f : $SVNREVISION"
  sed -i 's/^Version: [.0-9]*/&R'$SVNREVISION'/' $BUILDDIR/sources/$f/DEBIAN/control
done
