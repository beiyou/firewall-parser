package Firewall::Object;

use strict;
use warnings;

our (@ISA, @EXPORT, @EXPORT_OK, $VERSION);

BEGIN {
    require Exporter;

    @ISA       = qw(Exporter);
    @EXPORT    = qw();
    @EXPORT_OK = qw();
    $VERSION   = '2.0010';
}

use Smart::Comments;

=head1 NAME

Firewall::Object - Object Table Service for Firewall::Parser

=head1 SYNOPSIS

    use Firewall::Object;

=head1 DESCRIPTION

=cut

sub parser {
    my ($type, $file) = @_;

}

1;

__END__

=head1 AUTHOR

Written by Yanbin MA

=cut
