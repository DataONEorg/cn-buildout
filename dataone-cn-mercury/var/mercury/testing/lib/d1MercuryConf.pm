package d1MercuryConf;


$mdDoc2schema = './MDdocToSchema.csv';
$solrSchemaFile ='../solr/Solr_Conf/schema.xml';

$xpathFile  = '../mercury_dev/datanet/datanet_schema_xpath2.xml';

# assuming the indexer uses different xpath files for each objectFormat
%xpathFiles  = (daac => '../mercury_dev/datanet/datanet_schema_xpath2.xml',
		dryad => '',
		knb => '',
    );

# used by xml_well_formed test, and xpath_vs_sample
%sampleFiles = ( daac => '../mercury_inst/datanet/DataONESamples/harvested/MD_ORNLDAAC_221_03032010095920_MERGED.xml',
		 dryad => './dryad_sci_md_example.xml',
		 knb => '../mercury_inst/datanet/DataONESamples/harvested/BAYXXX_015ADCP015R00_20051215509_MERGED.xml',
    );


# derived data structures 

open (FILE, $mdDoc2schema) or die("Unable to open file: '$mdDoc2schema'");
@line = <FILE>;
close FILE;


## from http://search.cpan.org/~jesse/perl-5.12.1/pod/perlport.pod#Newlines
# different systems use different newline ascii characters
# Below is the chart:
#
#    LF  eq  \012  eq  \x0A  eq  \cJ  eq  chr(10)  eq  ASCII 10
#    CR  eq  \015  eq  \x0D  eq  \cM  eq  chr(13)  eq  ASCII 13
#
#             | Unix | DOS  | Mac  |
#        ---------------------------
#        \n   |  LF  |  LF  |  CR  |
#        \r   |  CR  |  CR  |  LF  |
#        \n * |  LF  | CRLF |  CR  |
#        \r * |  CR  |  CR  |  LF  |
#        ---------------------------
#        * text-mode STDIO
#
# So, need to be able to parse the csv no matter what...

# if we get only one line, then something's wrong
# especially if we find the 'other' newline character

if ($/=~/\012/) {
    if ( @line == 1 and $line[0]=~/\015/ ) {
	# so convert to something more usable, then split into lines
	$line[0]=~s/\015/\n/mg;
	@line = split "\n", $line[0];
    }
} elsif ($/=~/\015/) {
# might as well implement the reverse case
    if (@line == 1 and $line[0]=~/\012/) {
	# so convert to something more usable, then split into lines
	$line[0]=~s/\012/\n/mg;
	@line = split "\n", $line[0];
    }
}
# else must be a one line input file...


foreach (@line) {
    next if /MD_doc/;
    chomp;
    my($mdItem,$priority,$datatype,$eKey) = split ',';
    $mdItemPriority{$mdItem} = $priority;
    $mdItemDataType{$mdItem} = $datatype;
    if (defined $eKey and $eKey =~/\w/) {
	$mdItem2eKey{$mdItem} = $eKey;
    } else {
	$mdItem2eKey{$mdItem} = $mdItem;
    }
}

1;
