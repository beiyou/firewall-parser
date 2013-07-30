#!/usr/bin/perl -I lib

use strict;
use warnings;

use Firewall::Parse;


print "=== ATTENTION ===\n";
print "This is ONLY a Parse Test Script\n";

parse "t/SYSCONFIG.TXT", 2001;

print "\n=== Test Ends ===\n";
