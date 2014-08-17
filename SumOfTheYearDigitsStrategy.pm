#!/usr/bin/perl

package SumOfTheYearDigitsStrategy;
use DepreciationStrategy;

@ISA = qw(DepreciationStrategy);

sub depreciation_expense
{
  my ($self) = @_;
  my $n = $self->total_useful_life();
  my $sum = $n * ($n + 1) / 2; # Shortcut to calculate sum of #s b/w 1 and n
  my $ratio = $self->remaining_useful_life() / $sum;
  $self->{depreciation_expense} = ($self->historical_cost() - $self->salvage_value()) * $ratio;
  return $self->{depreciation_expense};
}
1;
