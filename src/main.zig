const std = @import("std");
const info = std.log.info;
const err = std.log.err;
const expect = std.testing.expect;

const StringHashMap = std.StringHashMap;
const Allocator = std.mem.Allocator;


pub fn main() anyerror!void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        if (gpa.deinit()) {
            err("leaked stuff", .{});
        }
    }

    const args = try std.process.argsAlloc(&gpa.allocator);
    defer std.process.argsFree(&gpa.allocator, args);

    std.debug.assert(args.len >= 1);
    if (args.len >= 2) {
        var problem = args[1];
        var problemMap = try getProblemMap(&gpa.allocator);
        defer problemMap.deinit();

        if (problemMap.get(problem)) |problemFn| {
            return problemFn(&gpa.allocator, args[2..]);
        } else {
            info("Don't know what to do for problem '{}'.", .{problem});
        }
    } else {
        info("First parameter needs to be the problem name", .{});
    }

}

const ProblemFn = fn(*Allocator, [][:0]u8) anyerror!void;
const ProblemMap = StringHashMap(ProblemFn);

fn getProblemMap(allocator: *Allocator) !ProblemMap {
    var pm = ProblemMap.init(allocator);
    errdefer pm.deinit();

    try pm.put("1", @import("problems/1.zig").problem);

    return pm;
}

test "getProblemMap" {
    var pm = try getProblemMap(std.testing.allocator);
    defer pm.deinit();
}

test "problem tests" {
    _ = @import("problems/1.zig");
}