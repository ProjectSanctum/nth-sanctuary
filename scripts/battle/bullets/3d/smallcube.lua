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
	self.destroy_on_hit = false
	self.x_last = {}
	self.y_last = {}
	for i = 1, 5 do
		table.insert(self.x_last, self.x)
		table.insert(self.y_last, self.y)
	end
	self.particle_dtmult = 0
	self.draw_trails = false
end

function CubeBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super.update(self)
	if self.particle_dtmult >= 1 and self.draw_trails then
		for i = 5, 2, -1 do
			self.x_last[i] = self.x_last[i - 1]
			self.y_last[i] = self.y_last[i - 1]
		end
		self.x_last[1] = self.x
		self.y_last[1] = self.y
		self.particle_dtmult = 0
	end
	self.particle_dtmult = self.particle_dtmult + DTMULT
end

function CubeBullet:shouldSwoon(damage, target, soul)
    return Game.battle.encounter.raged
end

function CubeBullet:draw()
	local rr, rg, rb = ColorUtils.HSVToRGB((Game.battle.encounter.rainbow_timer / 255) % 1, 233 / 255, 200 / 255)
    love.graphics.setBlendMode("add")
	for i = 5, 1, -1 do
		love.graphics.setColor(ColorUtils.mergeColor(COLORS["black"], {rr, rg, rb}, ((5-i)/5)*self.alpha*0.5))
		if self.draw_trails then
			love.graphics.draw(self.sprite.texture, self.x_last[i]-self.x, self.y_last[i]-self.y, 0, 1, 1, 0, 0)
		end
	end
	love.graphics.setBlendMode("alpha")
    super.draw(self)
end

return CubeBullet