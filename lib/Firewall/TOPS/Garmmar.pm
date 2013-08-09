package Firewall::Grammar::TOPS;

use strict;
use warnings;

our (@ISA, @EXPORT, @EXPORT_OK, $VERSION);

BEGIN {
    require Exporter;

    @ISA       = qw(Exporter);
    @EXPORT    = qw(grammar);
    @EXPORT_OK = qw();
    $VERSION   = '3.0000';
}

use Smart::Comments;

=head1 NAME

Firewall::Grammar::TOPS - Grammar of Topsec Firewall Configuration

=head1 SYNOPSIS

    use Firewall::Grammar::TOPS;

=head1 DESCRIPTION

=cut

sub grammar {

}

1;

__END__

=head1 AUTHOR

Written by Yanbin MA

=cut
