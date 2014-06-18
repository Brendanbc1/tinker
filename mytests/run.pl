#!/usr/bin/perl
# 
# Run a number of jobs resizing the size of an
# array mimicing particle positions, compiling 
# and running, timing the results. Output goes 
# to a set of files that are then hoovered up 
# by another perl script. 
#
# Usage:
#
# run.pl -c CodeBaseName -o OutputDirectory
#
# Timing files will be placed in the subdirectory
# OutputDirectory and have the following format:
#
#   CodeBaseName-ArraySize-Run.txt
#
# Where array size is the size of the array used
# and Run is the run number (can repeat each run
# more than once).

# Let perl tell us if we are doing anything silly.
use strict;
use warnings;

# Process command line arguments.
use Getopt::Std;
my %opts; # store the options and values used.

# Get the command line arguments
# h, o anc c flags with o and c having arguments.
if(! getopt("ho:c:",\%opts)){HELP_MESSAGE();}

# Declare and set varyables to be used.
my($outdir,$code);

# Print out a help message.
if( defined $opts{'h'} ) { HELP_MESSAGE(); }

# Output directory.
if( defined $opts{'o'} ) {$outdir=$opts{'o'};}else{$outdir="out1";}
# Code basename to use to for experiment.
if( defined $opts{'c'} ) {$code=$opts{'c'};}else{$code="code1";}

print "Using output directory $outdir and codebase $code.\n";

my $Nrepeats = 1;               # Number of times to run each piece of code.
my $Nruns    = 25;              # Number of runs
my $N        = 10000;           # Starting number for the array size.
my $Nstep    = 10000;           # Increase in N between runs.
my $time     ="/usr/bin/time";  # Timing command to use.

# Compiler name with any optimisation flags.
my $compiler="ifort -O3";
#my $compiler="ifort -fast";
#my $compiler="ifort";
#my $compiler="gfortran";
#my $compiler="gfortran -O3";

# The compilation command.
my $compilation="$compiler -o $code $code.f90";

# Create the output directory.
system("mkdir -p $outdir");

# Loop over the different number of array sizes.
for(my $num=1;$num <= $Nruns; $num++){

   # Replace the current number of particles in the code.
   system("perl -pi.bak -e \"s/number=\\d+/number=$N/\" $code.f90");

   # Recompile the code.
   system($compilation);

   # Number of repeats for each array size.
   for(my $run=1; $run <= $Nrepeats; $run++){

      # filename to put the output data.
      my $outfile="$outdir/$code-$N-$run.txt";

      print "Running $code with N=$N ($num/$Nruns), run = $run/$Nrepeats to $outfile.\n";
      print "Using: $compilation.\n";

      # Run the code.
      system("$time -v -o $outfile ./$code");
   }

   # Update the array size.
   $N=$N+$Nstep;

}

# Run the post processing perl script that will generate 
# a CSV file.

system("../bench/processOutput.pl -d $outdir");

# System help message
sub HELP_MESSAGE
{
print <<EOF;

The script run.pl runs a number of experiments for a given piece
of code. Valid arguments are:

  -o Specifies the output directory.
  -c Specifies the code basename to use.

EOF
exit 0;
}
