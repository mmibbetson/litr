//! File containing executable orchestration of the tangle command.
const std = @import("std");

// Runs the `tangle` subcommand.
pub fn run(gpa: std.mem.Allocator, args: []const []const u8) !noreturn {
    _ = gpa;
    _ = args;

    // TODO: Read file into buffer

    // TODO: Parse out tangle blocks

    // TODO: Sequence tangle blocks into output(s)

    // TODO: Write output into output files

    std.process.exit(0);
}

fn fatalHelp() noreturn {
    std.debug.print(
        \\Usage: litr tangle PATH [PATH...] [OPTIONS]
        \\
        \\   Does some stuff.
        \\
        \\Options:
        \\
        \\   --stdin          Validate a HTML document coming from stdin.
        \\                    Mutually exclusive with other input arguments.
        \\   --stdin-super    Same as --stdin but for SuperHTML files.
        \\   --syntax-only    Disable HTML element and attribute validation.
        \\   --help, -h       Print this help and exit.
        \\
    , .{});

    std.process.exit(1);
}
