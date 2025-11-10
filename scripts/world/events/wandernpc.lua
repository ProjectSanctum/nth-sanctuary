local WanderNPC, super = Class(NPC, "wandernpc")

function WanderNPC:init(data)
    properties = data.properties or {}
    super.init(self, properties.actor, data.x, data.y, properties)
	
	self.walk_mode = 0
	self.walk_timer = 0
	self.walk_threshold = 20
	self.walk_time = properties["walktime"] or 10
	self.walk_time_rand = properties["walkrandtime"] or 10
	self.walk_dir = "up"
	self.walk_speed = 0
	self.walk_true_spd = properties["walkspeed"] or 2
	self.enemy_collision = 2
    self.noclip = false
end

function WanderNPC:update()
    super.update(self)
	if Game.world.player and Game.world.player:isMovementEnabled() then
		self.walk_timer = self.walk_timer + DTMULT
		if self.walk_timer >= self.walk_threshold then
			if self.walk_mode == 0 then
				self.walk_mode = 1
				self.walk_dir = Utils.pick({"up", "left", "down", "right"})
				self.walk_speed = self.walk_true_spd
				self.walk_threshold = self.walk_time + MathUtils.randomInt(self.walk_time_rand)
			else			
				self.walk_mode = 0
				self.walk_speed = 0
				self.walk_threshold = 30 + MathUtils.randomInt(20)
			end
			self.walk_timer = 0
		end
		if self.walk_speed > 0 then
			if self.walk_dir == "up" then
				self:move(0, -1, self.walk_speed)
			end
			if self.walk_dir == "left" then
				self:move(-1, 0, self.walk_speed)
			end
			if self.walk_dir == "down" then
				self:move(0, 1, self.walk_speed)
			end
			if self.walk_dir == "right" then
				self:move(1, 0, self.walk_speed)
			end
		end
	end
end

return WanderNPC