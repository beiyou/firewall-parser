#!/usr/bin/perl

use strict;
use warnings;

use Smart::Comments;
use Parse::RecDescent;

my $parser = Parse::RecDescent->new(q{
    startrule : "address" name address(s)
    address   : "host-address" ipaddr
              { print "$item[1] : $item[2]\n" }
              | "range-address" ipaddr ipaddr
              { print "$item[1] : $item[2] $item[3]\n" }
    name      : /\S+/
    ipaddr    : /\S+/
});

$parser->startrule("adress venus host-address 10.109.32.152 range-address 10.109.32.22 10.109.32.234 host-address 10.109.32.168 host-address 8.8.8.8 range-address 192.168.1.0 192.168.1.255");
