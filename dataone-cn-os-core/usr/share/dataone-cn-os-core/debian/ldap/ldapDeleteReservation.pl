#!/usr/bin/perl

use Net::LDAP;
use strict;

my $ldap = Net::LDAP->new("localhost");

my $mesg = $ldap->bind("cn=admin,dc=dataone,dc=org", password=>"password");

$mesg = $ldap->search(  filter=>"(objectClass=d1Reservation)", 
                        base=>"dc=org");

my @entries = $mesg->entries;
foreach my $entry (@entries) 
	{
	my $dn = $entry->dn();
	print "DN = $dn\n";
	$ldap->delete($dn);
	}

$ldap->unbind;

