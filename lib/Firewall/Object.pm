package Firewall::Parser;

use strict;
use warnings;

our (@ISA, @EXPORT, @EXPORT_OK, $VERSION);

BEGIN {
    require Exporter;

    @ISA       = qw(Exporter);
    @EXPORT    = qw(parser);
    @EXPORT_OK = qw();
    $VERSION   = '2.0010';
}

use Smart::Comments;
use Parse::RecDescent;

=head1 NAME

Firewall::Parser - Firewall Configuration Parser

=head1 SYNOPSIS

    use Firewall::Parser;

=head1 DESCRIPTION

=head1 METHODS

=head2 parser

=cut

sub parser {
    my ($type, $file) = @_;

}

1;

__END__

=head1 AUTHOR

Written by Yanbin MA

=head1 HISTORY

This module is first written on May 24, 2013.

=cut
