const std = @import("std");
const r = @cImport({
    @cInclude("raylib.h");
});

// Global constants
const screenWidth: f32 = 960;
const screenHeight: f32 = 540;

var gameOver: bool = false;

const Player = struct {
    position: r.Vector2,
    size: r.Vector2,
    life: i32,

    pub fn new_bro(position: r.Vector2, size: r.Vector2, life: i32) Player {
        return .{
            .position = position,
            .size = size,
            .life = life,
        };
    }

    pub fn update_player_position(self: *Player) void {
        if (r.IsKeyDown(r.KEY_LEFT) and self.position.x > 0) {
            self.position.x -= 10;
        }
        if (r.IsKeyDown(r.KEY_RIGHT) and self.position.x + self.size.x < screenWidth) {
            self.position.x += 10;
        }
        if (r.IsKeyDown(r.KEY_UP) and self.position.y > 0) {
            self.position.y -= 10;
        }
        if (r.IsKeyDown(r.KEY_DOWN) and self.position.y + self.size.y < screenHeight) {
            self.position.y += 10;
        }
    }

    pub fn draw(self: *const Player) void {
        r.DrawRectangle(@intFromFloat(self.position.x), @intFromFloat(self.position.y), @intFromFloat(self.size.x), @intFromFloat(self.size.y), r.BLUE);
    }

    pub fn reset_position(self: *Player, startPosition: r.Vector2) void {
        self.position = startPosition;
    }
};

// Collision Poly and Player
fn check_collision(player: Player, polyCenter: r.Vector2, polyRadius: f32) bool {
    const playerCenterX = player.position.x + player.size.x / 2;
    const playerCenterY = player.position.y + player.size.y / 2;
    const distX = playerCenterX - polyCenter.x;
    const distY = playerCenterY - polyCenter.y;
    const distance = std.math.sqrt(distX * distX + distY * distY);

    return distance < polyRadius + player.size.x / 2;
}

pub fn main() !void {
    r.InitWindow(screenWidth, screenHeight, "poggers");
    r.SetTargetFPS(144);

    const background = r.LoadImage("assets/map.png");
    const texture = r.LoadTextureFromImage(background);
    defer r.UnloadTexture(texture);
    r.UnloadImage(background);

    var rotation: f32 = 0.0;

    defer r.CloseWindow();

    const startPosition = r.Vector2{ .x = 10, .y = 10 };
    const polyCenter = r.Vector2{ .x = 960 / 4.0 * 3, .y = 330 };
    const polyRadius: f32 = 80;

    var kirito = Player.new_bro(startPosition, r.Vector2{ .x = 50, .y = 50 }, 22);

    while (!r.WindowShouldClose()) {
        if (gameOver) {
            kirito.reset_position(startPosition);
            gameOver = false;
        }

        // Player movement
        kirito.update_player_position();

        if (check_collision(kirito, polyCenter, polyRadius)) {
            gameOver = true;
        }

        r.BeginDrawing();

        r.ClearBackground(r.BLACK);
        r.DrawText("uh la la", 20, 20, 20, r.GRAY);

        const scaleX = screenWidth / 16 * 1;
        const scaleY = screenHeight / 9 * 1;
        const scale = if (scaleX < scaleY) scaleX else scaleY;

        r.DrawTextureEx(texture, r.Vector2{ .x = 0, .y = 0 }, 0.0, scale, r.WHITE);

        r.DrawPoly(polyCenter, 6, polyRadius, rotation, r.BROWN);
        r.DrawPolyLines(polyCenter, 6, polyRadius + 10, rotation, r.BROWN);
        r.DrawPolyLinesEx(polyCenter, 6, polyRadius + 5, rotation, 6, r.BEIGE);

        kirito.draw();

        r.EndDrawing();
        rotation += 0.8;
    }
}
