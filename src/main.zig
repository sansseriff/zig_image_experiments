const std = @import("std");

const Allocator = std.mem.Allocator;

const c = @cImport(@cInclude("../stb_image_write/stb_image_write.h"));

pub fn main() !void {
    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    // std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

    // // stdout is for the actual output of your application, for example if you
    // // are implementing gzip, then only the compressed bytes should be sent to
    // // stdout, not any debugging messages.
    // const stdout_file = std.io.getStdOut().writer();
    // var bw = std.io.bufferedWriter(stdout_file);
    // const stdout = bw.writer();

    // try stdout.print("Run {any}\n", .{c.stbi_write_force_png_filter});

    // try bw.flush(); // don't forget to flush!

    // const rowStride = width * 3;

    // std.debug.print("here?\n", .{});
    var buffer: [30000]u8 = undefined;

    var i: u64 = 0;
    var j: u64 = 0;
    var k: u64 = 0;

    var r: u8 = 0;
    var g: u8 = 0;
    var b: u8 = 0;

    std.debug.print("starting\n", .{});
    while (i < 100) {
        // std.debug.print("thing: {any}\n", .{thing});
        j = 0;
        while (j < 100) {
            k = 0;
            r = @truncate(u8, @floatToInt(u64, 50 + (@intToFloat(f32, j) * 0.3) * (@intToFloat(f32, i) * 0.3) / 5.0));
            // g = @truncate(u8, 255 - 100 + i - j);
            g = @truncate(u8, @floatToInt(u64, 50 + (@intToFloat(f32, 100 - j) * 0.3) * (@intToFloat(f32, i) * 0.3) / 5.0));
            // b = @truncate(u8, i + j);
            b = @truncate(u8, @floatToInt(u64, 50 + (@intToFloat(f32, j) * 0.3) * (@intToFloat(f32, 100 - i) * 0.3) / 5.0));
            buffer[i * 300 + j * 3 + 0] = r;
            buffer[i * 300 + j * 3 + 1] = g;
            buffer[i * 300 + j * 3 + 2] = b;
            // buffer[i + j + 3] = a;
            j += 1;
        }
        i += 1;
    }

    var result = c.stbi_write_png("./test.png", 100, 100, 3, &buffer, 300);

    // var result = c.stbi_write_png(outPath, width, height, 3, buf, rowStride);
    if (result == 0) {
        return error.stbi_write_png_failed;
    }
}

const Pixel = struct { r: u8, g: u8, b: u8 };

fn pixel(i: u64, j: u64) Pixel {
    _ = Pixel{ .r = @intCast(u8, i), .g = @intCast(u8, j), .k = @intCast(u8, 32) };
}

// fn fill_pixel(*)

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
