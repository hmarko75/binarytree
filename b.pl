#!/usr/bin/perl -w
# 

use strict;
use Data::Dumper;
use warnings;
no warnings 'recursion';

my($root, $n);

# first generate 20 random inserts
while ($n++ < 3333) { insertbst($root, int(rand(10033333)))}
#print Dumper($root);

dfs_norec($root);
print "\n";

sub dfs_norec {
    my($tree) = @_;
	return unless $tree;	
	my @stack = ();
	
	while ($tree) {		
		if (not $tree->{visited}) {
			push @stack,$tree;
			#print "adding $tree->{value} to the stack, stack is $#stack\n";
		}
	
		if ($tree->{left} and not $tree->{left}->{visited}) {
			$tree = $tree->{left};
			#print "setting left $tree->{value}\n";
		} else{
			pop @stack;
			$tree->{visited} = 1;
			#print "printing value $tree->{value}\n";
			print "$tree->{value} ";
			if ($tree->{right}) {
				$tree = $tree->{right};
				#print "setting right $tree->{value}\n";
			} elsif ($#stack >= 0) {
				$tree = pop @stack;
				#print "poping  $tree->{value} to the stack, stack is $#stack\n";
			} else {
				$tree = undef;
			}
		}
	}
}

sub dfs {
    my($tree) = @_;
    return unless $tree;

	dfs($tree->{left});
	
	if (-not $tree->{visited}) {
		print "$tree->{value} ";
		$tree->{visited} = 1;
	} 
	dfs($tree->{right});
}



sub insertbst {
	my ($tree,$value) = @_;
	
	unless ($tree) {
		$tree = {};
		$tree->{left} = undef;
		$tree->{right} = undef;
		$tree->{value} = $value;
		#print "insert $value\n";
		$_[0] = $tree;
		return;
	}			
	
	if ($tree->{value} > $value) {
		insertbst($tree->{left},$value);
	} elsif ($tree->{value} < $value) {
		insertbst($tree->{right},$value); 
	} else {
		#warn ('duplicate random value');
	}

}

