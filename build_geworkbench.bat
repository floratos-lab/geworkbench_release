rem new version revised and reviewed in september 2013

echo %time%
call checkout_build.bat

cd Y:\geworkbench_release
call createInstallers.bat
echo %time%


