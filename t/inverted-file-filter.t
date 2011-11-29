use strict;
use warnings;
use lib 't';

use Test::More tests => 4;
use Util;

prep_environment();

EXCLUDE_ONLY: {
    my @expected = ( qw(
        t/swamp/c-header.h
        t/swamp/c-source.c
        t/swamp/crystallography-weenies.f
        t/swamp/file.bar
        t/swamp/file.foo
        t/swamp/groceries/another_subdir/fruit
        t/swamp/groceries/another_subdir/junk
        t/swamp/groceries/another_subdir/meat
        t/swamp/groceries/fruit
        t/swamp/groceries/junk
        t/swamp/groceries/meat
        t/swamp/groceries/subdir/fruit
        t/swamp/groceries/subdir/junk
        t/swamp/groceries/subdir/meat
        t/swamp/html.htm
        t/swamp/html.html
        t/swamp/incomplete-last-line.txt
        t/swamp/javascript.js
        t/swamp/Makefile
        t/swamp/notaMakefile
        t/swamp/notaRakefile
        t/swamp/parrot.pir
        t/swamp/pipe-stress-freaks.F
        t/swamp/Rakefile
        t/swamp/sample.rake
        t/swamp/stuff.cmake
        t/swamp/CMakeLists.txt
        ),
        't/swamp/not-an-#emacs-workfile#',
    );

    my @args = qw( --ackrc=./ackrc --noperl -f t/swamp );
    my @results = run_ack( @args );

    sets_match( \@results, \@expected );
}

INCLUDE_PLUS_EXCLUDE_ONLY: {
    my @expected = qw(
        t/swamp/0
        t/swamp/perl.pm
        t/swamp/options.pl
        t/swamp/options.pl.bak
        t/swamp/perl-without-extension
        t/swamp/perl.cgi
        t/swamp/Makefile.PL
        t/swamp/perl-test.t
        t/swamp/perl.pl
    );

    my @args = ( '--ackrc=./ackrc', '--type-add=pod,ext,pod', '--perl',
                 '--nopod', '-f', 't/swamp' );
    my @results = run_ack( @args );

    sets_match( \@results, \@expected );
}