const std = @import("std");
const r = @cImport({
    @cInclude("raylib.h");
});

// Global constants
const screenWidth = 960;
const screenHeight = 540;

const Player = struct {
    position: r.Vector2,
    size: r.Vector2,

    pub fn update_player_position(self: *Player) void {
        if (r.IsKeyDown(r.KEY_LEFT)) {
            self.position.x -= 1;
        }
        if (r.IsKeyDown(r.KEY_RIGHT)) {
            self.position.x += 1;
        }
        if (r.IsKeyDown(r.KEY_UP)) {
            self.position.y -= 1;
        }
        if (r.IsKeyDown(r.KEY_DOWN)) {
            self.position.y += 1;
        }
    }
};

pub fn main() !void {
    r.InitWindow(screenWidth, screenHeight, "poggers");
    r.SetTargetFPS(144);

    var rotation: f32 = 0.0;

    defer r.CloseWindow();

    var kirito = Player{
        .position = r.Vector2{ .x = 10, .y = 10 },
        .size = r.Vector2{ .x = 50, .y = 50 },
    };

    while (!r.WindowShouldClose()) {
        rotation += 0.8;

        // DRAW START
        r.BeginDrawing();

        r.ClearBackground(r.WHITE);
        r.DrawText("bela bola", 20, 20, 20, r.GRAY);

        r.DrawCircle(960 / 5, 120, 35, r.RED);
        r.DrawCircleGradient(960 / 5, 220, 60, r.GREEN, r.SKYBLUE);
        r.DrawCircleLines(960 / 5, 340, 80, r.DARKBLUE);

        r.DrawPoly((r.Vector2){ .x = 960 / 4.0 * 3, .y = 330 }, 6, 80, rotation, r.BROWN);
        r.DrawPolyLines((r.Vector2){ .x = 960 / 4.0 * 3, .y = 330 }, 6, 90, rotation, r.BROWN);
        r.DrawPolyLinesEx((r.Vector2){ .x = 960 / 4.0 * 3, .y = 330 }, 6, 85, rotation, 6, r.BEIGE);

        r.DrawRectangle(@intFromFloat(kirito.position.x), @intFromFloat(kirito.position.y), @intFromFloat(kirito.size.x), @intFromFloat(kirito.size.y), r.BLUE);

        kirito.update_player_position();

        r.ClearBackground(r.BLACK);
        r.EndDrawing();
        // DRAW END
    }
}
