package Firewall::Filter::VENS;

use strict;
use warnings;

our (@ISA, @EXPORT, @EXPORT_OK, $VERSION);

BEGIN {
    require Exporter;

    @ISA       = qw(Exporter);
    @EXPORT    = qw(filter);
    @EXPORT_OK = qw();
    $VERSION   = '3.0000';
}

use Smart::Comments;

=head1 NAME

Firewall::Filter::VENS - Filter of Venus Firewall Configuration

=head1 SYNOPSIS

    use Firewall::Filter::VENS;

=head1 DESCRIPTION

=head1 METHODS

=head2 filter

=cut

sub filter {
    my $file = shift;

    use File::Slurp;
    my $text = read_file $file;
}

1;

__END__

=head1 AUTHOR

Written by Yanbin MA

=cut
