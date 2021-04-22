const std = @import("std");
const info = std.log.info;

pub fn problem(args: [][:0]u8) anyerror!void {
    for (args) |a| {
        info("{}", .{a});
    }
}