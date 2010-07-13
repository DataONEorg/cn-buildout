
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


    my $xp = XML::XPath->new(filename => $d1MercuryConf::xpathFile);
    my @node = $xp->find("//bean/property/map/entry")->get_nodelist;

    plan tests => scalar(@node);


    #construct a hash of lists
    foreach $n (@node) {
	my $k = $n->getAttribute('key');
	my $bean = $n->getParentNode()->getParentNode()->getParentNode()->getAttribute('id');
	
	if (defined $xpKey{"bean:$bean key:$k"}) {
	    push(@{ $xpKey{"bean:$bean key:$k"} }, $n);
	} else {
	    $xpKey{"bean:$bean key:$k"} = [$n];
	}
    }

    #loop through each bean-key combo (these need to be unique)
    foreach $bk (keys %xpKey) {
	my $numEntries = scalar(@{$xpKey{$bk}}); 
	is($numEntries,1, "Test: Check for duplicate entries: '$bk'");
    }
}


sub cruft {

    if ($numEntries > 1) {
	# so check the value attribute of each node
	# count number of values
	
	my %vals;
	foreach (@{$xpKey{$k}}) {
	    $vals{ $_->getAttribute('value') }++;
	}
	if (scalar(keys %vals) == $numEntries) {
	    pass( "   ..... All different with different  xpaths");
	} else {
	    pass( "   ..... ($numEntries) entries, (" . scalar(keys %vals) . ") paths");
	}
    }
}




## ==================================================
##    Subroutines
## ==================================================


sub get_schemaFields {

    my %field;
    my $xp = XML::XPath->new(filename => $d1MercuryConf::solrSchemaFile);
    my @node = $xp->find("//field")->get_nodelist;

    foreach $n (@node) {
	$field{$n->getAttribute('name')}++;
    }

    return \%field;
}
