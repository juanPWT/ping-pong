const rl = @import("raylib");
const env = @import("environment.zig");
const game = @import("game.zig");

var isMenu: bool = true;

const ModeGame = enum {
    Pvp,
    VsCom,
};

// mode game
var mode: ModeGame = ModeGame.Pvp;

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
    var gPvp = game.GameModePvp.init();
    var gVsCom = game.GameModeVsCom.init();

    // loop main
    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        // menu
        if (isMenu) {
            // menu screen
            menuScreen();
        } else {
            // background
            rl.clearBackground(rl.Color.init(100, 234, 79, 255));

            // mode game
            switch (mode) {
                .Pvp => modePvp(&gPvp),
                .VsCom => modeVsCom(&gVsCom),
            }
        }
    }
}

fn modePvp(g: *game.GameModePvp) void {
    // Draw the center circle
    rl.drawRing(rl.Vector2.init(env.SCREEN_WIDTH / 2, env.SCREEN_HEIGHT / 2), 100, 105, 0.0, 360.0, 0, rl.Color.white);

    // Draw the center line
    rl.drawLine(env.SCREEN_WIDTH / 2, 0, env.SCREEN_WIDTH / 2, env.SCREEN_HEIGHT, rl.Color.white);

    // limitation player field
    rl.drawLine(30, 0, 30, env.SCREEN_HEIGHT, rl.Color.white);
    rl.drawLine(env.SCREEN_WIDTH - 30, 0, env.SCREEN_WIDTH - 30, env.SCREEN_HEIGHT, rl.Color.white);

    // game
    g.update();
    g.start();
}

fn modeVsCom(g: *game.GameModeVsCom) void {
    // Draw the center circle
    rl.drawRing(rl.Vector2.init(env.SCREEN_WIDTH / 2, env.SCREEN_HEIGHT / 2), 100, 105, 0.0, 360.0, 0, rl.Color.white);

    // Draw the center line
    rl.drawLine(env.SCREEN_WIDTH / 2, 0, env.SCREEN_WIDTH / 2, env.SCREEN_HEIGHT, rl.Color.white);

    // limitation player and ai field
    rl.drawLine(30, 0, 30, env.SCREEN_HEIGHT, rl.Color.white);
    rl.drawLine(env.SCREEN_WIDTH - 30, 0, env.SCREEN_WIDTH - 30, env.SCREEN_HEIGHT, rl.Color.white);

    // game
    g.update();
    g.start();
}

fn menuScreen() void {
    rl.clearBackground(rl.Color.white);
    drawCenterText("Welocome to ping-pong game", env.SCREEN_HEIGHT / 2, 50, rl.Color.init(100, 234, 79, 255));
    drawCenterText("press p to mode PvP and press c to VsCom", env.SCREEN_HEIGHT / 2 + 60, 20, rl.Color.init(100, 234, 79, 255));

    if (rl.isKeyDown(rl.KeyboardKey.key_p)) {
        isMenu = false;
        mode = ModeGame.Pvp;
    } else if (rl.isKeyDown(rl.KeyboardKey.key_c)) {
        isMenu = false;
        mode = ModeGame.VsCom;
    }
}

fn drawCenterText(text: [:0]const u8, posY: i32, fontSize: i32, color: rl.Color) void {
    const textWidth = rl.measureText(text, fontSize);
    const ceterX = @divTrunc(env.SCREEN_WIDTH - textWidth, 2);
    rl.drawText(text, ceterX, posY, fontSize, color);
}
