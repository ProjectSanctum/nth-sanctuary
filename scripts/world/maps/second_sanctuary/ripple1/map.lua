---@class Map.dark_place : Map
local map, super = Class(Map, "secsanctuary/ripple1")

function map:init(world, data)
    super.init(self, world, data)
    self.dtmult_timer = 0
	self.frame_timer = 0
	self.make_rip = false
	self.ripindex = 0
	self.con = 0
	self.fakefader = Rectangle(0,0,999,999)
	self.fakefader.alpha = 0
end

function map:onEnter()
    self.world.color = COLORS.black
	self.tiles = Game.world.map:getTileLayer("tiles")
	self.tiles.alpha = 0
	for _, event in ipairs(self.events) do
		if event.layer == self.layers["objects_tile_oscillate"] then
			 event.visible = false
		end
		if event.layer == self.layers["objects_parallax"] then
			 event.parallax_x = 0.5
			 event.parallax_y = 0.9
			 event.visible = false
		end
		if event.layer == self.layers["objects_parallax2"] then
			 event.parallax_x = 0.4
			 event.parallax_y = 0.85
			 event.visible = false
		end
		if event.layer == self.layers["objects_parallax3"] then
			 event.parallax_x = 0.3
			 event.parallax_y = 0.82
			 event.visible = false
		end
	end
	Game.world.timer:after(10/30, function()
		self.con = 1
	end)
	for _, filter in ipairs(Game.world.map:getEvents("filter")) do
		filter.visible = false
	end
	for _, window in ipairs(Game.world.map:getEvents("window_glow")) do
		window.alpha = 0
		window.sprite.alpha = 0
	end
	self.stupid_hitbox = self:getHitbox("rippleblock") ---@type Hitbox
	self.stupid_hitbox.collidable = true
	self.ripple_fx = RippleEffect()
	self.ripple_fx.layer = WORLD_LAYERS["bottom"]
	Game.world:addChild(self.ripple_fx)
	self.ripple_fx_alt = RippleEffect()
	self.ripple_fx_alt.layer = WORLD_LAYERS["above_events"]
	Game.world:addChild(self.ripple_fx_alt)
end

function map:onExit()
    self.world.color = COLORS.white
end

function map:update()
	print(self.con)
	super.update(self)
	if self.con == 1 then
		self.dtmult_timer = self.dtmult_timer + DTMULT
		if self.dtmult_timer >= 1 then
			self.dtmult_timer = 0
			
			self.frame_timer = self.frame_timer + 1
			if self.frame_timer == 1 then
				Game.world.music:play("second_church", 0.7, 1)
			end
			if (self.frame_timer == (1 + MathUtils.round(0)) or self.frame_timer == (1 + MathUtils.round(95.25)) or self.frame_timer == (1 + MathUtils.round(190.5)) or self.frame_timer == (1 + MathUtils.round(285.75)) or self.frame_timer == (1 + MathUtils.round(381)) or self.frame_timer == (1 + MathUtils.round(476.25)) or self.frame_timer == (1 + MathUtils.round(571.5)) or self.frame_timer == (1 + MathUtils.round(666.75))) then
				self.make_rip = true
				local seqtime = 0.17647
				for i = 0, 8 do
					Game.world.timer:after(MathUtils.round(seqtime * 30 * i)/30, function()
						self.make_rip = true
					end)
				end
			end
			if self.frame_timer == 381 then
				for _, window in ipairs(Game.world.map:getEvents("window_glow")) do
					Game.world.timer:tween(300/30, window, {alpha = 1}, "linear")
				end
			end
			if self.make_rip then
				self.make_rip = false
				local cx,cy = Game.world.camera.x-SCREEN_WIDTH/2, Game.world.camera.y-SCREEN_HEIGHT/2
				local loc = {}
				local border = 80
				table.insert(loc, {x = cx + 0 + border, y = cy + 0 + border})
				table.insert(loc, {x = cx + SCREEN_WIDTH - border, y = cy + 0 + border})
				table.insert(loc, {x = cx + 0 + border, y = cy + SCREEN_HEIGHT - border})
				table.insert(loc, {x = cx + SCREEN_WIDTH - border, y = cy + SCREEN_HEIGHT - border})
				border = 120
				table.insert(loc, {x = cx + SCREEN_WIDTH/2, y = cy + SCREEN_HEIGHT/2 + border})
				table.insert(loc, {x = cx + SCREEN_WIDTH/2, y = cy + SCREEN_HEIGHT/2 - border})
				border = 160
				table.insert(loc, {x = cx + SCREEN_WIDTH/2 + border, y = cy + SCREEN_HEIGHT/2})
				table.insert(loc, {x = cx + SCREEN_WIDTH/2 - border, y = cy + SCREEN_HEIGHT/2})
				local masterdir = 0
				if Game.world.player then
					masterdir = MathUtils.angle(Game.world.player.x, Game.world.player.y, Game.world.player.x + Game.world.player.moving_x, Game.world.player.y + Game.world.player.moving_y)
				end
				local hhsp = -math.cos(masterdir) * 2
				local vvsp = -math.sin(masterdir) * 2
				self.ripple_fx_alt:makeRipple(loc[self.ripindex+1].x,loc[self.ripindex+1].y, 60, COLORS.white, 200, 1, 14, -5, hhsp, vvsp, 0.25)
				self.ripindex = self.ripindex + 1
				if self.ripindex > #loc-1 then
					self.ripindex = 0
				end
			end
			if self.frame_timer == 720 then
				Game.stage:addChild(self.fakefader)
				Game.world.timer:tween(1, self.fakefader, {alpha = 1})
			end
			if self.frame_timer == 780 then
				Game.world.color = COLORS.white
				self.fakefader:fadeOutAndRemove(0.5)
				self.tiles.alpha = 1
				self.con = 2
				for _, event in ipairs(self.events) do
					if event.layer == self.layers["objects_parallax"] then
						event.visible = true
					elseif event.layer == self.layers["objects_parallax2"] then
						event.visible = true
					elseif event.layer == self.layers["objects_parallax3"] then
						event.visible = true
					elseif event.layer == self.layers["objects_tile_oscillate"] then
						event.visible = true
					end
				end
				for _, filter in ipairs(Game.world.map:getEvents("filter")) do
					filter.visible = true
				end
				self.stupid_hitbox.collidable = false
			end
		end
	end
end

---@param char Player
function map:onFootstep(char, num)
    if not char.is_player then return end
    ---@type RippleEffect
    local x, y = char:getRelativePos(18/2, 72/2)
    -- TODO: I couldn't find the right numbers
	local sizemod = 1
	if self.frame_timer < 780 then
		self.ripple_fx:makeRipple(x, y, 60, ColorUtils.hexToRGB("#4A91F6"), 220 * sizemod, 1, 18 * sizemod, 1999000, Game.world.player.moving_x * 1.05, Game.world.player.moving_y * 1.05)
		self.ripple_fx:makeRipple(x, y, 60, ColorUtils.hexToRGB("#4A91F6"), 140 * sizemod, 1, 15 * sizemod, 1999000, Game.world.player.moving_x * 1.05, Game.world.player.moving_y * 1.05)
	end
end

return map