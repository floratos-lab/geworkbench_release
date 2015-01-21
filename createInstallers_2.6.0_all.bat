rem Step 0: check out from CVS
rem Step 1: run ant createCleanDist
@echo off
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set version_number=2.6.0
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem Step 2: use InstallAnyWhere to build the installers
rem help for InstallAnywhere: https://flexerasoftware.subscribenet.com/control/inst/manualoutline
rem "C:\Program Files (x86)\InstallAnywhere 2012\build.exe" Y:\geworkbench_release\geWorkbench_%version_number%_64bit.iap_xml
rem "C:\Program Files (x86)\InstallAnywhere 2012\build.exe" Y:\geworkbench_release\geWorkbench_%version_number%_32bit.iap_xml
::pause


if errorlevel == 0 (goto :renamefiles) else echo InstallAnyWhere failed to build installers
::goto :eof
goto :error

:renamefiles
@echo on
echo "done with building " %version_number%

rem Step 3: rename the way Ken wants them
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem set sourceFolder=Y:\geworkbench_release\geWorkbench_%version_number%_64bit_Build_Output\Web_Installers\InstData
rem set targetFolder=Y:\geworkbench_release\renamed_installers
rem Make script portable so can run non-InstallAnywhere parts on other machines.  Just run this in "geworkbench_release" folder.
set sourceFolder=geWorkbench_%version_number%_64bit_Build_Output\Web_Installers\InstData
set targetFolder=renamed_installers
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
REM goto :calc_md5
::pause

mkdir %targetFolder%

rem 64-bit Windows and Linux versions
copy %sourceFolder%\Linux\NoVM\install.bin %targetFolder%\geWorkbench_v%version_number%_Linux_noJRE.bin
copy %sourceFolder%\Linux\VM\install.bin %targetFolder%\geWorkbench_v%version_number%_Linux_JRE7_x64.bin
copy %sourceFolder%\Windows\NoVM\install.exe %targetFolder%\geWorkbench_v%version_number%_Windows_noJRE.exe
copy %sourceFolder%\Windows\VM\install.exe %targetFolder%\geWorkbench_v%version_number%_Windows_JRE7_x64.exe

rem 32-bit Windows and Linux versions
set sourceFolder=geWorkbench_%version_number%_32bit_Build_Output\Web_Installers\InstData
copy %sourceFolder%\Linux\VM\install.bin %targetFolder%\geWorkbench_v%version_number%_Linux_JRE7_x86.bin
copy %sourceFolder%\Windows\VM\install.exe %targetFolder%\geWorkbench_v%version_number%_Windows_JRE7_x86.exe

::pause

rem Step 4: create the generic zip
rem geWorkbench no longer includes any empty directories
set tempFolder=geWorkbench_%version_number%

xcopy /S /I cleanFolder %tempFolder%

rem Create the Generic version
rem to guarantee that it works correctly, make zure 7-zip command line is installed
rem the version used when this script was written is
rem 7-Zip Command line version 4.57

rem this command has been tested and worked well
"C:\Program Files\7-Zip\7z.exe" a -tzip %targetFolder%\geWorkbench_v%version_number%_Generic.zip %tempFolder%

rem Now copy in the MacOSX JRE and create the MacOSX version
xcopy /S /I macosx_jre7_71_from_jdk\jre %tempFolder%\jre
"C:\Program Files\7-Zip\7z.exe" a -tzip %targetFolder%\geWorkbench_v%version_number%_MacOSX_JRE7_x64.zip %tempFolder%

rmdir %tempFolder% /s /q

:calc_md5
rem create a MD5 file
echo now calculating MD5 ....
cd %targetFolder%
del geWorkbench_v%version_number%.md5
"C:\md5\md5" -l geWorkbench_v%version_number%_Linux_JRE7_x64.bin >>geWorkbench_v%version_number%.md5
"C:\md5\md5" -l geWorkbench_v%version_number%_Linux_JRE7_x86.bin >>geWorkbench_v%version_number%.md5
"C:\md5\md5" -l geWorkbench_v%version_number%_Linux_noJRE.bin >>geWorkbench_v%version_number%.md5
"C:\md5\md5" -l geWorkbench_v%version_number%_MacOSX_JRE7_x64.zip >>geWorkbench_v%version_number%.md5
"C:\md5\md5" -l geWorkbench_v%version_number%_Windows_JRE7_x64.exe >>geWorkbench_v%version_number%.md5
"C:\md5\md5" -l geWorkbench_v%version_number%_Windows_JRE7_x86.exe >>geWorkbench_v%version_number%.md5
"C:\md5\md5" -l geWorkbench_v%version_number%_Windows_noJRE.exe >>geWorkbench_v%version_number%.md5
"C:\md5\md5" -l geWorkbench_v%version_number%_Generic.zip >>geWorkbench_v%version_number%.md5


@echo off
set /p dummy= All done! Press Enter to exit.

goto :eof

:error
echo SOMETHING WENT WRONG

:eof
echo THE END.