
# ~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
#    This is a testing program that produces TAP output
#  (ok / not_ok) for each field to index.
#
#    This program tests whether or not the mercury xml
#  files themselves are well formed.  This can be a good
#  diagnostic for when changes are made to the files 
#  over time.
#  
# ~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-

use lib "./lib";
use Test::More;
use d1MercuryConf;

plan tests => 2;

ok(-e $d1MercuryConf::solrSchemaFile, "Test that the schema.xml file exists");
ok(-e $d1MercuryConf::xpathFile, "Test that the xpath xml file exists");

exit;
