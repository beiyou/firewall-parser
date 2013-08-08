#!/usr/bin/perl -I lib

use strict;
use warnings;
use Test::Simple tests => 5;

use Firewall::VENS::Filter;

my @lines = filter "t/10.109.32.168";

my ($actual, $expect);

$actual = $lines[2];
$expect = "address mars net-address 192.168.1.0/24\n";

ok $actual eq $expect, "address";

$actual = $lines[5];
$expect = "address net3 host-address 192.168.20.5\n";

ok $actual eq $expect, "address";

$actual = $lines[17];
$expect = "address-group gnet3 address-object mars address-object net4\n";

ok $actual eq $expect, "address group";

$actual = $lines[24];
$expect = "service ser4 udp dest 500 1000 source 220 1000\n";

ok $actual eq $expect, "service";

$actual = $lines[34];
$expect = "policy 4 ge1 ge2 venus gnet1 tcp always permit enable\n";

ok $actual eq $expect, "policy";
