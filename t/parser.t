#!/usr/bin/perl -I lib

use strict;
use warnings;

use Firewall::Parser;

parser "VENS", "t/10.109.32.168";

#$parser->startrule("address venus host-address 10.109.32.152 range-address 1.1.1.1 2.2.2.2");
