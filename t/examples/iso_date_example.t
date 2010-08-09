#!/usr/bin/perl -w

# An example using defaults and required params

package Foo;

use Test::More tests => 3;

use Method::Signatures;

func iso_date(
    :$year!,    :$month = 1, :$day = 1,
    :$hour = 0, :$min   = 0, :$sec = 0
)
{
    return sprintf "%04d-%02d-%02d %02d:%02d:%02d", $year, $month, $day, $hour, $min, $sec;
}

is( iso_date(year => 2008), "2008-01-01 00:00:00" );
#line 25
ok !eval {
    iso_date();
};
is $@, "Foo::iso_date() missing required argument \$year at $0 line 26.\n";
