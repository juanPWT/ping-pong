const rl = @import("raylib");
const key = rl.KeyboardKey;

// game init
pub const TITLE = "ping pong!";
pub const SCREEN_WIDTH = 1280;
pub const SCREEN_HEIGHT = 600;

pub const Ball = struct {
    position: rl.Vector2,
    size: rl.Vector2,
    speed: rl.Vector2,
    color: rl.Color,

    pub fn init(x: f32, y: f32, size: f32, speed: f32, color: rl.Color) Ball {
        return Ball{
            .position = rl.Vector2.init(x, y),
            .size = rl.Vector2.init(size, size),
            .speed = rl.Vector2.init(speed, speed),
            .color = color,
        };
    }

    pub fn update(self: *Ball) void {
        // ball movement
        self.position = rl.math.vector2Add(self.position, self.speed);

        // pong x line
        if (self.position.x <= 0 or self.position.x + self.size.x >= SCREEN_WIDTH) {
            self.speed.x *= -1;
        }

        // pong y line
        if (self.position.y <= 0 or self.position.y + self.size.y >= SCREEN_HEIGHT) {
            self.speed.y *= -1;
        }
    }

    pub fn draw(self: *Ball) void {
        // rl.drawRectangleV(self.position, self.size, self.color);
        rl.drawCircleV(self.position, self.size.x, self.color);
    }
};

pub const Player1 = struct {
    position: rl.Vector2,
    size: rl.Vector2,
    speed: rl.Vector2,
    color: rl.Color,
    score: u8,

    pub fn init(x: f32, y: f32, sizeX: f32, sizeY: f32, speed: f32, color: rl.Color, score: u8) Player1 {
        return Player1{
            .position = rl.Vector2.init(x, y),
            .size = rl.Vector2.init(sizeX, sizeY),
            .speed = rl.Vector2.init(speed, speed),
            .color = color,
            .score = score,
        };
    }

    pub fn move(self: *Player1) void {
        if (rl.isKeyDown(key.key_w)) {
            // how Player1 move to up with speed?
            if (self.position.y >= 0) self.position.y -= self.speed.y;
        } else if (rl.isKeyDown(key.key_s)) {
            // how Player1 move to down with speed?
            if (self.position.y + self.size.y <= SCREEN_HEIGHT) self.position.y += self.speed.y;
        }
    }

    pub fn draw(self: *Player1) void {
        rl.drawRectangleV(self.position, self.size, self.color);
    }
};

pub const Player2 = struct {
    position: rl.Vector2,
    size: rl.Vector2,
    speed: rl.Vector2,
    color: rl.Color,
    score: u8,

    pub fn init(x: f32, y: f32, sizeX: f32, sizeY: f32, speed: f32, color: rl.Color, score: u8) Player2 {
        return Player2{
            .position = rl.Vector2.init(x, y),
            .size = rl.Vector2.init(sizeX, sizeY),
            .speed = rl.Vector2.init(speed, speed),
            .color = color,
            .score = score,
        };
    }

    pub fn move(self: *Player2) void {
        if (rl.isKeyDown(key.key_up)) {
            // how Player1 move to up with speed?
            if (self.position.y >= 0) self.position.y -= self.speed.y;
        } else if (rl.isKeyDown(key.key_down)) {
            // how Player1 move to down with speed?
            if (self.position.y + self.size.y <= SCREEN_HEIGHT) self.position.y += self.speed.y;
        }
    }

    pub fn draw(self: *Player2) void {
        rl.drawRectangleV(self.position, self.size, self.color);
    }
};
