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
git clone git@github.com:opengeo/readygxp.git $1
if [ "$?" != "0" ]; then
   echo "Could not clone application template."  
   exit 1
fi

cd $1
git submodule init
git submodule update
rm -rf .git
rm readygxp.sh
git init

echo "Application template created in $TARGET"
