#!/usr/bin/perl

package DoubleDecliningBalanceStrategy;
use StraightLineStrategy;

@ISA = qw(StraightLineStrategy);

sub depreciation_expense
{
  my ($self) = @_;
  my $ddb_depreciation = 2 * $self->book_value() / $self->total_useful_life();
  my $slm_depreciation = ($self->book_value() - $self->salvage_value()) / $self->remaining_useful_life();
  $self->{depreciation_expense} = ($ddb_depreciation < $self->SUPER::depreciation_expense()) ? $slm_depreciation : $ddb_depreciation;
  return $self->{depreciation_expense};
}
