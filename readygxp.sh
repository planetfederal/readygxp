#!/bin/bash

if [ $# -gt 1 ]; then
  cat <<END_DOCS

    This script creates a new application template for gxp based applications.
    Given a path to a directory, a Git repository will be initialized with
    appropriate dependencies and build scripts.

    Usage: readygxp.sh [target-dir]

    Examples:

      $ readygxp.sh myapp

        - or -

      $ curl https://github.com/opengeo/readygxp/raw/master/readygxp.sh | sh -s myapp

END_DOCS
  exit 1
fi

if [ $# -eq 1 ]; then
  TARGET=$1
else
  echo -n "Path to new application: "
  read TARGET
fi

if [ -e $TARGET ]; then
  echo "$TARGET already exists"
  exit 1
fi

echo "Creating new application template $TARGET..."
git clone https://github.com/opengeo/readygxp.git $1
if [ "$?" != "0" ]; then
   echo "Could not clone application template."  
   exit 1
fi

echo "Initializing submodules..."
cd $1
git submodule init
git submodule update

echo "Initializing git-svn for OpenLayers submodule..."
pushd app/static/externals/openlayers
git checkout 2.x
git svn init http://svn.openlayers.org/trunk/openlayers
git update-ref refs/remotes/git-svn origin/2.x
popd

echo "Initializing git-svn for GeoExt submodule..."
pushd app/static/externals/geoext
git checkout master
git svn init http://svn.geoext.org/core/trunk/geoext
git update-ref refs/remotes/git-svn origin/master
popd

echo "Checking out gxp master..."
pushd app/static/externals/gxp
git checkout master
popd

echo "Cleaning up..."
rm -rf .git
rm readygxp.sh

echo "Reinitializing repo..."
git init

echo "Application template created in $TARGET"
