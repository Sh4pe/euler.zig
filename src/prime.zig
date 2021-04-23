const std = @import("std");

pub const PrimeFactorIterator = struct {
    remainder: usize,

    const Self = @This();

    pub fn init(N: usize) PrimeFactorIterator {
        std.debug.assert(N >= 2);
        return PrimeFactorIterator{ .remainder = N };
    }

    pub fn next(self: *Self) ?usize {
        if (self.remainder == 1) {
            return null;
        }

        if (self.remainder % 2 == 0) {
            self.remainder /= 2;
            return 2;
        }

        var sq = std.math.sqrt(self.remainder);
        var i: usize = 3;

        while (i <= sq) : (i += 2) {
            if (self.remainder % i == 0) {
                self.remainder /= i;
                return i;
            }
        }

        var buf = self.remainder;
        self.remainder = 1;
        return buf;
    }
};
