rem Step 0.1: check the several projects out from GitHub
rem Step 0.2: assemble Github projects manually using "assemble.bat" to create "geworkbench_dev"
rem Step 1: run ant createCleanDist to create cleanFolder
@echo off
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set version_number=2.6.0
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem Step 2: use InstallAnyWhere to build the installers
rem help for InstallAnywhere: https://flexerasoftware.subscribenet.com/control/inst/manualoutline
"C:\Program Files (x86)\InstallAnywhere 2012\build.exe" Y:\geworkbench_release\geWorkbench_%version_number%_64bit.iap_xml
"C:\Program Files (x86)\InstallAnywhere 2012\build.exe" Y:\geworkbench_release\geWorkbench_%version_number%_32bit.iap_xml
::pause


if errorlevel == 0 (goto :renamefiles) else echo InstallAnyWhere failed to build installers
::goto :eof
goto :error

:renamefiles
@echo on
echo "done with building " %version_number%