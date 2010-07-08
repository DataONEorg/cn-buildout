#!/bin/bash

# the first script produces TAP output (ok / not_ok)
# the second converts it to JUnit / ANT output format
# that should be suitable for Hudson.

# cannot use this without proper installation
#java -jar /var/mercury/mercury_dev/datanet/run-dataone-mercury-indexer.jar | 

mv -f t_outputs/all_tests.xml t_outputs/all_tests.xml.bu
perl ./test_xml_well_formed.pl 2>&1 | perl ./tap-to-junit-xml.pl --puretap >t_outputs/all_tests.xml 2>&1
perl ./test_mdDoc_v_schema.pl 2>&1 | perl ./tap-to-junit-xml.pl --puretap >>t_outputs/all_tests.xml 2>&1
perl ./test_xpath_v_sampleData.pl 2>&1 | perl ./tap-to-junit-xml.pl --puretap >>t_outputs/all_tests.xml 2>&1

cat mercury-1out.xml |
perl ./test_indexer.pl 2>&1 | perl ./tap-to-junit-xml.pl --puretap >>t_outputs/all_tests.xml 2>&1
