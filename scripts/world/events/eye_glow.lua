local EyeGlow, super = Class(Event, "eye_glow")

function EyeGlow:init(data)
    super.init(self, data)
	self.siner = 0
	self.glows = 3
	self.scalex = 1
	self.scaley = 1
	self:setSprite("world/events/window_glow/church_eye")
	self.sprite:setScale(1,1)
	self:setOrigin(0.25, 0.5)
end

function EyeGlow:update()
	super.update(self)	
	self.siner = self.siner + DTMULT
end

function EyeGlow:draw()
    super.draw(self)
	love.graphics.setBlendMode("add")
	local xoff = -math.cos(math.rad(self.siner)) * 1
	local yoff = -math.sin(math.rad(self.siner)) * 1
	local dist = 2 * self.scalex
	local scale = 0.05 * self.scalex
	for i = 0, self.glows do
		Draw.setColor(1,1,1,((0.4 + math.sin(self.siner / 10) * 0.4) - (0.1 * i)) * self.alpha)
		Draw.draw(self.sprite.texture, (xoff * i * dist), yoff + (i * dist), 0, self.scalex + (scale * i), self.scaley + (scale * i))
	end
	love.graphics.setBlendMode("alpha")
	Draw.setColor(1,1,1,1)
end

return EyeGlow