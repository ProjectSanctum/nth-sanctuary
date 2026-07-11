local Spiral, super = Class(Bullet, "fizzle/spiral")

function Spiral:init(x, y, dir, speed, lifetime, turnvar, enemyspeed, movement)
    super.init(self, x, y, "bullets/fizzle/spiral")

    self:setScale(0)

    self.timer = 0
    self.turnvar = turnvar or 0
    self.angled = false
    self.made = false
	self.bullet_direction = dir
	self.bullet_speed = speed
	self.bullet_lifetime = lifetime or 48
	self.bullet_movement = movement or 1
	self.dont_remove_on_lifetime_end = false
	self.remove_outside_arena = false
	self.enemy_speed = enemyspeed
end

function Spiral:update()
    super.update(self)
	

    if not self.made then	
        Game.battle.timer:lerpVar(self, "scale_x", 0, 1, 5)
        Game.battle.timer:lerpVar(self, "scale_y", 0, 1, 5)
        self.made = true
    end

    local remaining_time = Game.battle.wave_length - Game.battle.wave_timer
    if remaining_time <= (2/30) then
        self:remove()
    end

    self.rotation = self.rotation + -math.rad(10) * DTMULT
    self.timer = self.timer + DTMULT

	if self.timer == 5 then
		local bullet = self.wave:spawnBullet("fizzle/huedroplet", self.x, self.y, self.enemy_speed)
		if bullet then
			bullet.physics.direction = self.bullet_direction
			bullet.rotation = bullet.physics.direction
			bullet.alpha = 0
			bullet.scale_x = 0
			bullet.scale_y = 0
			bullet.movement = self.bullet_movement
			bullet.physics.speed = self.bullet_speed * self.enemy_speed
			bullet.remove_outside_arena = self.remove_outside_arena
		end

		local lifetime = self.bullet_lifetime / self.enemy_speed
		Game.battle.timer:lerpVar(bullet, "alpha", 0, 1, 8)
		Game.battle.timer:lerpVar(bullet, "scale_x", 0, 0.75, 14)
		Game.battle.timer:lerpVar(bullet, "scale_y", 0, 0.75, 14)

		if not self.dont_remove_on_lifetime_end then
			Game.battle.timer:after(lifetime/30, function()
				bullet.physics.speed = 0
				bullet.collidable = false

				Game.battle.timer:lerpVar(bullet, "alpha", 1, 0, 5)
				Game.battle.timer:lerpVar(bullet, "scale_x", 1, 0, 5)
				Game.battle.timer:lerpVar(bullet, "scale_y", 1, 0, 5)
			end)
			Game.battle.timer:after((lifetime+5)/30, function() 
				self:remove()
			end)
		end
		if self.turnvar ~= 0 then
			Game.battle.timer:lerpVar(bullet.physics, "direction", bullet.physics.direction, bullet.physics.direction - (self.turnvar * 1.75), lifetime * 0.85)
		end
	end
	if self.timer == 7 then
		Game.battle.timer:lerpVar(self, "scale_x", 1, 0, 18)
		Game.battle.timer:lerpVar(self, "scale_y", 1, 0, 18)
	end
	if self.timer == 30 then
		self:remove()
	end
end

return Spiral