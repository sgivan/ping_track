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

my $remote_host = '8.8.8.8';

my ($debug,$verbose,$help);

my $result = GetOptions(
    "debug"     =>  \$debug,
    "verbose"   =>  \$verbose,
    "help"      =>  \$help,
);

if ($help) {
    help();
    exit(0);
}

my $p = Net::Ping->new('external');
$p->hires();
my ($ret,$duration,$ip) = $p->ping($remote_host);
say "ret: '$ret', duration: '$duration', ip: '$ip'";

if ($p->ping($remote_host)) {
    say "$remote_host is alive";
} else {
    say "$remote_host is dead";
}

$p->close();

sub help {

say <<HELP;


HELP

}

