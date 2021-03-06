#!/bin/sh
# Run by Hudson during automated package building.
#
# This script updates the Version information of packages prior to building
# with the last changed revision number of the package content.  This ensure 
# that apt will pick up the new version of content and update as necessary. 
#
# Expects package name as first arg

SRCDIR="$WORKSPACE/cn-buildout"
BUILDDIR="$WORKSPACE/cn-buildout/build"

SVNREVISION=`svn info $SRCDIR/$1 | awk '/^Last Changed Rev:/{print $4}'`;  
echo "$1 : $SVNREVISION"
sed -i 's/^Version: [.0-9]*/&R'$SVNREVISION'/' $BUILDDIR/sources/$1/DEBIAN/control
