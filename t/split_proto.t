#!/usr/bin/perl -w

use strict;
use warnings;

use Test::More 'no_plan';

use Method::Signatures::Parser;

my %tests = (
    '$foo'              => ['$foo'],
    '$foo, $bar'        => ['$foo', '$bar'],
    ':$foo, $bar?'      => [':$foo', '$bar?'],
    ''                  => [],
    '$sum = 2+2, $div = 2/2'    => ['$sum = 2+2', '$div = 2/2'],
    '$foo = "Hello, world!"'    => ['$foo = "Hello, world!"'],
    '@args = (1,2,3)'   => ['@args = (1,2,3)'],
    '$foo = [1,2,3], $bar = { this => 23, that => 42 }' => [
        '$foo = [1,2,3]', '$bar = { this => 23, that => 42 }'
    ],
    '$code = sub { my $bar = 2+2; }, :$this'    =>  ['$code = sub { my $bar = 2+2; }', ':$this'],

    q[
        $num    = 42,
        $string = q[Hello, world!],
        $hash   = { this => 42, that => 23 },
        $code   = sub { $num + 4 },
        @nums   = (1,2,3)
    ]   =>
    [
        '$num    = 42',
        '$string = q[Hello, world!]',
        '$hash   = { this => 42, that => 23 }',
        '$code   = sub { $num + 4 }',
        '@nums   = (1,2,3)'
    ],
);

while(my($args, $expect) = each %tests) {
    is_deeply [split_proto($args)], $expect, "split_proto($args)";
}
