XCOPY  /S /I geworkbench-core geworkbench_dev
XCOPY  /S /I geworkbench-components\components geworkbench_dev\components
COPY geworkbench_supporting_files\cytoscape\cytoscape.jar geworkbench_dev\components\cytoscape\lib\cytoscape.jar
COPY geworkbench_supporting_files\viper\viper.tar.gz geworkbench_dev\components\viper\viperScripts\viper.tar.gz