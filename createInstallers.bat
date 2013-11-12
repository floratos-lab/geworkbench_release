rem Step 0: check out from CVS
rem Step 1: run ant createCleanDist
@echo off
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set version_number=2.5.1
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem Step 2: use InstallAnyWhere to build the installers
rem help for InstallAnywhere: https://flexerasoftware.subscribenet.com/control/inst/manualoutline
"C:\Program Files (x86)\InstallAnywhere 2012\build.exe" Y:\geworkbench_release\geWorkbench.iap_xml
::pause


if errorlevel == 0 (goto :renamefiles) else echo InstallAnyWhere failed to build installers
::goto :eof
goto :error

:renamefiles
@echo on
echo "done with building " %version_number%

rem Step 3: rename the way Ken wants them
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set sourceFolder=Y:\geworkbench_release\geWorkbench_Build_Output\Web_Installers\InstData
set targetFolder=Y:\geworkbench_release\renamed_installers
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::pause

mkdir %targetFolder%

copy %sourceFolder%\Linux\NoVM\install.bin %targetFolder%\geWorkbench_v%version_number%_Linux_installer_noJRE.bin
copy %sourceFolder%\Linux\VM\install.bin %targetFolder%\geWorkbench_v%version_number%_Linux_installer_with_JRE6.bin
copy %sourceFolder%\MacOSX\install.zip %targetFolder%\geWorkbench_v%version_number%_MacOSX_installer.zip
copy %sourceFolder%\Windows\NoVM\install.exe %targetFolder%\geWorkbench_v%version_number%_Windows_installer_noJRE.exe
copy %sourceFolder%\Windows\VM\install.exe %targetFolder%\geWorkbench_v%version_number%_Windows_installer_with_JRE6.exe

::pause

rem Step 4: create the generic zip
set tempFolder=geWorkbench_v%version_number%\
xcopy cleanFolder %tempFolder% /e/y

rem to guarantee that it works correctly, make zure 7-zip command line is installed
rem the version used when this script was written is
rem 7-Zip Command line version 4.57

rem this command has been tested and worked well
"C:\Program Files\7-Zip\7z.exe" a -tzip %targetFolder%\geWorkbench_v%version_number%_Generic.zip %tempFolder%

rmdir %tempFolder% /s /q

rem create a MD5 file
echo now calculating MD5 ....
cd %targetFolder%
del geWorkbench_v%version_number%.md5
"C:\md5\md5" -l geWorkbench_v%version_number%_Linux_installer_noJRE.bin >>geWorkbench_v%version_number%.md5
"C:\md5\md5" -l geWorkbench_v%version_number%_Linux_installer_with_JRE6.bin >>geWorkbench_v%version_number%.md5
"C:\md5\md5" -l geWorkbench_v%version_number%_MacOSX_installer.zip >>geWorkbench_v%version_number%.md5
"C:\md5\md5" -l geWorkbench_v%version_number%_Windows_installer_noJRE.exe >>geWorkbench_v%version_number%.md5
"C:\md5\md5" -l geWorkbench_v%version_number%_Windows_installer_with_JRE6.exe >>geWorkbench_v%version_number%.md5
"C:\md5\md5" -l geWorkbench_v%version_number%_generic.zip >>geWorkbench_v%version_number%.md5

@echo off
set /p dummy= All done! Press Enter to exit.

goto :eof

:error
echo SOMETHING WENT WRONG

:eof
echo THE END.