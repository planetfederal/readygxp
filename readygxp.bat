@echo off

if not "%2x"=="x" goto usage
if "%1x"=="x" goto usage

set TARGET=%1

if exist %TARGET% (
  echo %TARGET% already exists
  goto fail
)

echo Creating new application template %TARGET%...
call git clone https://github.com/opengeo/readygxp.git %TARGET%
if not errorlevel 0 (
   echo Could not clone application template.  
   goto fail
)


echo Initializing submodules...
cd %TARGET%
call git submodule init
call git submodule update

echo Checking out OpenLayers master...
pushd app\static\externals\openlayers
call git checkout master
popd

echo Initializing git-svn for GeoExt submodule...
pushd app\static\externals\geoext
call git checkout master
call git svn init http://svn.geoext.org/core/trunk/geoext
call git update-ref refs/remotes/git-svn origin/master
popd

echo Checking out gxp master...
pushd app\static\externals\gxp
call git checkout master
popd

echo Cleaning up...
rd /s /q .git
del readygxp.*
call sed "s/readygxp/%TARGET%/g" build.xml > tmp && del build.xml && ren tmp build.xml

echo Reinitializing repo...
call git init

echo Application template created in %TARGET%

goto success

:usage

  echo This script creates a new application template for gxp based applications.
  echo Given a path to a directory, a Git repository will be initialized with
  echo appropriate dependencies and build scripts.  Requires git and sed.
  echo. 
  echo Usage: readygxp.bat [target-dir]
  echo.
  echo Example:
  echo.
  echo   readygxp.bat myapp
  echo.
  goto fail

:fail
exit /b 1

:success
exit /b 0