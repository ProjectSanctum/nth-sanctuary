local LightRainEffect, super = Class(Object)

function LightRainEffect:init()
    super.init(self, 0, 0)
	self:setParallax(0)
	self.rain_style = 1
	self.xdir = -1
	self.xspeed = 2
	self.yspeed = 4
	local plotmode = Game:getFlag("hometown_raining", 0) == 1 and true or false
	self.genspeed = 2
	self.speed_mul = 5
	self.build_timer = 0
	self.prewarm = Game:getFlag("hometown_raining", 0) >= 2 and true or false
	self.crossfade = Game:getFlag("hometown_raining", 0) == 3 and true or false
	self.rain_active = plotmode or self.prewarm
	self.timer = -1
	self.color_overlay = true
	self.speed_sin = 0
	self:setLayer(-10000)
	self.rainsplash = self.prewarm
	self.stepped = 0
	self.init = false
	self.drop_wait = 30
	self.drop_wait = Game:getFlag("hometown_rain_drop_wait", 30)
	self.drop_timer = 0
	if self.rain_active then
		Game:setFlag("hometown_raining", 2)
	end
	self.wrap_up = false
	self.room_exit = false
	self.room_door = false
	self.max_particles = Game:getFlag("hometown_rain_max_particles", 120)
	self.cam_x = 0
	self.cam_y = 0
	self.ypan = false
	self.xpan = false
	self.dropcount = 0
	self.inherit_visibility = true
	self.faded_in_starting_rainsfx = false
	self.rain_outdoors_sfx = nil
	self.rain_outdoors_sfx = nil
end

function LightRainEffect:toggleEffect(visible)
    if visible then
		self.visible = visible
	else
		self.visible = not self.visible
	end
	self.inherit_visibility = true
	for _, drop in ipairs(Game.stage:getObjects(LightRainDrop)) do
		drop.visible = self.visible
	end
end

function LightRainEffect:onRemove(parent)
    super.onRemove(self, parent)
	if self.rain_outdoors_sfx then
		self.rain_outdoors_sfx:stop()
		self.rain_outdoors_sfx:remove()
		self.rain_outdoors_sfx = nil
	end
    if self.rain_indoors_sfx then
        self.rain_indoors_sfx:stop()
        self.rain_indoors_sfx:remove()
        self.rain_indoors_sfx = nil
    end
	if self.rain_active and not Game:getFlag("hometown_rain_door_transition", false) then
		Game:setFlag("hometown_raining", 3)
	end
end

function LightRainEffect:update()
    super.update(self)
	if not self.rain_active then return end

	if not self.init then
		if not self.rain_indoors_sfx and not self.rain_outdoors_sfx then
			self.rain_outdoors_sfx = Music()
			self.rain_indoors_sfx = Music()
			self.rain_outdoors_sfx:play("raining", 0, 1)
			self.rain_indoors_sfx:play("raining_in_church2", 0, 1)
		end
		if Game:getFlag("hometown_rain_indoors", false) then
			self.rain_indoors_sfx:setVolume(0.75)
		else
			self.rain_outdoors_sfx:setVolume(0.5)		
		end
		if self.prewarm then
			if not self.crossfade then
				self.rain_outdoors_sfx:fade(0.5, 14/30)
			end
			self.build_timer = 120
		else
			self.rain_outdoors_sfx:setVolume(0)
			self.build_timer = 0
		end
	end
	if Game.world.map and Game:getFlag("hometown_rain_indoors", false) ~= Game.world.map.data.properties["inside"] then
		if self.rain_indoors_sfx and self.rain_outdoors_sfx then
			if Game.world.map.data.properties["inside"] then
				self.rain_outdoors_sfx:fade(0, 28/30)
				self.rain_indoors_sfx:fade(0.75, 28/30)
			else
				self.rain_outdoors_sfx:fade(0.5, 28/30)
				self.rain_indoors_sfx:fade(0, 28/30)
			end
		end
		Game:setFlag("hometown_rain_indoors", Game.world.map.data.properties["inside"])
	end
	local gen = self.genspeed
	if self.build_timer < 120 and not self.wrap_up then
		self.build_timer = self.build_timer + DTMULT
		gen = math.floor(MathUtils.lerp(self.genspeed - 20, self.genspeed, self.build_timer / 120))
		
		if self.build_timer >= 100 then
			self.rainsplash = true
		end
		
		if self.build_timer < 120 then
			self.drop_timer = self.drop_timer + DTMULT
			if self.drop_timer >= self.drop_wait then
				self.drop_timer = 0
				self.drop_wait = math.max(self.drop_wait * 0.75, 2)
			end
		end
		
		if self.build_timer >= 10 and not self.faded_in_starting_rainsfx then
			self.rain_outdoors_sfx:fade(0.5, 110/30)
			self.faded_in_starting_rainsfx = true
		end
	end
	if self.wrap_up then
		if self.build_timer > 0 then
			self.build_timer = self.build_timer - DTMULT
		end
		if self.build_timer < 100 then return end
		if self.build_timer <= 0 then
			self:remove()
		end
	end
	self.dropcount = #Game.stage:getObjects(LightRainDrop)
	if self.rain_style < 4 then
		if self.timer >= 0 and self.dropcount < self.max_particles then
			if self.prewarm then
				self.cam_x = Game.world.camera.x - SCREEN_WIDTH / 2
			end
			
			local xbuffer = self.xspeed * SCREEN_HEIGHT
			local xrange = SCREEN_WIDTH + (self.xspeed * SCREEN_HEIGHT)
			local offx = SCREEN_WIDTH
			if not self.prewarm and self.cam_y ~= Game.world.camera.y - SCREEN_HEIGHT / 2 and not self.ypan then
				local ydiff = math.abs(self.cam_y - (Game.world.camera.y - SCREEN_HEIGHT / 2))
				
				if self.dropcount < self.genspeed * 25 then
					gen = gen + ydiff
				elseif self.dropcount > self.genspeed * 30 then
					gen = gen - ydiff
				end
			end
			local spawncount = math.max(gen, 1)
			if self.prewarm then
				spawncount = spawncount * 25
			end
			if self.xdir > 0 then
				offx = 0
			end
			local speed = self.speed_mul
			self.speed_sin = self.speed_sin + DTMULT
			for i = 0, spawncount do
				local raindrop
				local cx, cy = Game.world.camera.x - SCREEN_WIDTH / 2, Game.world.camera.y - SCREEN_HEIGHT / 2
				if self.prewarm then
					raindrop = LightRainDrop(cx + MathUtils.randomInt(720) + (64 * self.xdir), cy - 76 + MathUtils.randomInt(556))
					if self.inherit_visibility then
						raindrop.visible = self.visible
					end
				else
					local side_random = MathUtils.randomInt(720) + (64 * self.xdir)
					local foff = MathUtils.randomInt(self.speed_mul * self.yspeed)
					raindrop = LightRainDrop((cx + side_random) - (foff * self.xspeed * self.xdir), cy - (foff * self.yspeed))
					if self.inherit_visibility then
						raindrop.visible = self.visible
					end
				end
				raindrop.rain_index = MathUtils.randomInt(1, 11)
				raindrop.physics.speed_x = self.xspeed * self.xdir * speed
				raindrop.physics.speed_y = self.yspeed * speed
				raindrop.layer = self.layer - 0.01
				raindrop.scale_x = raindrop.scale_x * self.xdir
				Game.world:addChild(raindrop)
			end
			self.dropcount = self.dropcount + spawncount
			if self.prewarm then
				self.prewarm = false
			end
			self.timer = gen
		else
			self.timer = self.timer + DTMULT
		end
	else
		self.timer = self.timer + DTMULT
		if self.timer >= (self.rain_tex:getHeight() * self.rain_tex:getWidth()) then
			self.timer = self.timer - (self.rain_tex:getHeight() * self.rain_tex:getWidth())
		end
	end
	self.cam_y = Game.world.camera.y - SCREEN_HEIGHT / 2
	self.init = true
end

function LightRainEffect:setGMBlendMode(blend_mode)
	if blend_mode == "bm_subtract" then
		Ch4Lib.setBlendState("add", "zero", "oneminussrccolor")
	elseif blend_mode == "bm_add" then
		Ch4Lib.setBlendState("add", "srcalpha", "one")
	elseif blend_mode == "bm_normal" then
		Ch4Lib.setBlendState("add", "srcalpha", "oneminussrcalpha")
	end
end

function LightRainEffect:draw()
    super.draw(self)
	if not self.rain_active or (Game.world.map and Game.world.map.data.properties["inside"]) then return end
	love.graphics.push()
	if self.color_overlay then
		local str = self.build_timer / 120
		if Ch4Lib.accurate_blending then
			self:setGMBlendMode("bm_subtract")
			Draw.setColor(ColorUtils.mergeColor(COLORS.black, COLORS.orange, 0.3 * str), 0)
			love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
			self:setGMBlendMode("bm_add")
			Draw.setColor(ColorUtils.mergeColor(COLORS.black, COLORS.white, 0.1 * str))
			love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
			self:setGMBlendMode("bm_normal")
		else
			love.graphics.setBlendMode("screen")
			Draw.setColor(ColorUtils.mergeColor(COLORS.black, COLORS.orange, 0.3 * str), 0)
			love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
			love.graphics.setBlendMode("add")
			Draw.setColor(ColorUtils.mergeColor(COLORS.black, COLORS.white, 0.1 * str))
			love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
			love.graphics.setBlendMode("alpha")
		end
	end
	love.graphics.pop()
	love.graphics.setBlendMode("alpha", "alphamultiply")
end

return LightRainEffect