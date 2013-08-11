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

startrule       :   object_address EOL
                  | object_service EOL
                  | object_schedule EOL
                  | groups_address EOL
                  | groups_service EOL
                  | policy EOL
#                  | <error>

object_address  :   "address" STRING address(s)
                  {
                      print "$item[2]\t: @{$item[3]}\n";
                  }
address         :   "host-address" IPADDRESS
                  | "net-address" IPADDRESS "/" DIGIT
                  {
                      $return = $item[2]."/".$item[4];
                  }
                  | "range-address" IPADDRESS IPADDRESS
                  {
                      $return = $item[2]."~".$item[3];
                  }

groups_address  :   "address-group" STRING address_object(s)
                  {
                      print "$item[2]\t: @{$item[3]}\n";
                  }

address_object  :   "address-object" STRING

groups_service  :   "service-group" STRING service(s)
                  {
                      print "$item[2]\t: @{$item[3]}\n";
                  }

service_object  :   "service-object" STRING

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
