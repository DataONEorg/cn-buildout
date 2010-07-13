#!/bin/bash

# the first script produces TAP output (ok / not_ok)
# the second converts it to JUnit / ANT output format
# that should be suitable for Hudson.

# cannot use this without proper installation
#java -jar /var/mercury/mercury_dev/datanet/run-dataone-mercury-indexer.jar | 

cat *.xml > all_tests.xml.bu
#mv -f t_outputs/all_tests.xml t_outputs/all_tests.xml.bu;
perl ./test_xml_config_files_exist.pl  | perl ./tap-to-junit-xml.pl --puretap >t_outputs/config_files_exist.xml;
perl ./test_xml_well_formed.pl  | perl ./tap-to-junit-xml.pl --puretap >t_outputs/well_formed.xml;
perl ./test_xpath_duplicates.pl  | perl ./tap-to-junit-xml.pl --puretap >t_outputs/xpath_dupes.xml;
perl ./test_schema_duplicates.pl  | perl ./tap-to-junit-xml.pl --puretap >t_outputs/schema_dupes.xml;

perl ./test_xpath_v_schema.pl  | perl ./tap-to-junit-xml.pl --puretap >t_outputs/xp-v-schema.xml;

#       want to make sure there's an xpath for every schema field definition
#       this also tests for xpaths keys without entries in schema.xml

#perl ./test_xpath_v_sampleData.pl  | perl ./tap-to-junit-xml.pl --puretap >t_outputs/xp-v-samples.xml;

#       Can't run the indexer because the sample data path is absolute (/var/mercury/...)
#       so need to run separately and shove the output into svn

#cat merc-3out.xml | grep -v '</add><add xmlns' | perl ./test_indexer.pl  | perl ./tap-to-junit-xml.pl --puretap >t_outputs/.xml 
#perl ./test_mdDoc_v_schema.pl  | perl ./tap-to-junit-xml.pl --puretap >>t_outputs/all_tests.xml;