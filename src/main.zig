const std = @import("std");
const r = @cImport({
    @cInclude("raylib.h");
});

pub fn main() !void {
    r.InitWindow(960, 540, "poggers");
    r.SetTargetFPS(144);

    var rotation: f32 = 0.0;

    defer r.CloseWindow();

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

        r.ClearBackground(r.BLACK);
        r.EndDrawing();
        // DRAW END
    }
}
