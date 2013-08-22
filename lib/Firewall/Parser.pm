package Firewall::Parser;

use strict;
use warnings;

our (@ISA, @EXPORT, @EXPORT_OK, $VERSION);

BEGIN {
    require Exporter;

    @ISA       = qw (Exporter);
    @EXPORT    = qw (parser);
    @EXPORT_OK = qw ();
    $VERSION   = '2.0300';
}

use Smart::Comments;

=head1 NAME

Firewall::Parser - Firewall Configuration Parser

=head1 SYNOPSIS

    use Firewall::Parser;
    my $container = parser "VENS", "firewall-config.txt";

=head1 DESCRIPTION

Firewall::Parser is a useful tool to parse the different firewall 
configurations (Currently it supports Venus and Topsec Firewalls).

Using the Firewall::Parser model, Perl scripts can be written to 
perform tasks such as firewall security audits, group or rule 
optimizations or large scale firewall configuration changes.

This software is inspired by Farly (Firewall Analysis and Rewrite 
LibrarY).

=cut

sub parser {
    my ($type, $file) = @_;

    use Firewall::TOPS::Filter;
    use Firewall::TOPS::Grammar;

    use Firewall::Object;

    # TODO: add log recording features

    use DBI;
    my ($host, $user, $pass, $db) = qw /10.109.32.166 root 123456 fw_audit/;

    # set a global database handle
    our $dbh = DBI->connect("dbi:mysql:database=$db;host=$host", $user, $pass);
    $dbh->do("set names utf8");

    # front ends: process configuration texts by its filter
    my @preprocessed_lines = filter $file;

    # front ends: load grammar generator
    my $parser = generator;

    my $yield;

    foreach my $line (@preprocessed_lines) {

        # get the parse tree for current line
        $yield = $parser->startrule($line);

### $yield

        # save the object into database
        save $yield if defined $yield;

    }
}

1;

__END__

=head1 AUTHOR

Written by Yanbin MA

=head1 COPYRIGHT

Copyright (c) 2013 Yanbin MA

This program is free softsare. You may copy or redistribute it under 
the terms of The MIT License.

=cut
