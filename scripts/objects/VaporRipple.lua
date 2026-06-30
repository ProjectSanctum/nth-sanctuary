local VaporRipple, super = Class(Object)

function VaporRipple:init(x, y, color, size, points, fadeout, line_width, scale_factor,spin_factor)
    super.init(self, x, y)

    self.size = size or 50
    self.points = points or 4
    self.alpha = 1
    self.color = color or {1, 0, 0}
    self.fadeout = fadeout or 0.025
    self.line_width = line_width or 20
    self.scale_factor = scale_factor or 10
    self.spin_factor = spin_factor or 5
    self.rotation = love.math.random(360)
end

function VaporRipple:draw()
    super.draw(self)
    love.graphics.push()
    love.graphics.setLineWidth(self.line_width)
    love.graphics.circle('line', 0, 0, self.size, self.points)
    love.graphics.pop()
end

function VaporRipple:update()
    super.update(self)
    self.alpha = self.alpha - self.fadeout * DTMULT
    self.rotation = self.rotation + math.rad(self.spin_factor) * DTMULT * self.alpha
    self.size = self.size * (1 + self.scale_factor * 0.01 * DTMULT * self.alpha)
    self.line_width = self.line_width + (1 - self.line_width) * 0.1 * DTMULT * (1 - self.alpha)
    if self.alpha < 0 then
        self.alpha = 0
        self:remove()
    end
end

return VaporRipple