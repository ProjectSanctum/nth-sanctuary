local TestBullet, super = Class(WorldBullet)

function TestBullet:init(x, y, flip, flip2)
    super.init(self, x, y, "bullets/world/shape/shape")

    if flip then
        self.flip_x = true
        self.physics.direction = math.pi
    end
    if flip2 then
        self.physics.direction = math.rad(90)
        self.rotation = math.rad(90)
    end

    self.damage = 20

    self.physics.speed = 5
    self.physics.friction = -0.2

    self.alpha = 0
    self:fadeToSpeed(1, 0.1)

    self.start_x = x
end

function TestBullet:getDrawColor()
    local r, g, b, a = super.getDrawColor(self)
    if self.battle_fade then
        return r, g, b, a * self.world.battle_alpha
    else
        return r, g, b, a
    end
end

function TestBullet:update()
    super.update(self)
end

return TestBullet