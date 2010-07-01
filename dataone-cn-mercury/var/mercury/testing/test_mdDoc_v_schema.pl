
# ~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
#    This is a testing program that produces TAP output
#  (ok / not_ok) for each field to index.
#
#    This program tests whether or not the field in the
#  specification appears in the SOLR schema, using a 
#  general xpath search against the SOLR schema xml file
#  
# ~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-

use Test::More;
use XML::XPath;
use d1MercuryConf;

main();

exit;

## ==================================================
##    the Main routine 
## ==================================================


sub main {
    # predict how many tests there are
    plan tests =>  2 * scalar( keys %d1MercuryConf::mdItem2eKey);

    # we plan to search the schema file
    my $xp = XML::XPath->new(filename => $d1MercuryConf::solrSchemaFile);

    foreach (sort keys %d1MercuryConf::mdItem2eKey) {
	my $k = $d1MercuryConf::mdItem2eKey{$_};

	my $xpath_query = '//field[@name=' . "'$k']"; 
	my @node = $xp->find($xpath_query)->get_nodelist;

	# there should be 1 and only 1 node returned
	is(scalar(@node), 1, "schema test: assert '$k' from specification is defined ONCE in schema");

	if (@node) {
	    is($node[0]->getAttribute('indexed'),'true', "    ... and is indexed");
	} else {
	  SKIP: {
	      skip "   Indexed test skipped because field not found";
	    }
	}
    }
}

exit;

