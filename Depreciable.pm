#!/usr/bin/perl

package Depreciable;
use DepreciationStrategy;

sub new
{
   my $class = shift;
   my $self = {
      strategy => shift
   };
   bless $self, $class;
   return $self;
}

sub strategy
{
   my ($self, $new_strategy) = @_;
   $self->{strategy} = $new_strategy if defined($new_strategy);
   return $self->{strategy};
}

sub __printJournalEntry__
{
   my ($self) = @_;
   my $dep_exp = $self->strategy()->delta_accumulated_depreciation();

   print "Depreciation Expense (+E, -SE)\t".$dep_exp."\n";
   print "\tAccumulated Depreciation (-A)\t".$dep_exp."\n\n";
}

sub __printBalanceSummary__
{
   my ($self) = @_;
   print "Balance Sheet Balances:\t";
   print "(Book Value = ".$self->strategy()->book_value().", ";
   print "Accumulated Depreciation = ".$self->strategy()->accumulated_depreciation().")\n\n";
}

sub printInfo
{
   my ($self) = @_;
   $N = $self->strategy()->total_useful_life();

   print "---------------------\n";
   print "Year 0\n";
   print "Equipment (+A)\t".$self->strategy()->book_value();
   print "\tCash(-A)\t".$self->strategy()->book_value()."\n";

   for my $i (1..$N) {
      print "---------------------\n";
      print "Year ".$i.":\n";
      $self->__printJournalEntry__();  
      $self->__printBalanceSummary__(); 
   }
}
1;
