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

There defines two kinds of Objects, the POLICY Objects and others. 
The definitions is follows:

    POLICY:
        SRC_IF DST_IF SRC_IP DST_IP SERVICE SCHEDULE STATUS ACTION

    ADDRESS | ADDRESS_GROUP | SERVICE | SERVICE_GROUP | SCHEDULE | 
    INTERFACE :
        STRING VALUE

OK! Let's save them to database.

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

sub update {
}

sub save {
    # save a object to database
    my $yield = shift;

    my @object = @$yield;

    my $table = shift @object;
    my %data;

    if ($table ~~ /policy/) {
        %data = (
                SRC_IF   => shift @object,
                DST_IF   => shift @object,
                SRC_IP   => shift @object,
                DST_IP   => shift @object,
                SERVICE  => shift @object,
                SCHEDULE => shift @object,
                ACTION   => shift @object,
        );
    }
    else {
        %data = (
                STRING => shift @object,
                VALUE  => shift @object,
        );
    }

    insert "fp-$table", \%data;
}

1;

__END__

=head1 AUTHOR

Written by Yanbin MA

=cut
