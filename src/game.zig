const std = @import("std");
const env = @import("environment.zig");
const rl = @import("raylib");

const GAME_SPEED = 4;

pub const Game = struct {
    ball: env.Ball,
    player1: env.Player1,
    player2: env.Player2,

    pub fn init() Game {
        return Game{
            .ball = env.Ball.init(env.SCREEN_WIDTH / 2, env.SCREEN_HEIGHT / 2, 15, GAME_SPEED, rl.Color.white),
            .player1 = env.Player1.init(30, 50, 10, 50, GAME_SPEED, rl.Color.white, 0),
            .player2 = env.Player2.init(env.SCREEN_WIDTH - 40, 50, 10, 50, GAME_SPEED, rl.Color.white, 0),
        };
    }

    pub fn update(self: *Game) void {
        // ball update
        self.ball.update();

        // player update
        self.player1.move();
        self.player2.move();

        // ERROR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        // player 1
        if (self.ball.position.x <= self.player1.position.x + self.player1.size.x and
            self.ball.position.x + self.ball.size.x >= self.player1.position.x + self.player1.size.x and
            self.ball.position.y + self.ball.size.y >= self.player1.position.y and
            self.ball.position.y + self.ball.size.y <= self.player1.position.y + self.player1.size.y)
        {
            self.ball.speed.x *= -1;
        }

        // player 2
        if (self.ball.position.x + self.ball.size.x >= self.player2.position.x and
            self.ball.position.x <= self.player2.position.x + self.player2.size.x and
            self.ball.position.y + self.ball.size.y >= self.player2.position.y and
            self.ball.position.y <= self.player2.position.y + self.player2.size.y)
        {
            self.ball.speed.x *= -1;
        }

        // ball fail pong
        if (self.ball.position.x <= 0 or self.ball.position.x + self.ball.size.x >= env.SCREEN_WIDTH) {
            // player1 view if ball land in player1 field
            if (self.ball.position.x <= 0) {
                // score player1 ++
                self.player2.score += 1;

                // re-init ball
                self.ball = env.Ball.init(env.SCREEN_WIDTH / 2, env.SCREEN_HEIGHT / 2, 15, GAME_SPEED, rl.Color.white);
                self.ball.speed.x = @abs(self.ball.speed.x); // direct right
            }

            // player2 view if ball land in player2 field
            if (self.ball.position.x + self.ball.size.x >= env.SCREEN_WIDTH) {
                // score player2 ++
                self.player1.score += 1;

                // re-init ball
                self.ball = env.Ball.init(env.SCREEN_WIDTH / 2, env.SCREEN_HEIGHT / 2, 15, GAME_SPEED, rl.Color.white);
                self.ball.speed.x = -@abs(self.ball.speed.x); // direct left
            }
        }
    }

    pub fn start(self: *Game) void {
        self.ball.draw();
        self.player1.draw();
        self.player2.draw();

        // player inormation
        // player 1
        rl.drawText("player 1", 50, env.SCREEN_HEIGHT / 2 - 20, 20, rl.Color.white);
        rl.drawText(rl.textFormat("%d", .{self.player1.score}), 50, env.SCREEN_HEIGHT / 2 + 10, 20, rl.Color.white);

        // player 2
        rl.drawText("player 2", env.SCREEN_WIDTH - 150, env.SCREEN_HEIGHT / 2 - 20, 20, rl.Color.white);
        rl.drawText(rl.textFormat("%d", .{self.player2.score}), env.SCREEN_WIDTH - 150, env.SCREEN_HEIGHT / 2 + 10, 20, rl.Color.white);
    }
};
