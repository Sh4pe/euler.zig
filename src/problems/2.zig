const std = @import("std");
const info = std.log.info;
const expect = std.testing.expect;

const FibIterator = @import("../fib.zig").FibIterator;

const Allocator = std.mem.Allocator;

fn sum() usize {
    var it = FibIterator.init(1, 2);

    // because the 2nd term '2' is even
    var s: usize = 2;
    var i = it.next();
    while (i <= 4000000) {
        if (i % 2 == 0) {
            s += i;
        }
        i = it.next();
    }

    return s;
}

pub fn problem(allocator: *Allocator, args: [][:0]u8) anyerror!void {
    info("sum: {}", .{sum()});
}

test "problem 2" {
    expect(sum() == 4613732);
}