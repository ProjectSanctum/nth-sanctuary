local Part, super = Class(Object)

function Part:init(x, y, distance)
    super.init(self, x, y)
	
	self.distance = distance or 10
	
    self.sprite = Sprite("enemies/creature_a/eye", -distance, 0)
	self.sprite:setOrigin(0.5, 0.5)

	self.rotating = true
	
	self.target = nil
	
	self:addChild(self.sprite)
end

function Part:update()
    super.update(self)
	
	if self.rotating then
		self.sprite.rotation = self.sprite.rotation + (DTMULT/40)
	end
	
	if self.target then
		local sx, sy = self:localToScreenPos(self.x, self.y)
		local angle = MathUtils.angle(sx,sy, self.target.x,self.target.y)
		self.sprite.x = math.cos(angle) * self.distance
		self.sprite.y = math.sin(angle) * self.distance
	end
end

return Part