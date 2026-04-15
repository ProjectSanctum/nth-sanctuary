---@class CruelAxeHit : Sprite
---@overload fun(...) : CruelAxeHit
local CruelAxeHit, super = Class(Sprite)

function CruelAxeHit:init(sprite, x, y, tx, ty)
    super.init(self, "enemies/" .. sprite, x, y)

    self:setOrigin(0.5, 0.5)
    self:setScale(1)
    self:fadeOutSpeedAndRemove(0.025)
    print("hit")
    self.physics.direction = math.rad(-90 + love.math.random(-20, 20)) 
    self.physics.speed = 15
    self.physics.gravity = 1
    self.graphics.spin = love.math.random(-5, 5)/20
end

function CruelAxeHit:update()
    super.update(self)
end

return CruelAxeHit