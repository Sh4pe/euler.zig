const std = @import("std");
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;

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

const PrimeSetError = error {
    PrimeOverflow
};

pub const PrimeSet = struct {
    knownPrimes: std.ArrayList(usize),

    const Self = @This();

    /// deinitialize with deinit
    pub fn init(allocator: *Allocator) !Self {
        var kp = ArrayList(usize).init(allocator);
        try kp.append(2);
        try kp.append(3);
        std.debug.assert(kp.items.len == 2);

        return Self{ .knownPrimes =  kp };
    }

    /// Release all memory
    pub fn deinit(self: Self) void {
        self.knownPrimes.deinit();
    }

    /// Returns the largest known prime
    pub fn top(self: Self) usize {
        return self.knownPrimes.items[self.knownPrimes.items.len - 1];
    }

    /// Grow prime set, add next-largest prime
    pub fn grow(self: *Self) !void {
        var candidate = self.top() + 2;
        while (!(try self.isPrimeUsingKnownPrimes(candidate))) : (candidate += 2) {}

        try self.knownPrimes.append(candidate);
    }

    fn isPrimeUsingKnownPrimes(self: Self, candidate: usize) !bool {
        std.debug.assert(candidate > 1);

        var sq = std.math.sqrt(candidate);
        var i: usize = 0;
        var testPrime = self.knownPrimes.items[i];

        while (testPrime <= sq) {
            if (candidate % testPrime == 0) {
                return false;
            }

            i += 1;
            if (i >= self.knownPrimes.items.len) {
                return PrimeSetError.PrimeOverflow;
            }
            testPrime = self.knownPrimes.items[i];
        }
        return true;
    }
};
