const std = @import("std");
const AutoArrayHashmap = std.AutoArrayHashMap;

pub const TangleBlock = struct {
    // The name of the file that this block is to be written to
    output_file_name: []const u8,

    // The position of the block for tangling order. TODO: Should I use u32 instead?
    position: usize,

    // The actual string content of code to be tangled
    content: []const u8,
};

// Takes an input string and parses out an array of arrays of TangleBlocks. Each array
// is a partition based on the `.output_file_name` field.
pub fn parseTangleBlocks(allocator: std.mem.Allocator, input: []const u8) !?AutoArrayHashmap([]const u8, []TangleBlock) {
    const out = AutoArrayHashmap([]const u8, []TangleBlock).init(allocator);
    _ = input;

    return out;
}

// Takes a collection of TangleBlocks and concatenates & sequences them
// pub fn formatTangleOutput([]TangleBlock) []const u8 {}

// Does sorts a TangleBlock collection by `position`.
// fn sortTangleBlocks() []TangleBlock {}

test "can parse tangle block with output file" {}
test "cannot parse tangle block without output file" {}
test "can parse tangle block with position" {
    // TODO: Confirm that it autoincrements position in the sequence
    // that it reads blocks.
}
test "can parse tangle block without position" {}

const test_input_djot =
    \\\# Title Here
    \\\
    \\\This is an example document that can be tangled. Here's the first code block:
    \\\
    \\\{% tangle hello.zig 2 ``` %}
    \\\``` =zig
    \\\pub fn main() !void {
    \\\std.debug.print("Hello, world!", .{});
    \\\}
    \\\```
    \\\{% tangle end %}
    \\\
    \\\The block above will be output into the tangled source code *after* the next block.
    \\\
    \\\{% tangle hello.zig 1 ``` %}
    \\\``` =zig
    \\\const std = @import("std");
    \\\```
    \\\{% tangle end %}
    \\\
    \\\If two blocks are declared with the same position, `litr` should print an error explaining this conflict.
;

const test_input_markdown =
    \\\# Title Here
    \\\
    \\\This is an example document that can be tangled. Here's the first code block:
    \\\
    \\\<!-- tangle hello.zig 2 ``` -->
    \\\``` =zig
    \\\pub fn main() !void {
    \\\std.debug.print("Hello, world!", .{});
    \\\}
    \\\```
    \\\<!-- tangle end -->
    \\\
    \\\The block above will be output into the tangled source code **after** the next block.
    \\\
    \\\<!-- tangle hello.zig 1 ``` -->
    \\\``` =zig
    \\\const std = @import("std");
    \\\```
    \\\<!-- tangle end -->
    \\\
    \\\If two blocks are declared with the same position, `litr` should print an error explaining this conflict.
;
