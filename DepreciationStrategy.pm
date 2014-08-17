#!/usr/bin/perl

package DepreciationStrategy;

sub new
{
  my $class = shift;
  my $self = {
     book_value => shift,
     salvage_value => shift,
     total_useful_life => shift,
     depreciation_expense => 0,
     accumulated_depreciation => 0 
  };

  $self->{historical_cost} = $self->{book_value};
  $self->{remaining_useful_life} = $self->{total_useful_life};

  bless $self, $class;
  return $self;
}

sub historical_cost
{
  my ($self, $new_historical_cost) = @_;
  $self->{historical_cost} = $new_historical_cost if defined($new_historical_cost);
  return $self->{historical_cost};
}

sub book_value
{
  my ($self, $new_book_value) = @_;
  $self->{book_value} = $new_book_value if defined($new_book_value);
  return $self->{book_value};
}

sub salvage_value
{
  my ($self, $new_salvage_value) = @_;
  $self->{salvage_value} = $new_salvage_value if defined($new_salvage_value);
  return $self->{salvage_value};
}

sub total_useful_life
{
  my ($self, $new_total_life) = @_;
  $self->{total_useful_life} = $new_total_life if defined($new_total_life);
  return $self->{total_useful_life};
}

sub remaining_useful_life
{
  my ($self, $new_remaining_life) = @_;
  $self->{remaining_useful_life} = $new_remaining_life if defined($new_remaining_life);
  return $self->{remaining_useful_life};
}

sub accumulated_depreciation
{
  my ($self, $acc_dep) = @_;
  $self->{accumulated_depreciation} = $acc_dep if defined($acc_dep);
  return $self->{accumulated_depreciation};
}

sub depreciation_expense;

sub depreciate
{
  my ($self) = @_;
  if ($self->book_value() > $self->salvage_value()) {
      $dep_expense = $self->depreciation_expense();
      $self->accumulated_depreciation($self->accumulated_depreciation() + $dep_expense);
      $self->book_value($self->book_value() - $dep_expense);
      $self->remaining_useful_life($self->remaining_useful_life() - 1);
  }
}

sub delta_accumulated_depreciation
{
  my ($self) = @_;
  my $dep1 = $self->accumulated_depreciation();
  $self->depreciate();
  my $dep2 = $self->accumulated_depreciation();
  return $dep2 - $dep1;
}
1;
