const std = @import("std");
const info = std.log.info;
const expect = std.testing.expect;

const Allocator = std.mem.Allocator;

pub fn isPalindromic(N: usize) !bool {
    var buf: [20]u8 = undefined;
    var str = try std.fmt.bufPrint(&buf, "{}", .{N});

    var i: usize = 0;
    while (i < str.len / 2) : (i += 1) {
        if (str[i] != str[str.len - 1 - i]) {
            return false;
        }
    }
    return true;
}

fn largestPalindrome() !usize {
    var max: usize = 1;

    var i: usize = 100;
    while (i <= 999) : (i += 1) {
        var j: usize = 100;
        while (j <= 999) : (j += 1) {
            var prod = i * j;
            if (try isPalindromic(prod)) {
                max = std.math.max(prod, max);
            }
        }
    }

    return max;
}

pub fn problem(allocator: *Allocator, args: [][:0]u8) anyerror!void {
    info("largest palindrome: {}", .{largestPalindrome()});
}

test "problem 3" {
    expect((try largestPalindrome()) == 906609);
}

test "isPalindromic" {
    expect(try isPalindromic(9009));
    expect(try isPalindromic(91019));
    expect(try isPalindromic(91819));
    expect(!(try isPalindromic(91018)));
}
