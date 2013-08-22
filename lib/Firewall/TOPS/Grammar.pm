package Firewall::TOPS::Grammar;

use strict;
use warnings;

our (@ISA, @EXPORT, @EXPORT_OK, $VERSION);

BEGIN {
    require Exporter;

    @ISA       = qw (Exporter);
    @EXPORT    = qw (generator);
    @EXPORT_OK = qw ();
    $VERSION   = '3.0000';
}

use Smart::Comments;
use Parse::RecDescent;

=head1 NAME

Firewall::TOPS::Grammar - Parser Generator of Topsec

=head1 SYNOPSIS

    use Firewall::TOPS::Grammar;
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
            id "define area add name" STRING ("attribute" STRINGS)(?)
            { $return = [$item[0], $item[3], "@{$item[4]}"] }

address :
            id "define host add name" STRING ("ipaddr" IPADDRS)(?)
            { $return = [$item[0], $item[3], "@{$item[4]}"] }
        |   id "define subnet add name" STRING "ipaddr" IPADDR "mask" IPADDR
            { $return = [$item[0], $item[3], $item[5]."/".$item[7]] }
        |   id "define range add name" STRING "ip1" IPADDR "ip2" IPADDR
            { $return = [$item[0], $item[3], $item[5]."-".$item[7]] }

service :
            id "define service add name" STRING service_object
            { $return = [$item[0], $item[3], $item[4]] }

service_object :
            "protocol 6" so_port
            { $return = "tcp/:".$item[2] }
        |   "protocol 17" so_port so_port(?)
            { $return = "udp/:".$item[2] }
        |   "protocol 123" so_port
            { $return = "ip/".$item[3] }
        |   "protocol 1" so_port so_port(?)
            { $return = "icmp/".$item[3] }
        |   "protocol 455" so_port
            { $return = "eth/".$item[3] }

so_port :
            /port|port2/ DIGIT

address_group :
            id "define group_address add name" STRING ("member" STRINGS)(?)
            { $return = [$item[0], $item[3], "@{$item[4]}"] }

service_group :
            id "define group_service add name" STRING ("member" STRINGS)(?)
            { $return = [$item[0], $item[3], "@{$item[4]}"] }

policy :
            id "firewall policy add action" STRING options(?)
            { $return = [$item[0], @{$item[3]}] }

options :
            STRING STRING STRING STRING STRING STRING po_action
            { shift @item; $return = [@item] }

po_action :
            "accept"
        |   "deny"


id :
            "ID" DIGIT


STRING  :   /\S+/
DIGIT   :   /\d+/
IPADDR  :   /(\d{1,3})((\.)(\d{1,3})){3}/

STRINGS :   /'/ /(\S+ )+/ /'/ { $return = $item[2] }
IPADDRS :   /'/ /((\d{1,3})((\.)(\d{1,3})){3} )+/ /'/ { $return = $item[2] }

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
