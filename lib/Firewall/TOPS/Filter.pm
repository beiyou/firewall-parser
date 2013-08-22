package Firewall::TOPS::Filter;

use strict;
use warnings;

our (@ISA, @EXPORT, @EXPORT_OK, $VERSION);

BEGIN {
    require Exporter;

    @ISA       = qw (Exporter);
    @EXPORT    = qw (filter);
    @EXPORT_OK = qw ();
    $VERSION   = '3.0000';
}

use Smart::Comments;

=head1 NAME

Firewall::TOPS::Filter - Filter of Topsec Firewall Configuration

=head1 SYNOPSIS

    use Firewall::TOPS::Filter;
    my @preprocessed_lines = filter $file;

=head1 DESCRIPTION

Firewall::TOPS::Filter filters out unneeded configuration and pre-formats the 
configuration in a manner as needed by the parser. It accepts the configuration 
file, and store the pre formatted configuration, line by line, into an array.

=cut

sub filter {
    my $file = shift;

    open CONF, "<", $file;
    my $text = do { local $/; <CONF> };

    # delete more than one whitespace
    $text =~ s/( )+/ /g;

    my @self = "\n";

    while ($text =~ /(?<=\n)(ID \d+ define .*\n)/g) {
        push @self, $1;
    }

    push @self, "\n";

    while ($text =~ /(?<=\n)(ID \d+ firewall .*\n)/g) {
        push @self, $1;
    }

    push @self, "\n";

    return @self;
}

1;

__END__

=head1 AUTHOR

Written by Yanbin MA

=cut
