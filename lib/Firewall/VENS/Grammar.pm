package Firewall::VENS::Grammar;

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
#            |   schedule
            |   address_group
            |   service_group
            |   policy
#            |   <error>


interface :
                "interface" STRING

address :
                "address" STRING address_object(s)
                { $return = [$item[0], $item[2], "@{$item[3]}"] }

address_object :
                "host-address" IPADDRESS
            |   "net-address" IPADDRESS "/" DIGIT
                { $return = $item[2]."/".$item[4] }
            |   "range-address" IPADDRESS IPADDRESS
                { $return = $item[2]."~".$item[3] }

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

STRING      :   /\S+/
DIGIT       :   /\d+/
IPADDRESS   :   /(\d{1,3})((\.)(\d{1,3})){3}/

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
