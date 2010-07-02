
# ~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
#    This is a testing program that produces TAP output
#  (ok / not_ok) for each field to index.  The program
#  tests whether or not the field's xpath rule returns
#  anything.
#    Currently, it reads the xpath file used by SOLR/ Mercury
#  to get a list of fields to test. 
#    In the future, it should test only fields defined
#  in the requirements (metadata document) 
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

    my($rEntry) = get_Xpaths();
    plan tests => scalar(@$rEntry);

    foreach $mdFormat (sort keys %d1MercuryConf::sampleFiles) {
	next unless $mdFormat eq 'daac';
	foreach $e (@$rEntry) {
	    do_tests($mdFormat,
		     $e->getAttribute('key'),
		     $e->getAttribute('value'));
	}
    }
}

## ==================================================
##    Subroutines
## ==================================================

sub do_tests {
    my($mdFormat,$k,$expression) = @_;
    my @result;

    my $xpt = XML::XPath->new(filename => $d1MercuryConf::sampleFiles{$mdFormat});


    if ($expression=~/\w/) {
	(@result) = $xpt->find($expression)->get_nodelist;
    }

    # initial test to see if the xpath returns something
    ok($#result >= 0,    "TEST: find key - $k");

    
    if (@result) {
	# can do more tests

	# check for proper date format
	if ($k =~/date/i) {
	    like( $result[0]->string_value, qr/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}.?\d*[A-Z]$/, "Date Format Test: $k");
	}
    }
    


#	ok( equate_results($rExpect->{$mdFormat}->{$k},\@result));
#    } else {
#	ok( 0, "no results from xpath: '$expression'");
#    }
}


sub get_Xpaths {

    # get the xpath expressions as an array of nodes
    # getAttribute() method to fetch the 'key' and 'value'

    my $xp = XML::XPath->new(filename => $d1MercuryConf::xpathFile);
    my @entry = $xp->find("//bean/property/map/entry")->get_nodelist;

#    print_entries();

    return \@entry;
}




# want a boolean value returned (zero or one)
sub equate_results {
    my($rExp,$rGot) = @_;

    # default to true, tests will prove the false case
    my $ret = 1;

    # are the two arrays the same length?
    if ($#$rExp == $#$rGot) {

	# are the array values the same?
	foreach $i (0..$#$rExp) {
	    # test for same values
	    next if $rGot->[$i]->string_value eq $rExp->[$i];
	    $ret = 0;
	}
    } else {
	$ret = 0;
    }
    return $ret;
}


    

sub print_entries {
    foreach $e (@entry) {
	print join("\t",
		   $e->getParentNode->getParentNode->getParentNode->getAttribute('id'),
		   $e->getAttribute('key'),
		   $e->getAttribute('value')), "\n";
    }
}


__DATA__
'daac'
'LTERSite'	S		
'abstract'	S,X	TEXT_SINGLE	//metadata/idinfo/descript/abstract/text()
'accessRule'	S,X	TEXT_SINGLE	//mercury/systemMetadata/accessRule/text()
'author_lname'	S		
'begdate'	_,X	DATE	//metadata/mercury/begdate/text()
'beginDate'	S		
'blockedMemberNode'	S,X	TEXT_SINGLE	//mercury/systemMetadata/replicationPolicy/blockedMemberNode/text()
'cat'	S		
'checksum'	S,X	TEXT_SINGLE	//mercury/systemMetadata/checksum/text()
'checksumAlgorithm'	S,X	TEXT_SINGLE	//mercury/systemMetadata/checksum/@algorithm
'class'	S,X	TEXT	//taxoncl[taxonrn[contains(.,'Class')]]/taxonrv/text()
'contactOrganization'	S,X	TEXT_SINGLE	//metadata/distinfo/distrib/cntinfo/cntperp/cntorg/text()
'contactPerson'	_,X	CSV2	//metadata/distinfo/distrib/cntinfo/cntperp/cntper/text()
'data_url'	S,X	TEXT_SINGLE	//metadata/idinfo/distinfo/digopt/onlinopt/computer/networka/networkr/text()
'datasource'	S		
'dateSysMetadataModified'	_,X	DATE, DATELIST	//mercury/systemMetadata/dateSysMetadataModified/text()
'decade'	S		
'derivedFrom'	S,X	TEXT_SINGLE	//mercury/systemMetadata/derivedFrom/text()
'describedBy'	S,X	TEXT_SINGLE	//mercury/systemMetadata/describedBy/text()
'describes'	S,X	TEXT_SINGLE	//mercury/systemMetadata/describes/text()
'eastBoundCoord'	S		
'eastbc'	_,X	GEO	//metadata/idinfo/spdom/bounding/eastbc/text()
'edition'	S,X	TEXT	//metadata/idinfo/citeinfo/edition/text()
'embargoExpires'	S,X	DATE	//mercury/systemMetadata/embargoExpires/text()
'endDate'	S		
'enddate'	_,X	DATE, DATELIST	//metadata/mercury/enddate/text()
'family'	S		
'features'	S		
'fileID'	S		
'fullText'	S		
'gcmdKeyword'	S		
'gcmdkeyword'	_,X	CSV	//metadata/idinfo/keywords/theme[themekt[contains(.,'(GCMD) Science Keywords')]]/themekey/text()
'genus'	S,X	TEXT	//taxoncl[taxonrn[contains(.,'Genus')]]/taxonrv/text()
'geoform'	S		
'id'	S		
'identifier'	S,X	TEXT_SINGLE	//mercury/systemMetadata/identifier/text()
'includes'	S		
'instance'	_,X	instance	ornldaac
'investigator'	S,X	TEXT	//metadata/mercury/Principal_Investigator/Name/text()
'investigatorText'	S		
'isSpatial'	S		
'keywords'	S,X	CSV	//metadata/mercury/Keywords/text()
'kingdom'	S,X	TEXT	//taxoncl[taxonrn[contains(.,'Kingdom')]]/taxonrv/text()
'last_modified'	S		
'manu'	S		
'manu_exact'	S		
'metd'	_,X	DATELIST	//metadata/metainfo/metd/text()
'metrd'	_,X	DATELIST	//metadata/metainfo/metrd/text()
'name'	S		
'noBoundingBox'	S		
'northBoundCoord'	S		
'northbc'	_,X	GEO	//metadata/idinfo/spdom/bounding/northbc/text()
'numberReplicas'	S,X	TEXT_SINGLE	//mercury/systemMetadata/replicationPolicy/@numberReplicas
'objectFormat'	S,X	TEXT_SINGLE	//mercury/systemMetadata/objectFormat/text()
'obsoletedBy'	S,X	TEXT_SINGLE	//mercury/systemMetadata/obsoletedBy/text()
'obsoletes'	S,X	TEXT_SINGLE	//mercury/systemMetadata/obsoletes/text()
'ogc_url'	S,X	TEXT_SINGLE	//metadata/mercury/OGC_URL/text()
'order'	S,X	TEXT	//taxoncl[taxonrn[contains(.,'Order')]]/taxonrv/text()
'origin'	S,X	TEXT	//metadata/idinfo/citation/citeinfo/origin/text()
'originator'	S,X	LOOKUP	//metadata/idinfo/citation/citeinfo/origin/text()
'originatorText'	S		
'parameter'	S,X	TEXT	//metadata/idinfo/keywords/theme[themekt[contains(.,'Parameter_Description')]]/themekey[contains(@name,'Parameter')]/text()
'parameterText'	S		
'phylum'	S,X	TEXT	//taxoncl[taxonrn[contains(.,'Phylum')]]/taxonrv/text()
'placeKey'	S,X	CSV	//metadata/idinfo/keywords/place/placekey/text()
'placekey'	_,X	CSV2	//metadata/idinfo/keywords/place/placekey/text()
'placekeyword'	_,X	CSV2	//metadata/idinfo/keywords/place[placekt[contains(.,'(GCMD) Location Keywords')]]/placekey/text()
'placekt'	_,X	CSV2	//metadata/idinfo/keywords/place/placekt/text()
'pointOfContact'	_,X	CSV2	//metadata/idinfo/ptcontac/cntinfo/cntorgp/cntorg/text()
'preferredMemberNode'	S,X	TEXT_SINGLE	//mercury/systemMetadata/replicationPolicy/preferredMemberNode/text()
'presentationCat'	S,X	DEFAULTING_LOOKUP	//metadata/idinfo/citation/citeinfo/geoform/text()
'project'	S,X	TEXT	//metadata/mercury/Project/text()
'projectText'	S		
'pubDate'	S,X	DATELIST, CSV2	//metadata/idinfo/citation/citeinfo/pubdate/text()
'purpose'	S,X	TEXT	//metadata/idinfo/descript/Purpose/text()
'replicationAllowed'	S,X	TEXT_SINGLE	//mercury/systemMetadata/replicationPolicy/@replicationAllowed
'replicationPolicy'	S,X	TEXT_SINGLE	//mercury/systemMetadata/replicationPolicy/text()
'rightsHolder'	S,X	TEXT_SINGLE	//mercury/systemMetadata/rightsHolder/text()
'sensor'	S,X	TEXT	//metadata/idinfo/keywords/theme[themekt[contains(.,'Parameter_Description')]]/themekey[contains(@name,'Sensor')]/text()
'sensorText'	S		
'site'	S,X	TEXT	//metadata/mercury/Site_Information/Site/text()
'siteText'	S		
'size'	S,X	TEXT_SINGLE	//mercury/systemMetadata/size/text()
'sku'	S		
'source'	S,X	TEXT, TEXT	//metadata/idinfo/keywords/theme[themekt[contains(.,'Parameter_Description')]]/themekey[contains(@name,'Source')]/text()
'sourceText'	S		
'southBoundCoord'	S		
'southbc'	_,X	GEO	//metadata/idinfo/spdom/bounding/southbc/text()
'species'	S,X	TEXT	//taxoncl[taxonrn[contains(.,'Species')]]/taxonrv/text()
'submitter'	S,X	TEXT_SINGLE	//mercury/systemMetadata/submitter/text()
'supplinf'	_,X	CSV2	//metadata/idinfo/descript/supplinf/text()
'temporalkeyword'	_,X	CSV2	//metadata/idinfo/keywords/temporal[tempkt[contains(.,'(GCMD) Temporal Keywords')]]/tempkey/text()
'term'	S,X	TEXT	//metadata/idinfo/keywords/theme[themekt[contains(.,'Parameter_Description')]]/themekey[contains(@name,'Term')]/text()
'termText'	S		
'text'	S		
'themekey'	_,X	CSV2	//metadata/idinfo/keywords/theme/themekey/text()
'themekt'	_,X	CSV2	//metadata/idinfo/keywords/theme/themekt/text()
'title'	S,X	TEXT_SINGLE	//metadata/idinfo/citation/citeinfo/title/text()
'titlestr'	S		
'topic'	S,X	TEXT, TEXT	//metadata/mercury/Parameter_Description/Topic/text()
'topicText'	S		
'update_date'	S		
'web_url'	S,X	TEXT_SINGLE	//metadata/idinfo/citation/citeinfo/onlink/text()
'westBoundCoord'	S		
'westbc'	_,X	GEO	//metadata/idinfo/spdom/bounding/westbc/text()
