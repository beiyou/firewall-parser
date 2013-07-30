#!/usr/bin/perl -I lib
# created: The May 21 2013

use strict;

use Firewall::Common qw(record fetch store insert);

use Redis;

our $RDS = Redis->new(server => '10.109.32.166:6379', name => 'what');

store "hello", "Jim Green, Han Meimei, Li Lei, Lucy, Lily";
