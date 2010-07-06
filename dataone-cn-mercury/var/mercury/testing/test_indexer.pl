

# ~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
#    This is a testing program that produces TAP output
#  (ok / not_ok) for each field to index.
#
#    This program tests the Mercury indexer to see if 
#  it is producing the right output.  Right in this
#  case is:
#  1). the field to be indexed is found in the test data
#  2). the field is of the correct datatype.
#  
# ~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-

use lib "./lib";
use Test::More;
use XML::XPath;
use d1MercuryConf;
use Getopt::Long;

#use Checker;
use String::Numeric;

$mercuryOutputXML;
$verbose;

GetOptions ("mercury_file=s"  => \$mercuryOutputXML,       # string
	    "verbose" => \$verbose
    ) or die "wrong options\n";


main();

exit;



## ==================================================
##    the Main routine 
## ==================================================


sub main {
    # predict how many tests there are
    plan tests =>  2 * scalar( keys %d1MercuryConf::mdItem2eKey);


    # connect to the output file for searching
    
    my $xp;
    if (defined $mercuryOutputXML) {
	$xp = XML::XPath->new(filename => $mercuryOutputXML);
    } else {
	$xp = XML::XPath->new( '-' );
    }
    # read expected fields and types from the document
    while (my($item,$field) = each %d1MercuryConf::mdItem2eKey) {

	next unless $field=~/\w/;

#	my $xpath_query = '//field[@name=' . "'$k']"; 
	my $xpath_query = "//$field";
	my @node = $xp->find($xpath_query)->get_nodelist;
	
	# there should be at least one node found
	isnt(scalar(@node), 0, "find index field: $field ( found " . scalar(@node)." )");

	if (@node) {
	    my $type = $d1MercuryConf::mdItemDataType{$item};

	    if ($type =~/string|text/) {
		ok ($node[0]->string_value =~ /[A-Za-z]/, "Datatype test - declared v data: String|Text");
	    } elsif ($type =~/integer/) {
		ok (is_int($node[0]->string_value), "Datatype test - declared v data: Integer");
	    } elsif ($type =~/long/) {
		ok (is_int64($node[0]->string_value) ||
		    is_uint64($node[0]->string_value), "Datatype test - declared v data: Long");
	    } elsif ($type =~/float/) {
		ok (is_float($node[0]->string_value), "Datatype test - declared v data: Float");
	    } elsif ($type =~/double/) {
		ok (is_float($node[0]->string_value), "Datatype test - declared v data: Double (as float)");
	    } elsif ($type =~/boolean/) {
		ok ($node[0]->string_value =~/^(true|false|0|1)$/i, "Datatype test - declared v data: Boolean");
	    } elsif ($type =~/date/) {
		ok ($node[0]->string_value =~/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}.?\d*[A-Z]$/,
		    "Datatype test - declared v data: Date");
	    } else {
		ok (0, "Datatype test - declared v data: $type - NO TEST AVAILABLE");
	    }
	} else {
	    ok( 0, "Datatype test - declared v data: NO DATA FOUND for field '$field'");
	}
    }
}
	
    
    
