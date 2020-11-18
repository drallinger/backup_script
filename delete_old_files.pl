#!/usr/bin/perl
use strict;
use warnings;
use autodie;
use Getopt::Long;
use POSIX qw(strftime);

sub timestamp {
    return strftime '[%Y-%m-%d %H:%M:%S]', localtime;
}

my $dir;
my $limit = 3;
GetOptions(
    "directory=s" => \$dir,
    "limit=i" => \$limit
);
die timestamp(), " No dir given\n" unless $dir;
die timestamp(), " Unable to find $dir\n" unless -e $dir;
die timestamp(), " $dir is not a directory\n" unless -d $dir;

opendir(my $dh, $dir);
my @files = readdir $dh;
closedir $dh;
my @sorted_files;
for my $file(@files){
    push @sorted_files, $file if $file =~ m#\.tar\.bz2$#;
}
@sorted_files = sort @sorted_files;
my $file_count = scalar @sorted_files;
print timestamp(), " $file_count file(s) found, limit is $limit\n";
if($file_count >= $limit){
    my $diff = $file_count - $limit;
    my @files_to_remove = splice @sorted_files, 0, $diff;
    for my $file(@files_to_remove){
        unlink "$dir/$file";
        print timestamp(), " Deleted $file\n";
    }
}
