---@class Map.dark_place : Map
local map, super = Class(Map, "hellentrance")

function map:init(world, data)
    super.init(self, world, data)
	if not Game:getFlag("shownfloodedmusic") then
		self.dtmult_timer = 0
		self.frame_timer = 0
		self.make_rip = false
		self.ripindex = 0
		self.con = 0
		self.fakefader = Rectangle(0,0,999,999)
		self.fakefader.alpha = 0
	end
end

function map:onEnter()
	if not Game:getFlag("shownfloodedmusic") then
		self.world.color = COLORS.black
		self.tiles = Game.world.map:getTileLayer("tiles")
		self.tiles2 = Game.world.map:getTileLayer("tiles2")
		self.tiles3 = Game.world.map:getTileLayer("tiles3")
		self.tiles4 = Game.world.map:getTileLayer("tiles4")
		self.tiles5 = Game.world.map:getTileLayer("tiles5")
		self.tiles.alpha = 0
		self.tiles2.alpha = 0
		self.tiles3.alpha = 0
		self.tiles4.alpha = 0
		self.tiles5.alpha = 0
		Game.world.timer:after(10/30, function()
			self.con = 1
		end)
		self.stupid_hitbox = self:getHitbox("rippleblock") ---@type Hitbox
		self.stupid_hitbox2 = self:getHitbox("rippleblock2") ---@type Hitbox
		self.stupid_hitbox3 = self:getHitbox("rippleblock3") ---@type Hitbox
		self.stupid_hitbox.collidable = true
		self.stupid_hitbox2.collidable = true
		self.stupid_hitbox3.collidable = true
		self.ripple_fx = RippleEffect()
		self.ripple_fx.layer = WORLD_LAYERS["bottom"]
		Game.world:addChild(self.ripple_fx)
		self.ripple_fx_alt = RippleEffect()
		self.ripple_fx_alt.layer = WORLD_LAYERS["above_events"]
		Game.world:addChild(self.ripple_fx_alt)
		self.timer:after(7.5, function()
			Game.world:spawnObject(musiclogo("flooded"), 9999)
		end)
		Game:setFlag("shownfloodedmusic", true)
	else
		self.stupid_hitbox = self:getHitbox("rippleblock") ---@type Hitbox
		self.stupid_hitbox2 = self:getHitbox("rippleblock2") ---@type Hitbox
		self.stupid_hitbox3 = self:getHitbox("rippleblock3") ---@type Hitbox
		self.stupid_hitbox.collidable = false
		self.stupid_hitbox2.collidable = false
		self.stupid_hitbox3.collidable = false
	end
end

function map:update(world, data)
	if Game:getFlag("shownfloodedmusic") then
		print(self.con)
		super.update(self)
		if self.con == 1 then
			self.dtmult_timer = self.dtmult_timer + DTMULT
			if self.dtmult_timer >= 1 then
				self.dtmult_timer = 0
				
				self.frame_timer = self.frame_timer + 1

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
				if self.frame_timer == 410 then
					Game.stage:addChild(self.fakefader)
					Game.world.timer:tween(0.85, self.fakefader, {alpha = 1})
				end
				if self.frame_timer == 445 then
					Game.world.color = COLORS.white
					self.fakefader:fadeOutAndRemove(0.5)
					self.tiles.alpha = 1
					self.tiles2.alpha = 1
					self.tiles3.alpha = 1
					self.tiles4.alpha = 1
					self.tiles5.alpha = 1
					self.con = 2
					self.stupid_hitbox.collidable = false
					self.stupid_hitbox2.collidable = false
					self.stupid_hitbox3.collidable = false
					Game:setFlag("ripplestop", true)
				end
			end
		end
	end
end

---@param char Player
function map:onFootstep(char, num)
    if not char.is_player then return end
	if Game:getFlag("ripplestop") then return end
	if self.frame_timer < 445 then
		Assets.playSound("step1", 1, 0.8)
	end
    ---@type RippleEffect
    local x, y = char:getRelativePos(18/2, 72/2)
    -- TODO: I couldn't find the right numbers
	local sizemod = 1
	if self.frame_timer < 445 then
		self.ripple_fx:makeRipple(x, y, 60, ColorUtils.hexToRGB("#4A91F6"), 220 * sizemod, 1, 18 * sizemod, 1999000, Game.world.player.moving_x * 1.05, Game.world.player.moving_y * 1.05)
		self.ripple_fx:makeRipple(x, y, 60, ColorUtils.hexToRGB("#4A91F6"), 140 * sizemod, 1, 15 * sizemod, 1999000, Game.world.player.moving_x * 1.05, Game.world.player.moving_y * 1.05)
	end
end

return map