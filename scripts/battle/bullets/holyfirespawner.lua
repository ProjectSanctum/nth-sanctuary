local SmallBullet, super = Class(Bullet)

function SmallBullet:init(x, y, dir, speed, wave)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/smallbullet")
    self:setHitbox(nil)
    self.sprite.visible = false

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    self.wave = wave
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.subs = {}
    self.wave.timer:script(function (wait)
        table.insert(self.subs, self.wave:spawnBullet("holyfire", x, y, 0, 0, dir))
        wait(1/3)
        table.insert(self.subs, self.wave:spawnBullet("holyfire", x, y, 0, 0, dir))
        wait(1/3)
        table.insert(self.subs, self.wave:spawnBullet("holyfire", x, y, 0, 0, dir))
    end)
end

function SmallBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update
    super.update(self)
end

return SmallBullet