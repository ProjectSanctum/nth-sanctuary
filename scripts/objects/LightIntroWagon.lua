local LightIntroWagon, super = Class(Object)

function LightIntroWagon:init(x, y)
    super.init(self, x, y)
	
	self.heartx = 0
	self.hearty = 0
	self.wagon_parts = Assets.getFrames("world/objects/wheelbarrow_parts_dark")
end

function LightIntroWagon:update()
    super.update(self)
	
	if Input.pressed("left") and self.heartx > -4 then
		self.heartx = self.heartx - 1
	end
	if Input.pressed("right") and self.heartx < 4 then
		self.heartx = self.heartx + 1
	end
	if Input.pressed("down") and self.hearty < 4 then
		self.hearty = self.hearty + 1
	end
	if Input.pressed("up") and self.hearty > -4 then
		self.hearty = self.hearty - 1
	end
end

function LightIntroWagon:draw()
    super.draw(self)
	
	Draw.draw(self.wagon_parts[4], 10, 2, 0, 2, 2)
	Draw.draw(self.wagon_parts[3], 10 + (self.heartx * 2), 2 + (self.hearty * 2), 0, 2, 2)
	Draw.draw(self.wagon_parts[2], 10, 2, 0, 2, 2)
	Draw.draw(self.wagon_parts[1], 10, 2, 0, 2, 2)
end

return LightIntroWagon