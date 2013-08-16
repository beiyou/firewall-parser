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

=cut

sub insert {
    my ($table, $data) = @_;

    my $sql = "insert into `$table` ";

    my $fields = join ", ", (sort keys   %$data);
    my $values = join ", ", (sort values %$data);

    $sql .= join " ", "(", $fields, ") ";
    $sql .= join " ", "values ", "(", $values, ")";

    print "$sql\n";

#    my $sth = $Firewall::Parser::dbh->prepare();
#    $sth->execute() or die;
#
#    $sth->finish();
}

sub save {
}

1;

__END__

=head1 AUTHOR

Written by Yanbin MA

=cut
