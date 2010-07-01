package d1MercuryConf;

$mdDoc2schema = './MDdocToSchema.txt';
$xpathFile  = '../mercury_dev/datanet/datanet_schema_xpath2.xml';
$solrSchemaFile ='../solr/datanet/conf/schema.xml';

%sampleFiles = ( daac => '../mercury_inst/datanet/DataONESamples/harvested/MD_ORNLDAAC_221_03032010095920_MERGED.xml',
		 dryad => './dryad_sci_md_example.xml');


# derived data structures 
@line = <$mdDoc2schema>;
foreach (@line) {
    my($mdItem,$priority,$eKey) = split "\t";
    $mdItemPriority{$mdItem} = $priority;
    if (defined $eKey) {
	$mdItem2eKey{$mdItem} = $eKey;
    } else {
	$mdItem2eKey{$mdItem} = $mdItem;
    }
}

1;
