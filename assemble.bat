XCOPY  /S /I geworkbench-core geworkbench_dev
XCOPY  /S /I geworkbench-components\components geworkbench_dev\components
COPY geworkbench_supporting_files\cytoscape\cytoscape.jar geworkbench_dev\components\cytoscape\lib\cytoscape.jar
COPY geworkbench_supporting_files\viper\viper.tar.gz geworkbench_dev\components\viper\viperScripts\viper.tar.gz
XCOPY /S /I demandScripts geworkbench_dev\components\demand\demandScripts
rem   Overwrite the mac command files from github with original copies from  the command_files_LF_only directory. 
rem   Cannot use the files from Github has then get carriage return characters added on checkin or checkout.  
rem   The command files will not work on MacOSX if carriage return characters are present.
XCOPY /S /I /Y command_files_LF_only geworkbench_dev