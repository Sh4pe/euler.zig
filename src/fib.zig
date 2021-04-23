
pub const FibIterator = struct {
    a: usize,
    b: usize,

    const Self = @This();

    pub fn init(a: usize, b: usize) FibIterator {
        return FibIterator { .a = a, .b = b };
    }

    pub fn next(self: *Self) usize {
        var nxt = self.a + self.b;
        self.a = self.b;
        self.b = nxt;
        return nxt;
    }
};

