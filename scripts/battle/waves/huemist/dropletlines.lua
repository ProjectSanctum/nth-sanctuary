local DropletLines, super = Class(Wave)

function DropletLines:init()
    super.init(self)

    self.time = 270/30
	self.side = 0
	self.last_add_diff = -1
	self.add_diff_same_count = 0
end

function DropletLines:onStart()
    local attackers = #self:getAttackers()           --scr_monsterpop()
    local enemies = #Game.battle:getActiveEnemies()  --sameattack
    local arena = Game.battle.arena

	local function spawnBullets()
		local side = (self.side % 4) + 1
		local direction = math.rad(90 * (side - 1))
		local x, y = arena.x, arena.y
		local x_diff, y_diff = 0, 0
		local distance, diff = 60, 32
		local add_diff = TableUtils.pick({0, 1})
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
		if side == 1 then
			y_diff = diff
			x = arena.left - distance
		elseif side == 2 then
			x_diff = diff
			y = arena.top - distance
		elseif side == 3 then
			y_diff = -diff
			x = arena.right + distance
		elseif side == 4 then
			x_diff = -diff
			y = arena.bottom + distance
		end
		for i = -2, 2 - add_diff do
			turnvar = -math.rad(-(i + (add_diff == 1 and 0.5 or 0)) * 2)
			local bullet = self:spawnBullet("huemist/spiral", x + x_diff * i + (add_diff == 1 and x_diff / 2 or 0), y + y_diff * i + (add_diff == 1 and y_diff / 2 or 0), direction, 4, 80, turnvar)
			bullet.dont_remove_on_lifetime_end = true
			bullet.remove_outside_arena = true
		end
		self.side = self.side + 1
	end

	self.timer:everyInstant(2.5, function()
		spawnBullets()
		self.timer:after(1, spawnBullets)
	end)
end

function DropletLines:update()
	super.update(self)
    --[[local attackers = #self:getAttackers()           --scr_monsterpop()
    local enemies = #Game.battle:getActiveEnemies()  --sameattack
    if enemies == attackers then
		for _, bullet in ipairs(self.bullets) do
			if bullet:isBullet("huemist/huedroplet") and not bullet:isRemoved() then
				bullet.x = bullet.x + ((math.sin((Kristal.getTime()*30) * 0.1) * 1.5) / enemies)
			end
		end
    end]]
end

function DropletLines:draw()
	super.draw(self)
	for _, bullet in ipairs(self.bullets) do
		if bullet:isBullet("huemist/huedroplet") and not bullet:isRemoved() then
			Draw.setColor(bullet:getDrawColor())
			Draw.draw(bullet.outline_tex, bullet.x, bullet.y, bullet.rotation, bullet.scale_x, bullet.scale_y, 16, 16)
		end
	end
	for _, bullet in ipairs(self.bullets) do
		if bullet:isBullet("huemist/huedroplet") and not bullet:isRemoved() then
			for i = 3, 1, -1 do
				Draw.setColor(ColorUtils.mergeColor(COLORS.yellow, COLORS.fuchsia, (i-1)/2), bullet.alpha * (0.5 - ((i-1)/2)*0.25))
				Draw.draw(bullet.sprite.texture, bullet.x + ((bullet.last_x - bullet.x) * FRAMERATE/30) * i, bullet.y + ((bullet.last_y - bullet.y) * FRAMERATE/30) * i, MathUtils.angle(bullet.x + ((bullet.last_x - bullet.x) * FRAMERATE/30) * i, bullet.y + ((bullet.last_y - bullet.y) * FRAMERATE/30) * i, bullet.x, bullet.y), bullet.scale_x, bullet.scale_y, 16, 16)
				Draw.setColor(bullet:getDrawColor())
			end
		end
	end
	for _, bullet in ipairs(self.bullets) do
		if bullet:isBullet("huemist/huedroplet") and not bullet:isRemoved() then
			Draw.setColor(bullet:getDrawColor())
			Draw.draw(bullet.sprite.texture, bullet.x, bullet.y, bullet.rotation, bullet.scale_x, bullet.scale_y, 16, 16)
		end
	end
end
return DropletLines