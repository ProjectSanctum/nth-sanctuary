local HueDroplet, super = Class(Bullet, "fizzle/huedroplet")

function HueDroplet:init(x, y, speed, movement)
    super.init(self, x, y, "bullets/fizzle/fizzydroplet")

    self:setScale(1)
    self:setOriginExact(16, 18)
	self.siner = 0
    self.tp = (1/3) / 2.5
	self.sprite.visible = false
	self:setColor(COLORS.yellow)
	self:setHitbox(10, 14, 14, 4)
	self.outline_tex = Assets.getTexture("bullets/fizzle/fizzydroplet_outline")
	self.removing = false
	self.was_in_arena = false
	self.remove_outside_arena = false
	self.speed = speed
	self.movement = 1
end

function HueDroplet:update()
    super.update(self)
	self.siner = self.siner + self.speed * DTMULT

	if self.movement == 1 then
		if self.rotation == math.rad(0) then
			self.y = self.y + math.sin((self.siner*(math.pi/2))/12)*(self.speed * 2)
		elseif self.rotation == math.rad(90) then
			self.x = self.x + math.sin((self.siner*(math.pi/2))/12)*(self.speed * 2)
		elseif self.rotation == math.rad(180) then
			self.y = self.y + math.sin((self.siner*(math.pi/2))/12)*(self.speed * 2)
		elseif self.rotation == math.rad(270) then
			self.x = self.x + math.sin((self.siner*(math.pi/2))/12)*(self.speed * 2)
		end
	elseif self.movement == 2 then
		if self.rotation == math.rad(0) then
			self.y = self.y - math.sin((self.siner*(math.pi/2))/12)*(self.speed * 2)
		elseif self.rotation == math.rad(90) then
			self.x = self.x - math.sin((self.siner*(math.pi/2))/12)*(self.speed * 2)
		elseif self.rotation == math.rad(180) then
			self.y = self.y - math.sin((self.siner*(math.pi/2))/12)*(self.speed * 2)
		elseif self.rotation == math.rad(270) then
			self.x = self.x - math.sin((self.siner*(math.pi/2))/12)*(self.speed * 2)
		end
	end

	if self.remove_outside_arena then
		local arena = Game.battle.arena
		if not self.was_in_arena then
			if self.x >= arena.left - 16 and self.x <= arena.right + 16 and self.y >= arena.top - 18 and self.y <= arena.bottom + 18 then
				self.was_in_arena = true
			end
		elseif (self.x < arena.left + 10) and self.rotation == math.pi then
			self:doRemove()
		elseif (self.x > arena.right - 10) and self.rotation == 0 then
			self:doRemove()
		elseif (self.y > arena.bottom - 10) and self.rotation == math.pi/2 then
			self:doRemove()
		elseif (self.y < arena.top + 10) and self.rotation == (math.pi + math.pi/2) then
			self:doRemove()
		end
	end
end

function HueDroplet:doRemove()
	if self.removing then return end
	self.removing = true
	self.physics.speed = 0
	self.collidable = false

	Game.battle.timer:lerpVar(self, "alpha", 1, 0, 5)
	Game.battle.timer:lerpVar(self, "scale_x", 1, 0, 5)
	Game.battle.timer:lerpVar(self, "scale_y", 1, 0, 5)
	Game.battle.timer:after((5/30) / self.speed, function() 
		self:remove()
	end)
end

function HueDroplet:onGraze(success)
	if success then
		Assets.stopAndPlaySound("graze") -- Stop graze sound spam
	end
end

return HueDroplet 