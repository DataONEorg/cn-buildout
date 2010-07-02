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
    is ( $@, '' , "XML well-formed test: $file");
}

exit;

