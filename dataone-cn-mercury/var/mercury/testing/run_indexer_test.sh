#!/bin/bash

# the first script produces TAP output (ok / not_ok)
# the second converts it to JUnit / ANT output format
# that should be suitable for Hudson.

# cannot use this without proper installation
#java -jar /var/mercury/mercury_dev/datanet/run-dataone-mercury-indexer.jar | 

d=`date '+%Y%m%d-%H%M%S'`;
myfile="t_outputs/indexer_tests_$d.xml";

cat mercury-1out.xml |
perl ./test_indexer.pl 2>&1 | perl ./tap-to-junit-xml.pl --puretap >$myfile 2>&1
ln -sf $myfile t_outputs/indexer_tests.xml