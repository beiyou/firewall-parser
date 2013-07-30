#!/usr/bin/perl -I lib

use Smart::Comments;
use Firewall::Parse::Topsec qw($foo);

use File::Read;

my $file = read_file("t/parse.t");

print $file;
