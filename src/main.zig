//! Root file for cli executable.
const std = @import("std");
const build_options = @import("build_options");
const tangle_cmd = @import("cli/tangle.zig");

// Entrypoint for the `litr` executable.
pub fn main() !void {
    var gpa_impl: std.heap.GeneralPurposeAllocator(.{}) = .{};
    defer _ = gpa_impl.deinit();
    const gpa = gpa_impl.allocator();

    const args = try std.process.argsAlloc(gpa);
    defer std.process.argsFree(gpa, args);

    // INFO: If no subcommand is provided, print usage information.
    if (args.len < 2) printHelp(1);

    const cmd = std.meta.stringToEnum(Command, args[1]) orelse {
        std.debug.print("Unrecognized subcommand: '{s}'.\n\n", .{args[1]});
        printHelp(1);
    };

    _ = switch (cmd) {
        .tangle => try tangle_cmd.run(gpa, args[2..]),
        .help => printHelp(0),
        .version => printVersion(),
    };
}

const Command = enum { tangle, help, version };

fn printHelp(status_code: u8) noreturn {
    std.debug.print(
        \\Usage: litr COMMAND [OPTIONS]
        \\
        \\Commands:
        \\  tangle        Tangle source code from a document.
        \\  help          Show this menu and exit.
        \\  version       Print the version and exit.
        \\
        \\General Options:
        \\  --help, -h        Print command specific usage.
        \\
    , .{});

    std.process.exit(status_code);
}

fn printVersion() noreturn {
    std.debug.print("{s}\n", .{build_options.version});
    std.process.exit(0);
}
