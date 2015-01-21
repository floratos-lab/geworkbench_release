XCOPY  /S /I geworkbench-core geworkbench_dev
XCOPY  /S /I geworkbench-components\components geworkbench_dev\components
COPY geworkbench_supporting_files\cytoscape\cytoscape.jar geworkbench_dev\components\cytoscape\lib\cytoscape.jar
COPY geworkbench_supporting_files\viper\viper.tar.gz geworkbench_dev\components\viper\viperScripts\viper.tar.gz
XCOPY /S /I demandScripts geworkbench_dev\components\demand\demandScripts
rem   The files in directory command_files_LF_only cannot come from github, as the files in it get carriage
rem   return characters added on checkout.  Must use an original copy.  Teh command files will not work on MacOSX
rem   if carriage return characters are present.
XCOPY /S /I command_files_LF_only geworkbench_dev