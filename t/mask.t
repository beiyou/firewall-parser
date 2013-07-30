#!/usr/bin/perl
#
# TEST SCRIPT FOR NETWORK IP ADDRESS MASK
# Write by: Mr. Seven

use strict;
use warnings;
use 5.010;

use Smart::Comments;

my $ipaddr = "10.109.32.152";
my $mask   = "255.255.252.0";

say "= ATTENTIONS: THIS IS A SUBNET MASK TEST SCRIPT =";
say "";

say "IP Address  : $ipaddr";
say "Subnet Mask : $mask";

my (@msk, @nsk);
@msk = split /\./, $mask;
### @msk
$nsk[$_] = 255 - $msk[$_] foreach (0..3);
my $nask = join '.', @nsk;

my (@ip1, @ip2);
push @ip1, int((split /\./, $ipaddr)[$_]) & int((split /\./, $mask)[$_]) foreach (0..3);
push @ip2, int((split /\./, $ipaddr)[$_]) | int((split /\./, $nask)[$_]) foreach (0..3);

my $ip1 = join '.', @ip1;
my $ip2 = join '.', @ip2;


say "";
say "IP Range: $ip1-$ip2";

say "======= TEST ENDS =======";
