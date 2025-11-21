const std = @import("std");

const TangleConfig = struct {
    // The token that indicates a comment line has begun. Enforce nothing prior?
    // e.g. `<!--`, `#`, `//`, etc.
    document_comment_token: []const u8,
};

const TangleBlock = struct {
    // The name of the file that this block is to be written to
    output_file_name: []const u8,
    // The position of the block for tangling order. TODO: Should I use u32 instead?
    position: usize,
    // The actual string content of code to be tangled
    content: []const u8,
};

pub fn readInputFile(io: std.Io, allocator: std.mem.Allocator, inputFile: File) !void {
    const file = try std.fs.cwd().openFile("output.txt", .{});
    defer file.close();
    const reader = file.readerStreaming(io, buffer: []u8);
    reader.interface.readSliceAll(buffer: []u8)

    var buf: [1024]u8 = undefined;
    while (try reader.readUntilDelimiterOrEof(buf[0..], '\n')) |line| {
        std.log.info("{s}", .{line});
    }
}

// Parses the demarcated tangle blocks from a source file into a slice of strings. Each string in the slice is a block
// pub fn parseTangleBlocks(io: std.Io, allocator: std.mem.Allocator, input: std.fs.File, config: TangleConfig) !?[]TangleBlock {}

// pub fn formatTangleOutput([]TangleBlock) {}

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
