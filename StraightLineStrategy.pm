#!/usr/bin/perl

package StraightLineStrategy;
use DepreciationStrategy;

@ISA = qw(DepreciationStrategy);

sub depreciation_expense
{
  my ($self) = @_;
  $self->{depreciation_expense} = ($self->historical_cost() - $self->salvage_value()) / $self->total_useful_life();
  return $self->{depreciation_expense};
}
1;
