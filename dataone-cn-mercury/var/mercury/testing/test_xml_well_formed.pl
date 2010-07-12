
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
use XML::Parser;
use d1MercuryConf;

plan tests => 2 + scalar(keys %d1MercuryConf::sampleFiles);

$p1 = new XML::Parser(Style => 'Tree');


test_XML_well_formed($d1MercuryConf::solrSchemaFile);
test_XML_well_formed($d1MercuryConf::xpathFile);

foreach $f (sort keys %d1MercuryConf::sampleFiles) {
    test_XML_well_formed($d1MercuryConf::sampleFiles{$f});
}

sub test_XML_well_formed {
    my($file) = @_;

    eval { $p1->parsefile($file); }; 
    # now check the error message - if empty, it's all good
    is ( $@, '' , "XML well-formed test: $file");
}

exit;

