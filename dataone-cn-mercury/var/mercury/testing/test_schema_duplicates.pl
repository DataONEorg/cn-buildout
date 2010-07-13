
# ~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
#    This is a testing program that produces TAP output
#  (ok / not_ok) for each field to index.  The program
#  tests whether or not the field's xpath rule returns
#  anything.
#    
#  This program checks for duplicate keys in the xpath file
#  Not sure if there should be...
# ~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-

use lib "./lib";
use XML::XPath;
use Test::More;
use d1MercuryConf;

main();

exit;


## ==================================================
##    the Main routine 
## ==================================================

sub main {


    my $xp = XML::XPath->new(filename => $d1MercuryConf::solrSchemaFile);
    my @node = $xp->find("//fields/field")->get_nodelist;

    plan tests => scalar(@node);


    #construct a hash of lists
    foreach $n (@node) {
	my $k = $n->getAttribute('name');
	
	if (defined $scName{$k}) {
	    push(@{ $scName{$k} }, $n);
	} else {
	    $scName{$k} = [$n];
	}
    }

    # loop through all recorded field names
    foreach $k (keys %scName) {
	my $numEntries = scalar(@{$scName{$k}}); 
	is($numEntries,1, "Test: Check for duplicate entries: '$k'");
    }
}
