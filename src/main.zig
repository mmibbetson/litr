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

    // INFO: If no subcommand is provided, fail with usage information.
    if (args.len < 2) fatalHelp();

    const cmd = std.meta.stringToEnum(Command, args[1]) orelse {
        std.debug.print("Unrecognized subcommand: '{s}'.\n\n", .{args[1]});
        fatalHelp();
    };

    _ = switch (cmd) {
        .tangle => try tangle_cmd.run(gpa, args[2..]),
        .help => printHelp(),
        .version => printVersion(),
    };
}

const Command = enum { tangle, help, version };

const help_text =
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
;

fn fatalHelp() noreturn {
    std.debug.print(help_text, .{});
    std.process.exit(1);
}

fn printHelp() noreturn {
    std.debug.print(help_text, .{});
    std.process.exit(0);
}

fn printVersion() noreturn {
    std.debug.print("{s}\n", .{build_options.version});
    std.process.exit(0);
}
