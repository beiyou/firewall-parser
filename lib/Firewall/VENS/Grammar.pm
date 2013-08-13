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

startrule       :   instruction

instruction     :   address EOL
#                  | service EOL
                  | groups EOL
#                  | policy EOL
#                  | <error>

address         :   "address" STRING address_object(s)
                  {
                      print "$item[2]\t: @{$item[3]}\n";
                  }
address_object  :   "host-address" IPADDRESS
                  | "net-address" IPADDRESS "/" DIGIT
                  {
                      $return = $item[2]."/".$item[4];
                  }
                  | "range-address" IPADDRESS IPADDRESS
                  {
                      $return = $item[2]."~".$item[3];
                  }

groups          :   groups_type STRING groups_object(s)
                  {
                      print "$item[2]\t: @{$item[3]}\n";
                  }

groups_type     :   "address-group"
                  | "service-group"

groups_object   :   "address-object" STRING
                  | "service-object" STRING

#
# token definitions
#

STRING          :   /\S+/
DIGIT           :   /\d+/
IPADDRESS       :   /(\d{1,3})((\.)(\d{1,3})){3}/

EOL             :   /$/

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
