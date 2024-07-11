const rl = @import("raylib");
const env = @import("environment.zig");
const game = @import("game.zig");

pub fn main() anyerror!void {
    rl.initWindow(
        env.SCREEN_WIDTH,
        env.SCREEN_HEIGHT,
        env.TITLE,
    );
    defer rl.closeWindow();

    // fps target
    rl.setTargetFPS(60);

    // game init
    var g = game.Game.init();

    // loop main
    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        // background
        rl.clearBackground(rl.Color.init(100, 234, 79, 255));

        // Draw the center circle
        // rl.drawCircleLines(env.SCREEN_WIDTH / 2, env.SCREEN_HEIGHT / 2, 50, rl.Color.white);
        rl.drawRing(rl.Vector2.init(env.SCREEN_WIDTH / 2, env.SCREEN_HEIGHT / 2), 100, 105, 0.0, 360.0, 0, rl.Color.white);

        // Draw the center line
        rl.drawLine(env.SCREEN_WIDTH / 2, 0, env.SCREEN_WIDTH / 2, env.SCREEN_HEIGHT, rl.Color.white);

        // game
        g.update();
        g.start();
    }
}
