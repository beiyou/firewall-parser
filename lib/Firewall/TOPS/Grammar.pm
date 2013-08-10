package Firewall::TOPS::Grammar;

use strict;
use warnings;

our (@ISA, @EXPORT, @EXPORT_OK, $VERSION);

BEGIN {
    require Exporter;

    @ISA       = qw(Exporter);
    @EXPORT    = qw(generator);
    @EXPORT_OK = qw();
    $VERSION   = '3.0000';
}

use Smart::Comments;
use Parse::RecDescent;

=head1 NAME

Firewall::TOPS::Grammar - Parser Generator of Topsec

=head1 SYNOPSIS

    use Firewall::TOPS::Grammar;
    my $parser = generator;

=head1 DESCRIPTION

=cut

my $grammar = <<GRAM;

GRAM

sub generator {
    my $self = Parse::RecDescent->new($grammar);

    return $self;
}

1;

__END__

=head1 AUTHOR

Written by Yanbin MA

=cut
