const std = @import("std");
const info = std.log.info;
const expect = std.testing.expect;

const Allocator = std.mem.Allocator;
const PrimeSet = @import("../prime.zig").PrimeSet;

/// N is zero based, i.e. N = 0 yields 2, N = 1 yields 3, ...
fn getNthPrime(allocator: *Allocator, N: usize) !usize {
    std.debug.assert(N >= 1);

    var primes = try PrimeSet.init(allocator);
    defer primes.deinit();

    var i: usize = 1;
    while (i < N) : (i += 1) {
        try primes.grow();
    }

    return primes.top();
}

pub fn problem(allocator: *Allocator, args: [][:0]u8) anyerror!void {
    var N: usize = 10000;
    info("10 001th prime: {}", .{try getNthPrime(allocator, N)});
}

test "problem 7" {
    var N: usize = 10000;
    expect((try getNthPrime(std.testing.allocator, N)) == 104743);
}

