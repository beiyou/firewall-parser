#!/usr/bin/perl -I /home/fw_audit/script/lib

#############################################################################
# description: an audit script file                                         #
#     created: Fri Jun 6, 2013                                              #
#      author: myb                                                          #
#                                                                           #
#     version: v1.1.2                                                       #
#     history: 06/28 add use lib function                                   #
#                                                                           #
#      how to:                                                              #
#    [script]$ perl audit.pl t/10.109.32.152 10086 2000 3000                #
#############################################################################

use strict;
use warnings;

use lib qw '/home/fw_audit/script/lib';


# There is an Example:
#
# [script]$ perl audit.pl t/10.109.32.152 10086 2000 3000
#
#   arg 1 => conf_path  : t/10.109.32.152
#   arg 2 => task_id    : 10086
#   arg 3 => audit_items: 2000 3000

my $conf_path   = shift;
my $task_id     = shift;
my @audit_items = @ARGV;


parse $conf_path, $task_id;

audit $task_id, @audit_items;

