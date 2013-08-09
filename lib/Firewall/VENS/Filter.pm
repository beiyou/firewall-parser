package Firewall::VENS::Filter;

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

Firewall::VENS::Filter - Filter of Venus Firewall Configuration

=head1 SYNOPSIS

    use Firewall::VENS::Filter;
    my @preprocessed_lines = filter $file;

=head1 DESCRIPTION

Firewall::VENS::Filter filters out unneeded configuration and pre-formats 
the configuration in a manner as needed by the parser. It accepts the 
configuration file, and store the pre formatted configuration, line by 
line, into an array.

=cut

sub filter {
    my $file = shift;

    open CONF, "<", $file;
    my $text = do { local $/; <CONF> };

    # delete more than one whitespace
    $text =~ s/( )+/ /g;

    # ignore the comments
    $text =~ s/ description .*\n//g;

    # merge subcommands into one line
    $text =~ s/\n / /g;

    my @self = "\n";

    while ($text =~ /(?<=\n)(address .*\n)/g) {
        push @self, $1;
    }

    push @self, "\n";

    while ($text =~ /(?<=\n)(address-group .*\n)/g) {
        push @self, $1;
    }

    push @self, "\n";

    while ($text =~ /(?<=\n)(service .*\n)/g) {
        push @self, $1;
    }

    push @self, "\n";

    while ($text =~ /(?<=\n)(service-group .*\n)/g) {
        push @self, $1;
    }

    push @self, "\n";

    while ($text =~ /(?<=\n)(policy .*\n)/g) {
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
