#! /usr/bin/env perl

use strict;
use warnings;
use OpenSSL::Test qw/:DEFAULT data_file/;
use OpenSSL::Test::Utils;

setup("test_includes");

plan skip_all => "test_includes doesn't work without posix-io"
    if disabled("posix-io");

delete $ENV{OPENSSL_CONF_INCLUDE};

plan tests => 6;                  # The number of tests being performed

ok(run(test(["conf_include_test", data_file("includes.cnf")])), "test directory includes");
ok(run(test(["conf_include_test", data_file("includes-file.cnf")])), "test file includes");
ok(run(test(["conf_include_test", data_file("includes-eq.cnf")])), "test includes with equal character");
ok(run(test(["conf_include_test", data_file("includes-eq-ws.cnf")])), "test includes with equal and whitespaces");
ok(run(test(["conf_include_test", "-f", data_file("includes-broken.cnf")])), "test broken includes");
ok(run(test(["conf_include_test",  "-f", data_file("incdir.cnf")])), "test includedir");
