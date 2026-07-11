local DropletLines, super = Class(Wave)

function DropletLines:init()
    super.init(self)
	self.siner = 0
    self.time = 270/30
	self.side = 0
	self.count = 0
	self.last_add_diff = -1
	self.add_diff_same_count = 0
	self.trail_tex = Assets.getTexture("battle/bullets/mizzle/holydroplet")
	self.ratio = 1
	if #Game.battle.enemies == 2 then
		self.ratio = 1.6
	elseif #Game.battle.enemies == 3 then
		self.ratio = 2.3
	end
end


function DropletLines:onStart()
    local attackers = self:getAttackers()           --scr_monsterpop()
    local enemies = #Game.battle:getActiveEnemies()  --sameattack
    local arena = Game.battle.arena
	local speed = attackers[1].attack_speed
	Game.battle.soul.speed = Game.battle.encounter.next_soul_speed

	local function spawnBullets()
		local amountcontroller = 1
		local side = (self.side % 4) + 1
		local direction = math.rad(90 * (side - 1))
		local x, y = arena.x, arena.y
		local x_diff, y_diff = 0, 0
		local distance, diff = 60, 32
		local add_diff = TableUtils.pick({0, 1})
		amountcontroller = 3 - enemies
		--[[if speed <= 0.5 and enemies > 1 then
			amountcontroller = amountcontroller + 1
		end]]
		if speed >= 1.5 and enemies <= 1 then
			amountcontroller = amountcontroller - 1
		end
		if add_diff == self.last_add_diff then
			self.add_diff_same_count = self.add_diff_same_count + 1
			if self.add_diff_same_count >= 3 then
				if add_diff == 0 then
					add_diff = 1
				else
					add_diff = 0
				end
				self.add_diff_same_count = 0
			end
		end
		self.last_add_diff = add_diff
		local turnvar = 0
		local lifetime = 50
		if side == 1 then
			if Game.battle.soul.x <= arena.left + 32 then
				distance = 90
				lifetime = 75
			end
			y_diff = diff
			x = arena.left - distance
		elseif side == 2 then
			if Game.battle.soul.y <= arena.top + 32 then
				distance = 90
				lifetime = 75
			end
			x_diff = diff
			y = arena.top - distance
		elseif side == 3 then
			if Game.battle.soul.x >= arena.right - 32 then
				distance = 90
				lifetime = 75
			end
			y_diff = diff
			x = arena.right + distance
		elseif side == 4 then
			if Game.battle.soul.y >= arena.bottom - 32 then
				distance = 90
				lifetime = 75
			end
			x_diff = diff
			y = arena.bottom + distance
		end
		local movement = (self.count % 2) + 1
		if enemies <= 1 then
			movement = MathUtils.randomInt(1, 3)		
		end
		if movement == 2 then
			for i = -1, amountcontroller do
				turnvar = 0
				local bullet = self:spawnBullet("fizzle/spiral", x + (x_diff * i), y + (y_diff * i), direction, 4, lifetime, turnvar, speed, movement)
				bullet.dont_remove_on_lifetime_end = true
				bullet.remove_outside_arena = true
			end
		else
			for i = -amountcontroller, 1 do
				turnvar = 0
				local bullet = self:spawnBullet("fizzle/spiral", x + (x_diff * i), y + (y_diff * i), direction, 4, 50, turnvar, speed, movement)
				bullet.dont_remove_on_lifetime_end = true
				bullet.remove_outside_arena = true
			end
		end
		if enemies > 1 then
			self.side = self.side + 1
		else
			self.side = MathUtils.randomInt(0, 4)
		end
		self.count = self.count + 1
	end
	for i, attacker in ipairs(attackers) do
		self.timer:after((0.5 / ((speed / 2) + 0.5)) * (i - 1), function()	
			self.timer:everyInstant((1.25 / speed) * self.ratio, function()	
				spawnBullets()
			end)
		end)
	end
end

function DropletLines:update()
	super.update(self)
	self.siner = self.siner + DTMULT
    local attackers = #self:getAttackers()           --scr_monsterpop()
    local enemies = #Game.battle:getActiveEnemies()  --sameattack
end

function DropletLines:draw()
	super.draw(self)
	for _, bullet in ipairs(self.bullets) do
		if bullet:isBullet("fizzle/huedroplet") and not bullet:isRemoved() then
			Draw.setColor(bullet:getDrawColor())
			Draw.draw(bullet.outline_tex, bullet.x, bullet.y, bullet.rotation, bullet.scale_x, bullet.scale_y, 16, 16)
		end
	end
	for _, bullet in ipairs(self.bullets) do
		if bullet:isBullet("fizzle/huedroplet") and not bullet:isRemoved() then
			for i = 3, 1, -1 do
				Draw.setColor(ColorUtils.mergeColor(COLORS.yellow, COLORS.fuchsia, (i-1)/2), bullet.alpha * (0.5 - ((i-1)/2)*0.25))
				Draw.draw(self.trail_tex, bullet.x + ((bullet.last_x - bullet.x) * FRAMERATE/30) * i, bullet.y + ((bullet.last_y - bullet.y) * FRAMERATE/30) * i, MathUtils.angle(bullet.x + ((bullet.last_x - bullet.x) * FRAMERATE/30) * i, bullet.y + ((bullet.last_y - bullet.y) * FRAMERATE/30) * i, bullet.x, bullet.y), bullet.scale_x, bullet.scale_y, 16, 16)
				Draw.setColor(bullet:getDrawColor())
			end
		end
	end
	for _, bullet in ipairs(self.bullets) do
		if bullet:isBullet("fizzle/huedroplet") and not bullet:isRemoved() then
			Draw.setColor(bullet:getDrawColor())
			Draw.draw(bullet.sprite.texture, bullet.x, bullet.y, bullet.rotation, bullet.scale_x, bullet.scale_y, 16, 16)
		end
	end
end
return DropletLines