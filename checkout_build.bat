echo on
:: Step 0
:: In Y:\geworkbench_release: 

::::::::::::::::::::::::::::::::::::::::::::::
set folder_name=geworkbench_2.5.0
::::::::::::::::::::::::::::::::::::::::::::::

rmdir %folder_name% /s /q
"C:\Program Files\TortoiseSVN\bin\svn" checkout https://ncisvn.nci.nih.gov/svn/geworkbench/branches/geworkbench_2_5_0/geworkbench %folder_name%
cd %folder_name%

ant createCleanDist