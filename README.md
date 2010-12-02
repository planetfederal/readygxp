# Ready GXP

The intention of this project is to provide a simple reusable template for 
GeoExt applications bound for a servlet container.

## Setup

    git clone git@github.com:opengeo/readygxp.git
    cd readygxp
    git submodule init
    git submodule update

Enhancements to come later.  For now, an application can be run as follows:

## Debug Mode

Loads all scripts uncompressed.

    ant init
    ant debug

This will give you an application available at http://localhost:8080/ by
default.  You only need to run `ant init` once (or any time dependencies
change).

## Prepare App for Deployment

To create a servlet run the following:

    ant

The servlet will be assembled in the build directory.
