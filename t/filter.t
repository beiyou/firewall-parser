#!/usr/bin/perl

use strict;
use warnings;

use Smart::Comments;
use lib "lib";
use Firewall::Filter::VENS;

my $text = filter("t/10.109.32.168");
### $text
