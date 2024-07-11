// TODO: make score player and rule if score 10 player won?

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
            .player1 = env.Player1.init(0, 50, 10, 50, GAME_SPEED, rl.Color.white),
            .player2 = env.Player2.init(env.SCREEN_WIDTH - 10, 50, 10, 50, GAME_SPEED, rl.Color.white),
        };
    }

    pub fn update(self: *Game) void {
        // ball update
        self.ball.update();

        // player update
        self.player1.move();
        self.player2.move();

        // player 1
        if (self.ball.position.x <= self.player1.position.x + self.player1.size.x and self.ball.position.y >= self.player1.position.y and self.ball.position.y <= self.player1.position.y + self.player1.size.y) {
            return;
        }

        // player 2
        if (self.ball.position.x <= self.player2.position.x + self.player2.size.x and self.ball.position.y >= self.player2.position.y and self.ball.position.y <= self.player2.position.y + self.player2.size.y) {
            return;
        }

        // ball fail pong
        if (self.ball.position.x <= 0 or self.ball.position.x + self.ball.size.x >= env.SCREEN_WIDTH) {
            // player1 view if ball land in player1 field
            if (self.ball.position.x <= 0) {
                // re-init ball
                self.ball = env.Ball.init(env.SCREEN_WIDTH / 2, env.SCREEN_HEIGHT / 2, 15, GAME_SPEED, rl.Color.white);
                self.ball.speed.x = @abs(self.ball.speed.x); // direct right
            }

            // player2 view if ball land in player2 field
            if (self.ball.position.x + self.ball.size.x >= env.SCREEN_WIDTH) {
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
    }
};
