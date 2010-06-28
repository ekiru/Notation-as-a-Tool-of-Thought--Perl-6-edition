#!/usr/bin/env perl6

use v6;

sub perl6 ($file) {
    run "perl6 $file";
}

perl6 'intro.p6';
perl6 '1.p6';
