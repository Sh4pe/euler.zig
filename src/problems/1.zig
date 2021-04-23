const std = @import("std");
const info = std.log.info;
const expect = std.testing.expect;

const Allocator = std.mem.Allocator;

fn sum(N: usize) usize {
    var i: usize = 1;
    var s: usize = 0;
    while (i < N) {

        if ((i % 3 == 0) or (i % 5 == 0)) {
            s += i;
        }

        i += 1;
    }
    return s;
}

pub fn problem(allocator: *Allocator, args: [][:0]u8) anyerror!void {
    info("sum: {}", .{sum(1000)});
}

test "problem 1" {
    expect(sum(1000) == 233168);
}