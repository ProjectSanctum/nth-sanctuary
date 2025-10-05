local CubeBullet, super = Class(Bullet)

function CubeBullet:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/cube/cube")

    self.grazed = true
    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self:setScale(1)
    self.sprite:play(1/15, true)
end

function CubeBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super.update(self)
end

function CubeBullet:shouldSwoon(damage, target, soul)
    return true
end

return CubeBullet