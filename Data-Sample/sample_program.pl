#! /usr/local/bin/perl -w
use strict;
use Pod::Usage();
use IO::File;

my ($filename) = @ARGV;

# Ask for data file if it is not entered.
unless( $filename ){
    die Pod::Usage::pod2usage();
}

# Open data file to read.
my $fh = new IO::File;
$fh->open( $filename ) or die "Cannot open file to read"; 

my @good_lines;
my %distinct_lines;
while( my $line = <$fh> ){
    # split the lines on tabs.
    my @cols = split(/\t+/,$line);
    # any lines with nulls are bad lines therefore number of lines must not be less than 7.
    if  (scalar @cols < 7){
        print "$line\n";
    }
    else{
        # store good lines to write later
        push( @good_lines,$line );
        # if line is good make column two the key of a hash because
        # we want to count disticnt rows for column two.
        $distinct_lines{$cols[1]} = \@cols;
    }
}
$fh->close();

# open file as writable and write only good lines so that bad lines are removed.
$fh->open( ">./corrected_file" ) or die "Cannot open file to write";
print $fh @good_lines;
close $fh;

# print distinct rows for column two in a coorected file.
print "Distinct lines by column 2 are: " . scalar keys %distinct_lines; 
print "\n";

__END__

=pod

=head1 NAME

sample_program.pl

=head1 SYNOPSIS

sample_program.pl data_file

=head1 DESCRIPTION

This sample prgram reads data file.

Data file has 7 columns.

It prints bad lines, meaning the lines with nulls, in any column on the screen.

It  writes good lines in a file named corrected_file.

It  prints the number of distinct rows for column 2 in the corrected_file on the screen.

=cut
