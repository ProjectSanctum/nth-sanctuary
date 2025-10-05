local TrailCubeBullet, super = Class(Bullet)

function TrailCubeBullet:init(x, y, dir, speed, trails)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/cube/cube")

    self.grazed = true
    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
	self.start_spd = speed
    self.physics.speed = -speed
	self.start_fric = 0.2
	self.trails = trails or 20
	self.x_last = {}
	self.y_last = {}
	self.trail_colliders = {}
	for i = 1, self.trails do
		table.insert(self.x_last, self.x)
		table.insert(self.y_last, self.y)
	end
	for i = 1, self.trails-2 do
		table.insert(self.x_last, self.x)
		table.insert(self.y_last, self.y)
        local hitbox = Hitbox(self, 10, 10, 15, 15)
		table.insert(self.trail_colliders, hitbox)
	end
    self:setScale(1)
    self.sprite:play(1/15, true)
	self.particle_dtmult = 0
	self.collider = ColliderGroup(self, self.trail_colliders)
	self.destroy_on_hit = false
	self.remove_offscreen = false
	self.con = 0
	self.play_sound = false
	self.sound_pitch = 0.9
end

function TrailCubeBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super.update(self)
	if self.con == 0 then
		self.physics.speed = self.physics.speed + Utils.sign(self.start_spd) * math.abs(self.start_fric) * DTMULT
		if Utils.sign(self.start_spd) == 1 and self.physics.speed >= self.start_spd then
			self.physics.speed = self.start_spd
			self.physics.friction = self.start_fric
			self.con = 1
			if self.play_sound then
				Assets.playSound("3dprism_cubetravel", 0.8, self.sound_pitch)
			end
		elseif Utils.sign(self.start_spd) == -1 and self.physics.speed <= self.start_spd then
			self.physics.speed = self.start_spd
			self.physics.friction = self.start_fric
			self.con = 1
			if self.play_sound then
				Assets.playSound("3dprism_cubetravel", 0.8, self.sound_pitch)
			end
		end
	end
	if self.particle_dtmult >= 1 and self.con == 1 then
		for i = self.trails, 2, -1 do
			self.x_last[i] = self.x_last[i - 1]
			self.y_last[i] = self.y_last[i - 1]
		end
		for i = self.trails-2, 2, -1 do
			if i >= self.trails-10 then
				local shrink = 0.5
				self.trail_colliders[i] = Hitbox(self, self.x_last[i]-self.x+12.5, self.y_last[i]-self.y+12.5, 10, 10)
			else
				self.trail_colliders[i] = Hitbox(self, self.x_last[i]-self.x+10, self.y_last[i]-self.y+10, 15, 15)
			end
		end
		self.x_last[1] = self.x
		self.y_last[1] = self.y
		self.trail_colliders[1] = Hitbox(self, 10, 10, 15, 15)
		self.particle_dtmult = 0
	end
	if self.x >= SCREEN_WIDTH+20*self.trails then
		self:remove()
	end
	if self.x <= -20*self.trails then
		self:remove()
	end
	self.particle_dtmult = self.particle_dtmult + DTMULT
end

function TrailCubeBullet:shouldSwoon(damage, target, soul)
    return true
end

function TrailCubeBullet:draw()
	local rr, rg, rb = Utils.hsvToRgb((Game.battle.encounter.rainbow_timer / 255) % 1, 233 / 255, 200 / 255)
    love.graphics.setBlendMode("add")
	for i = self.trails, 1, -1 do
		local ar, ag, ab = Utils.mergeColor(COLORS["white"], {rr, rg, rb}, i/self.trails)
		love.graphics.setColor(Utils.mergeColor(COLORS["black"], unpack({ar, ag, ab}), self.alpha))
		if self.con == 1 then
			love.graphics.draw(self.sprite.texture, self.x_last[i]-self.x, self.y_last[i]-self.y, 0, 1, 1, 0, 0)
		end
	end
	love.graphics.setBlendMode("alpha")
    super.draw(self)
end

return TrailCubeBullet