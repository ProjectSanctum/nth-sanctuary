local SmallBullet, super = Class(Bullet)

function SmallBullet:init(x, y)
    -- Last argument = sprite path
    super.init(self, x, y, "enemies/jellycruel/idle")
	self:setScale(0.6, 1)
	self:setScaleOrigin(0.5, 0)
    self.physics.speed_y = MathUtils.random(6, 8)
	self.physics.friction = MathUtils.random(0.2, 0.3)
	self.goal_spdy = MathUtils.random(0.6, 0.8)
	self.alpha = 0
	self.siner = MathUtils.random(0, math.pi*2)
	self.start_x = self.x
	self.removing = false
end

function SmallBullet:update()
    super.update(self)
	if self.physics.speed_y <= self.goal_spdy then
		self.physics.speed_y = MathUtils.random(6, 8)
		self.physics.friction = MathUtils.random(0.2, 0.3)
		self.goal_spdy = MathUtils.random(0.6, 0.8)
		self.scale_y = 1
	end
    self.siner = self.siner + (1 / 6) * DTMULT
    self.x = self.start_x + (math.sin(self.siner * 0.5)) * 1
	self.scale_y = MathUtils.lerp(self.scale_y, 0.6, 0.2 * DTMULT)
	if self.alpha < 1 and not self.removing then
		self.alpha = self.alpha + 0.1 * DTMULT
	end
	if self.y >= Game.battle.arena.bottom + 80 and not self.removing then
		self.removing = true
		self.collider.collidable = false
		self:fadeOutSpeedAndRemove(0.1)
	end
end

return SmallBullet