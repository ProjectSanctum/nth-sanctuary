local SmallBullet, super = Class(Bullet)

function SmallBullet:init(x, y, dir, speed, wave)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/holyfire/holyfire")

    self.sprite:play(1/10, true)
    self:setScale(1)
    self.wave = Game.battle.waves[1]

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.siner = 0
    self.wave.timer:script(function (wait)
        wait(1/30)
        self.sprite.visible = false
        wait(1/30)
        self.sprite.visible = true
        wait(1/30)
        self.sprite.visible = false
        wait(1/30)
        self.sprite.visible = true
        
    end)
end

function SmallBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update
    self.siner = self.siner + DTMULT
    self.x, self.y = self.x + math.sin(self.siner/5)*5, self.y + math.cos(self.siner/5)*5
    super.update(self)
end

return SmallBullet