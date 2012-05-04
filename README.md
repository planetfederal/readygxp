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

## Deploying App to an OpenGeo Suite Instance

Ready GXP uses [Cargo](http://cargo.codehaus.org/) to deploy apps to a remote
OpenGeo Suite instance's servlet container. The name of the app is set in root element of the `build.xml` file and defaults to `readygxp`:

    <project name="readygxp" default="dist" basedir=".">

If the app only consists of static files (i.e. no server-side JavaScript), use
the `deploy-static` target to deploy, otherwise use `deploy`. A typical ant
command to deploy your app named `readygxp` to http://my.suite-instance.com:8080/readygxp/` is

    ant deploy-static -Dcargo.host=my.suite-instance.com -Dcargo.password=abc123

To undeploy the app, use

    ant undeploy -Dcargo.host=my.suite-instance.com -Dcargo.password=abc123

There are more Cargo options available to the `ant deploy`, `ant deploy-static` and `ant undeploy` commands, and all are appended by using `-D<option>=<value>`:

* *cargo.host*: The OpenGeo Suite host to deploy to. Default is `localhost`.
* *cargo.port*: The port the OpenGeo Suite's servlet container runs on. Default is `8080`.
* *cargo.container*: The servlet container used by the OpenGeo Suite. Available values are `glassfish3x`, `jboss4x`, `jboss42x`, `jboss5x`, `jboss51x`, `jboss6x`, `jboss61x`, `jboss7x`, `jboss71x`, `jetty6x`, `jetty7x`, `jetty8x`. Default is `tomcat6x`.
* *cargo.username*: The username for the container management servlet. Default is `manager`.
* *cargo.password*: The password for the container management servlet. No default.
* *cargo.context*: The name of the servlet context for the app (i.e. the url path for the app). Default is the project name specified in the `build.xml` file.

## Preparing a Servlet Container for Remote Deployment

The OpenGeo Suite's servlet containers are configured to accept remote deployments. On a fresh OpenGeo Suite installation, the password for remote deployments needs to be configured on the servlet container.

For Windows and OSX installations, the password can be set in the `realm.properties` file in the `C:\Program Files\OpenGeo\OpenGeo Suite\etc\` (Windows) or `/opt/opengeo/suite/etc/` (OSX) folder. To use `mypassword` as password, this file would have a line like the following:

    manager: mypassword,manager

This means that the username is "manager" (`manager:`), and the account is valid for the "manager" group (`,manager`).

For Linux installations, the password can be set in Tomcat's `tomcat-users.xml` file. On Debian based distributions (e.g. Ubuntu) with Tomcat 6, this file can be found in `/etc/tomcat6/`:

    <tomcat-users>
      <role rolename="manager"/>
      <user username="manager" password="mypassword" roles="manager"/>
    </tomcat-users>

The above sets up a user with user name `manager` and password `mypassword`.
