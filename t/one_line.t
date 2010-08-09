#!/usr/bin/perl -w

# Test that declaring on one line works.

use Test::More tests => 1;

{
    package Thing;

    use Method::Signatures;
    func foo {"wibble"}

    ::is( foo, "wibble" );
}
