#!/usr/bin/perl

package main;

use strict;
use diagnostics;
use warnings;

use Switch;
use Scalar::Util qw(looks_like_number);

use StraightLineStrategy;
use DoubleDecliningBalanceStrategy;
use SumOfTheYearDigitsStrategy;
use Depreciable;

sub get_historical_cost
{
   my $historical_cost = "";
   while (!looks_like_number($historical_cost)) {
      print "Enter historical cost :: ";
      $historical_cost = <STDIN>;
   }
   return $historical_cost;
}

sub get_salvage_value
{
   my $salvage_value = "";
   while (!looks_like_number($salvage_value)) {
      print "Enter salvage value :: ";
      $salvage_value = <STDIN>;
   }
   return $salvage_value;
}

sub get_useful_life
{
   my $useful_life = "";
   while (!looks_like_number($useful_life)) {
      print "Enter useful life :: ";
      $useful_life = <STDIN>;
   }
   return $useful_life;
}

sub select_strategy
{
   my $done = 0;
   my $method;

   while ($done == 0) {
      print "\n----Select a depreciation method----\n";
      print "(1) for Straight-Line Depreciation,\n";
      print "(2) for Double-Declining Balance,\n";
      print "(3) for Sum-Of-The-Year-Digits\n";
      print "\nEnter one of (1), (2), or (3) :: ";
      $method = <STDIN>;
      $done = !($method < 1 || $method > 3);
   }

   return $method;
}

sub process_inputs 
{
   my $hc = get_historical_cost();
   my $sv = get_salvage_value();
   my $lifespan = get_useful_life(); 
   my $selected_strategy = select_strategy();
   my $strategy;

   switch($selected_strategy) {
       case 1  { $strategy = new StraightLineStrategy($hc, $sv, $lifespan); }
       case 2  { $strategy = new DoubleDecliningBalanceStrategy($hc, $sv, $lifespan); }
       case 3  { $strategy = new SumOfTheYearDigitsStrategy($hc, $sv, $lifespan); }
   }

   return $strategy;
}

sub main
{
   my $dep = new Depreciable(process_inputs());
   $dep->printInfo();
}

main();
