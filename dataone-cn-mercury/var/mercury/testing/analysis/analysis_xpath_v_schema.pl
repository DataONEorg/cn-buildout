#===========================================
# A script to compare datanet_schema_xpath2 vs schema.xml
# schema.xml should be a superset of definitions
# 
# Author:  Rob Nahf,  dataONE project
# 
# ============================================

use lib '../lib';
use Getopt::Long;
use d1MercuryConf;

main();


sub initialize {
    # yep, these are globals...
    $xpath_file = $d1MercuryConf::xpathFile;
    $schema_file =$d1MercuryConf::solrSchemaFile;
    $verbose;
    $result = GetOptions ("xpath_file=s"  => \$xpath_file,       # string
			  "schema_file=s"  => \$schema_file,       # string
			  "verbose" => \$verbose);   # flag

    #need to check $result for success?
}


sub main {
    initialize();

    print "SCHEMA      " x 5 , "\n";
    print '=' x 50, "\n";
    ($rSField) = parse_schema();


    print "XPATH      " x 5 , "\n";
    print '=' x 50, "\n";

    ($rK2val,$rK2bean) = parse_xpath();

    correlate($rSField,$rK2val,$rK2bean);

}


sub correlate {
    my($rSField,$rK2val,$rK2bean) = @_;

    foreach $k (keys %{$rSField}) {
	$allKeys{$k} = 'S';
    }
    foreach $k (keys %{$rK2val}) {
	if (defined $allKeys{$k}) {
	    $allKeys{$k} .= ',X';
	} else {
	    $allKeys{$k} = '_,X';
	}
    }

    # how many overlap vs not?
    foreach $ak (keys %allKeys) {
	$venn{$allKeys{$ak}}++;
    }
    print "key found in BOTH : " . $venn{'S,X'} . "\n";
    print "key only in SCHEMA: " . $venn{'S'} . "\n";
    print "key only in XPATH : " . $venn{'_,X'} . "\n";
    print "\n";
    print "\n";

    # the table 
    print join("\t",qw(Key Found-in Bean(s) Expression)), "\n";
    foreach $ak (sort keys %allKeys) {
	print join("\t","'$ak'",$allKeys{$ak},$rK2bean->{$ak},$rK2val->{$ak}), "\n";
    }
}


sub parse_schema {

    open(SCH, $schema_file) or die $!;

    @attr = qw(multiValued indexed stored name class type);
    $fields = 0;
    $i = 0;
    while (<SCH>) {
	next unless /<field name/;
	s/\s+/ /g; # remove extra whitespace
	s/^\s//;   # remove leading whitespace
	s/\s*=\s*/=/g;    # remove whitespace around '='

	next if /\!--/;
	
	$fields++;
	    
	s/^<field\s+//;
	s/\s*\/>\s*//;

	@words = split(/\s|=/);

	# remove outer quotes
	foreach (@words) { s/^\"|\"$//g; }

	%x = @words;
	
	$i++;
	foreach $a (@attr) {
	    if (defined $x{$a}) {
		$count{$a}++;
		$fields[$i]->{$a} = $x{$a};
	    }
	    $name{$x{$a}}++ if $a eq 'name';
	}
    } 

    foreach $a (@attr) {
	print "$a = $count{$a}\n";
    }
    print "names = " . scalar(keys(%name)) . "\n";

    if ($verbose) {
	print join ("  ", sort keys(%name)), "\n";
    }
    return \%name;
}



#==========================



sub parse_xpath {
    open(XP, $xpath_file) or die $!;

    $entries = 0;
    while (<XP>) {
	if (/<bean id=\"(\w+)\"/) {  $bean = $1; }
	if (/<entry key/) {
	    next if /!--/;
	    $entries++;
	    s/\s+/ /g;
	    s/ value/ \tvalue/;
	    ($k,$v) = /entry key=\"(\w+)\"\s+value\s*=\s*\"(.+)\"/;

	    $ks{$k}++;
	    $beans{$bean}++;
	    $values{$v}++;
	
	    $eKey2val{$k} = $v;
	    if (defined $eKey2bean{$k}) {
		$eKey2bean{$k} .= ", $bean";
	    } else {
		$eKey2bean{$k} = $bean;
	    }
		
	    if ($verbose) {
		print "$beans{$bean} $ks{$k} $values{$v}\t", join("\t",$bean,$k,$v),"\n";
	    }
	}
    } 
    

    print "lines of entries = $entries\n";
    print "beans = " . scalar(keys(%beans)), "\n";
    print "unique keys = " . scalar(keys(%ks)), "\n";
    print "unique values = " . scalar(keys(%values)), "\n";
    print '-' x 30 , "\n";
    return (\%eKey2val, \%eKey2bean);

}
