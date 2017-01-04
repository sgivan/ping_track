#!/usr/bin/env perl 
#===============================================================================
#
#         FILE:  ping_track.pl
#
#        USAGE:  ./ping_track.pl  
#
#  DESCRIPTION:  script to generate network data with ping
#
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Dr. Scott A. Givan (SAG), sgivan@yahoo.com
#      COMPANY:  BWL Software
#      VERSION:  1.0
#      CREATED:  03/12/2016 10:16:08 AM
#     REVISION:  ---
#===============================================================================



use 5.010;      # Require at least Perl version 5.10
use autodie;
use Getopt::Long; # use GetOptions function to for CL args
use warnings;
use strict;
use Net::Ping;
use Statistics::Descriptive;
use DateTime;

my $remote_host = '8.8.8.8';
my $count = 20;

my ($debug,$verbose,$help,$quiet);

my $result = GetOptions(
    "quiet"     =>  \$quiet,
    "debug"     =>  \$debug,
    "verbose"   =>  \$verbose,
    "help"      =>  \$help,
);

if ($help) {
    help();
    exit(0);
}

if (!-e 'stats.txt') {
    open(my $STATS,'>','stats.txt');
    say $STATS "Timecode\tSuccess\tFail\tavgTime";
    close($STATS);
}

my $p = Net::Ping->new('external');
$p->hires();
my $stats = Statistics::Descriptive::Sparse->new();
$stats->clear();

my $dt = DateTime->now();
$dt->set_time_zone('America/Chicago');
say "\n$dt" unless ($quiet);

my ($alive,$dead) = (0,0);

for (my $n = 0; $n < $count; ++$n) {
    if(my ($ret,$duration,$ip) = $p->ping($remote_host)) {
        if ($ret) {
            ++$alive;
        } else {
            ++$dead;
        }
        say "ret: '$ret', duration: '$duration', ip: '$ip'" unless ($quiet);
        $stats->add_data($duration);
    } else {
        say "unknown error";
    }
}

say "time: $dt, alive: $alive, dead: $dead, duration: ", $stats->mean() unless ($quiet);

open(my $OUT,">>","stats.txt");

say $OUT "$dt\t$alive\t$dead\t", $stats->mean();

close($OUT);

#if ($p->ping($remote_host)) {
#    say "$remote_host is alive";
#} else {
#    say "$remote_host is dead";
#}

$p->close();

sub help {

say <<HELP;


HELP

}

