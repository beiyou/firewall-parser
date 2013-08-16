package Firewall::Parser;

use strict;
use warnings;

our (@ISA, @EXPORT, @EXPORT_OK, $VERSION);

BEGIN {
    require Exporter;

    @ISA       = qw (Exporter);
    @EXPORT    = qw (parser);
    @EXPORT_OK = qw ();
    $VERSION   = '2.0010';
}

use Smart::Comments;

=head1 NAME

Firewall::Parser - Firewall Configuration Parser

=head1 SYNOPSIS

    use Firewall::Parser;
    my $container = parser "VENS", "firewall-config.txt";

=head1 DESCRIPTION

Firewall::Parser is a useful tool to parse the different firewall 
configurations (Currently it support Venus and Topsec Firewalls).

Using the Firewall::Parser model, Perl scripts can be written to 
perform tasks such as firewall security audits, group or rule 
optimizations or large scale firewall configuration changes.

This software is inspired by Farly (Firewall Analysis and Rewrite 
LibrarY).

=cut

sub parser {
    my ($type, $file) = @_;

    use Firewall::VENS::Filter;
    use Firewall::VENS::Grammar;

    my @preprocessed_lines = filter $file;

    my $parser = generator;

    use DBI;
    my ($host, $user, $pass, $db) = qw (10.109.32.166 root 123456 fw_audit);
    my $dbh = DBI->connect("dbi:mysql:database=$db;host=$host", $user, $pass);
    $dbh->do("set names utf8");

    our $dbd = "HAH";
    use Firewall::Object;
    my $object;

    foreach my $line (@preprocessed_lines) {

        # get the parse object for current line
        $object = $parser->startrule($line);

### $object

        # save the object tokens into database
#        save $object if defined $object;

    }
}

1;

__END__

=head1 AUTHOR

Written by Yanbin MA

=head1 COPYRIGHT

This program is free software. You may copy or redistribute it under 
the same terms as Perl itself.

=cut
