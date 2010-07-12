
# ~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
#    This is a testing program that produces TAP output
#  (ok / not_ok) for each field to index.  The program
#  tests whether or not the field's xpath rule returns
#  anything.
#    
#  This program tests to see if there is an xpath for every schema field,
#  and a schema field for every xpath key.
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

    my($rXpEntry) = get_Xpaths();

    plan tests => 2;

    $rField = get_schemaFields();
    
    @allKeys = (keys(%$rXpEntry), keys (%$rField));

    # unique list of all keys
    $previous = '';
    foreach $k (sort @allKeys) {
	next if $k eq $previous;
	$previous = $k;
    
	if ($rField->{$k}) {
	    if ($rXpEntry->{$k}) {
		push(@both,$k);
	    } else {
		push(@onlySchema,$k);
	    }
	} else {
	    push(@onlyXPath,$k);
	}
    }
    is(scalar(@onlyXPath),0, "Test - Keys only in XPath: " . join(', ',@onlyXPath));
    is(scalar(@onlySchema),0, "Test - Keys only in the Schema: " . join(', ',@onlySchema));
    diag("...DIAGNOSTIC INFO - keys in both XPath and Schema files (". scalar(@both)."): " . join(', ',@both));

}




## ==================================================
##    Subroutines
## ==================================================

sub get_Xpaths {

    my $xp = XML::XPath->new(filename => $d1MercuryConf::xpathFile);
    my @node = $xp->find("//bean/property/map/entry")->get_nodelist;

    my %entry;
    foreach $n (@node) {
	$entry{$n->getAttribute('key')} = $n->getAttribute('value');
    }
    return (\%entry);
}

sub get_schemaFields {

    my %field;
    my $xp = XML::XPath->new(filename => $d1MercuryConf::solrSchemaFile);
    my @node = $xp->find("//field")->get_nodelist;

    foreach $n (@node) {
	$field{$n->getAttribute('name')}++;
    }
    return \%field;
}
