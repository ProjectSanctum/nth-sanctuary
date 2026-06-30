local VaporRipple, super = Class(Object)

function VaporRipple:init(x, y, color, size, points, fadeout, line_width, scale_factor,spin_factor)
    super.init(self, x, y)

    self.size = size or 50
    self.points = points or 4
    self.alpha = 1
    self.color = color or {1, 0, 0}
    self.fadeout = fadeout or 0.05
    self.line_width = line_width or 4
    self.scale_factor = scale_factor or 10
    self.spin_factor = spin_factor or 1
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
    self.rotation = self.rotation + math.rad(self.spin_factor) * DTMULT
    self.size = self.size + self.scale_factor * DTMULT
    if self.alpha < 0 then
        self.alpha = 0
        self:remove()
    end
end

return VaporRipple