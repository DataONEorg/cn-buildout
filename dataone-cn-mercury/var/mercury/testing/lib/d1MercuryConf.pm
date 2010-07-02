package d1MercuryConf;

$mdDoc2schema = './MDdocToSchema.csv';
$xpathFile  = '../mercury_dev/datanet/datanet_schema_xpath2.xml';
$solrSchemaFile ='../solr/Solr_Conf/schema.xml';

%sampleFiles = ( daac => '../mercury_inst/datanet/DataONESamples/harvested/MD_ORNLDAAC_221_03032010095920_MERGED.xml',
		 dryad => './dryad_sci_md_example.xml');


# derived data structures 

open (FILE, $mdDoc2schema) or die("Unable to open file: '$mdDoc2schema'");
while (<FILE>) {
    push(@line,$_);
}
close FILE;
foreach (@line) {
    next if /MD_doc/;
    chomp;
    my($mdItem,$priority,$datatype,$eKey) = split ',';
    $mdItemPriority{$mdItem} = $priority;
    $mdItemDataType{$mdItem} = $datatype;
    if (defined $eKey) {
	$mdItem2eKey{$mdItem} = $eKey;
    } else {
	$mdItem2eKey{$mdItem} = $mdItem;
    }
}

1;
