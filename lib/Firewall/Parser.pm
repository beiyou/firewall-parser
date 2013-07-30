package Firewall::Parse;

use strict;
use warnings;

our (@ISA, @EXPORT, @EXPORT_OK, $VERSION);

BEGIN {
    require Exporter;

    @ISA       = qw(Exporter);
    @EXPORT    = qw(parse);
    @EXPORT_OK = qw($CFG $LOG $RDS $DBH initialize);
    $VERSION   = '2.0010';
}

use Smart::Comments;
use Firewall::Common;
use Firewall::Common qw(record store insert update);

=head1 NAME

Firewall::Parse - Parse Module of The Firewall Audit

=head1 SYNOPSIS

    use Firewall::Parse;
    parse $conf_path, $task_id;

=head1 DESCRIPTION

This module give a interface that allow parsing the difference firewall 
configuration files, getting the configuration infomations and storing the 
structured data to a database.

=head1 METHODS

=head2 parse

=cut

sub parse {
    my ($path, $task) = @_;

    # initialize codes
    my $log_path = "t/a.log";
    open $LOG, ">>", $log_path or record $!;

    open $CFG, "<", $path or record $!;

    use Redis;
    $RDS = Redis->new(server => "10.109.32.166:6379", name => "goat");
    $RDS->select(7);

    use DBI;
    my ($host, $user, $pass, $name) =qw (10.109.32.166 root 123456 fw_audit);
    $DBH = DBI->connect("DBI:mysql:database=$name;host=$host", $user, $pass);
    $DBH->do("set names utf8");

    # preprocessor sections
    use Tie::File;
    tie my @lines, "Tie::File", $CFG;
    print "@lines";
}

1;

__END__

=head1 AUTHOR

Written by Mr. Seven

=head1 HISTORY

This module is first written on May 24, 2013.

=cut
package Firewall::Common;

use strict;
use warnings;

our (@ISA, @EXPORT, @EXPORT_OK, $VERSION);

BEGIN {
    require Exporter;

    @ISA       = qw(Exporter);
    @EXPORT    = qw($CFG $LOG $RDS $DBH);
    @EXPORT_OK = qw(record fetch store insert update);
    $VERSION   = '2.0010';
}

use Smart::Comments;
use POSIX qw(strftime);

=head1 NAME

Firewall::Common - Common Module of The Firewall Audit

=head1 SYNOPSIS

    use Firewall::Common;

=head1 DESCRIPTION

This Module contains some subrountines used in parse section. The insert 
and update are for MySQL; fetch and store are for Redis. The record is a 
method to write log information.

=cut

our ($CFG, $LOG, $RDS, $DBH);

=head1 METHODS

=head2 record

=cut

sub record {
    my $string = shift;

    my $datetime = strftime "%Y-%m-%d %H:%M:%S", localtime;

    print $LOG "[$datetime]";
    print $LOG " $string \n";
}

=head2 fetch

=cut

sub fetch {
    my $key = shift;

    return $RDS->lpop($key);
}

=head2 fetchall

=cut

sub fetchall {
}

=head2 store

This subroutine  will push a value into list.

=cut

sub store {
    my ($key, $value) = @_;

    $RDS->lpush($key, $value);
}

=head2 storeall

=cut

sub storeall {
}

=head2 insert

=cut

sub insert {
    my ($table, $data) = @_;

    my $sql = "insert into $table ";

    my $insert_fields = join ", ", (my @fields = sort keys   %$data);
    my $insert_values = join ", ", (my @values = sort values %$data);

    $sql .= join " ", "(", $insert_fields, ") ";
    $sql .= join " ", "values", "(", $insert_values, ")";

    ### $sql
    my $sth = $DBH->prepare($sql);
    $sth->execute;

    $sth->finish;
}

=head2 update

=cut

sub update {
    my ($table, $data, $where) = @_;

    my $sql = "update $table ";

    ### $sql
}

1;

__END__

=head1 AUTHOR

Written by Mr. Seven

=head1 HISTORY

This module is first written on May 24, 2013.

=cut
