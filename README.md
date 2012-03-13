# Ready GXP

The intention of this project is to provide a simple reusable template for 
GeoExt applications bound for a servlet container. To get started, see
http://github.com/ahocevar/gxp-simpledemo/ for a simple WMS/WFS browser/editor
created on top of the structure provided by Ready GXP.

## Setup

    curl -L https://github.com/opengeo/readygxp/raw/master/readygxp.sh | sh -s myapp

## Setup on Windows

* Use git from the Windows command prompt (this is an option at setup)
* Download https://github.com/opengeo/readygxp/raw/master/readygxp.bat into the directory where you want to create your app
* Run readygxp.bat

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
