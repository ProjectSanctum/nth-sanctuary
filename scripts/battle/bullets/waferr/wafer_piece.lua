local WaferPieceBullet, super = Class(Bullet)

function WaferPieceBullet:init(x, y, dir, target_soul_directly)
    super.init(self, x, y, "bullets/waferr/wafer_piece")
    self.rotation = dir
	self.physics.match_rotation = true
	self.physics.speed = 4
	self.physics.friction = 0.5
	self.target_soul_directly = target_soul_directly or false
	self.con = 0
	self.timer = 0
	self.random_dir = MathUtils.randomInt(-30, 30)
	self:setHitbox(7, 6, 4, 3)
end

function WaferPieceBullet:update()
    super.update(self)
	self.timer = self.timer + DTMULT
	if self.con == 0 then
		if self.timer >= 15 and self.physics.speed <= 0 then
			self.con = 1
			self.timer = 0
		end
	elseif self.con == 1 then
		self.rotation = MathUtils.angleLerp(self.rotation, self.target_soul_directly and (MathUtils.angle(self.x, self.y, Game.battle.soul.x, Game.battle.soul.y) - math.rad(180)) or (MathUtils.angle(self.x, self.y, Game.battle.arena.x, Game.battle.arena.y) + math.rad(self.random_dir - 180)), 0.2*DTMULT)
		if self.timer >= 15 then
			Assets.stopAndPlaySound("spearrise", 0.5, 2)
			self.physics.match_rotation = false
			self.physics.direction = self.rotation + math.rad(180)
			self.physics.speed = 1
			if #Game.battle.enemies <= 1 then
				self.physics.friction = -0.65
			else
				self.physics.friction = -0.5
			end
			self.timer = 0
			self.con = 2
		end
	elseif self.con == 2 then
		if self.timer >= 15 and MathUtils.dist(self.x, self.y, Game.battle.arena.x, Game.battle.arena.y) >= 160 then
			self.con = 3
			self.collidable = false
			self:fadeOutSpeedAndRemove(0.2)
		end
	end
end

return WaferPieceBullet