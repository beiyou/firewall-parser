package Firewall::VENS::Grammar;

use strict;
use warnings;

our (@ISA, @EXPORT, @EXPORT_OK, $VERSION);

BEGIN {
    require Exporter;

    @ISA       = qw (Exporter);
    @EXPORT    = qw (generator);
    @EXPORT_OK = qw ();
    $VERSION   = '2.0000';
}

use Smart::Comments;
use Parse::RecDescent;

=head1 NAME

Firewall::VENS::Grammar - Parser Generator of Venus

=head1 SYNOPSIS

    use Firewall::VENS::Grammar;
    my $parser = generator;

=head1 DESCRIPTION

=cut

my $grammar = q {

startrule :
            instruction

instruction :
            interface
        |   address
        |   service
        |   schedule
        |   address_group
        |   service_group
        |   policy
        |   <error>


interface :
            "interface" STRING "ip address" IPADDR "/" DIGIT
            { $return = [$item[0], $item[2], $item[4]."/".$item[6]] }

address :
            "address" STRING address_object(s)
            { $return = [$item[0], $item[2], "@{$item[3]}"] }

address_object :
            "host-address" IPADDR
        |   "net-address" IPADDR "/" DIGIT
            { $return = $item[2]."/".$item[4] }
        |   "range-address" IPADDR IPADDR
            { $return = $item[2]."-".$item[3] }

service :
            "service" STRING service_object(s)
            { $return = [$item[0], $item[2], "@{$item[3]}"] }

service_object :
            /tcp|udp/ so_dst_port so_src_port
            { $return = $item[1]."/".$item[2].":".$item[3] }
        |   "ip" DIGIT
            { $return = $item[1]."/".$item[2] }
        |   "icmp" DIGIT DIGIT
            { $return = $item[1]."/".$item[2].":".$item[3] }

so_dst_port :
            "dest" DIGIT DIGIT
            { $return = $item[2]."-".$item[3] }

so_src_port :
            "source" DIGIT DIGIT
            { $return = $item[2]."-".$item[3] }

schedule :
            /schedule (onetime|recurring)/ STRING schedule_object(s)
            { $return = [$item[0], $item[2], "@{$item[3]}"] }

schedule_object :
            "absolute" DATE TIME DATE TIME
            { $return = $item[2]."T".$item[3]."~".$item[4]."T".$item[5] }
        |   "periodic" TIME TIME
            { $return = $item[2]."~".$item[3]."@"."12345" }

address_group :
            "address-group" STRING groups_object(s)
            { $return = [$item[0], $item[2], "@{$item[3]}"] }

service_group :
            "service-group" STRING groups_object(s)
            { $return = [$item[0], $item[2], "@{$item[3]}"] }

groups_object :
            /(address|service)-object/ STRING

policy :
            "policy" STRING options
            { $return = [$item[0], @{$item[3]}] }

options :
            STRING STRING STRING STRING STRING STRING po_action
            { shift @item; $return = [@item] }

po_action :
            "permit"
        |   "deny"

#
# token definitions
#

STRING  :   /\S+/
DIGIT   :   /\d+/
IPADDR  :   /(\d{1,3})((\.)(\d{1,3})){3}/
DATE    :   /\d{2}-\d{2}-\d{2}/
TIME    :   /\d{2}:\d{2}:\d{2}/

};

sub generator {
    my $self = Parse::RecDescent->new($grammar);

    return $self;
}

1;

__END__

=head1 AUTHOR

Written by Yanbin MA

=cut
