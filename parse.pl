#!/usr/bin/perl
use strict;
use warnings;

# primary source: https://www.iqt.org/portfolio/
# backup source:  https://en.wikipedia.org/wiki/In-Q-Tel

my $url = $ARGV[0] || 'https://www.iqt.org/portfolio/';
my $regex = $ARGV[1];
my $contents=`curl -L -s $url`;

my @matches = $contents =~ /\<a class=".*esgbox" href=".*?" lgtitle="(.*?)"\>Read More\<\/a\>/g;
my $batch_size = 50;
my $batch_n = 2;
my $i = $batch_n - 1;
foreach (@matches) {
    if (++$i <= $batch_n*$batch_size) {
        print "$i\n";
        `python /Users/joegallo/dev/theHarvester/theHarvester.py -d "$_" -b linkedin > "companies/$_.txt"`;
    }
}

# 205 files grabbed via primary
# 120 files grabbed via backup