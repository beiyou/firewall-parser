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
                interface EOL
            |   address EOL
            |   service EOL
#            |   schedule EOL
            |   address_group EOL
            |   service_group EOL
#            |   policy EOL
#            |   <error>


interface :
                "interface" STRING

address :
                "address" STRING address_object(s)

address_object :
                "host-address" IPADDRESS
            |   "net-address" IPADDRESS "/" DIGIT
                { $return = $item[2]."/".$item[4] }
            |   "range-address" IPADDRESS IPADDRESS
                { $return = $item[2]."~".$item[3] }

service :
                "service" STRING service_object(s)

service_object :
                /tcp|udp/ "dest" DIGIT DIGIT "source" DIGIT DIGIT
                { $return = $item[1]."/".$item[3]."-".$item[4] }
            |   "ip" DIGIT
                { $return = $item[1]."/".$item[2] }
            |   "icmp" DIGIT DIGIT
                { $return = $item[1]."/".$item[2].":".$item[3] }

address_group :
                "address-group" STRING groups_object(s)

service_group :
                "service-group" STRING groups_object(s)

groups_object :
                /(address|service)-object/ STRING

#
# token definitions
#

STRING      :   /\S+/
DIGIT       :   /\d+/
IPADDRESS   :   /(\d{1,3})((\.)(\d{1,3})){3}/

EOL         :   /$/

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
