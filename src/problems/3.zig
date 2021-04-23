const std = @import("std");
const info = std.log.info;
const expect = std.testing.expect;

const max = std.math.max;

const Allocator = std.mem.Allocator;
const PrimeFactorIterator = @import("../prime.zig").PrimeFactorIterator;

fn largestFactorOf(N: usize) usize {
    var primeIt = PrimeFactorIterator.init(N);
    var cur = primeIt.next();
    var largest: usize = 0;

    while (cur) |factor| : (cur = primeIt.next()) {
        largest = max(largest, factor);
    }

    return largest;
}

pub fn problem(allocator: *Allocator, args: [][:0]u8) anyerror!void {
    info("largest factor: {}", .{largestFactorOf(600851475143)});
}

test "problem 3" {
    expect(largestFactorOf(600851475143) == 6857);
}