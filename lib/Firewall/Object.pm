package Firewall::Object;

use strict;
use warnings;

our (@ISA, @EXPORT, @EXPORT_OK, $VERSION);

BEGIN {
    require Exporter;

    @ISA       = qw (Exporter);
    @EXPORT    = qw (save);
    @EXPORT_OK = qw ();
    $VERSION   = '2.0010';
}

use Smart::Comments;

=head1 NAME

Firewall::Object - Firewall::Parser Object Save Module

=head1 SYNOPSIS

    use Firewall::Object;
    save \@object;

=head1 DESCRIPTION

There defines two kinds of Objects, the POLICY Objects and others. The 
definitions is follows:

    POLICY:
        ACTION DST_IF SRC_IF DST_IP SRC_IP SERVICE SCHEDULE STATUS

    ADDRESS | ADDRESS_GROUP | SERVICE | SERVICE_GROUP | SCHEDULE | 
    INTERFACE :
        STRING VALUE

=cut

sub insert {
    my ($table, $data) = @_;

    my $sql = "insert into `$table` ";

    my $insert_fields = join ", ", map { "`$_`" } keys   %$data;
    my $insert_values = join ", ", map { "'$_'" } values %$data;

    $sql .= join " ", "(", $insert_fields, ") ";
    $sql .= join " ", "values ", "(", $insert_values, ")";

    my $sth = $Firewall::Parser::dbh->prepare($sql);
    $sth->execute() or die;

    $sth->finish();
}

sub save {
    # save a object to database
    my $tree = shift;

    my @object = @$tree;

    my $table = shift @object;
    my %data;

    if ($table ~~ /policy/) {
    }
    else {
        %data = (
                string => shift @object,
                value  => shift @object,
        );
    }

    insert "fp-$table", \%data;
}

1;

__END__

=head1 AUTHOR

Written by Yanbin MA

=cut
