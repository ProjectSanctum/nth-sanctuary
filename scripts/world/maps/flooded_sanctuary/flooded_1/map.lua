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
    self.lava_alpha = 0.5 + (math.sin((Kristal.getTime() * 30) / 12) * 0.3)
    self.lava_grad_scale = (math.sin((Kristal.getTime() * 30) / 12) * 0.5)
    self.hell_border_alpha = 0
    self.font = nil
    self.debug = false

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
        Kristal.hideBorder()
    end

    self.fade_top_tiles = 6
    self.fade_bottom_tiles = 8
end

function map:update(world, data)
    if Game:getFlag("shownfloodedmusic") then
        super.update(self)
        local kris = Game.world.player
        if kris then
            local room_center = (self.height * self.tile_height) / 2
            local dist = kris.y - room_center
            local top_px = self.fade_top_tiles * -40
            local bottom_px = self.fade_bottom_tiles * 40
            self.hell_border_alpha = MathUtils.clamp(
                1 - (dist - bottom_px) / (top_px - bottom_px),
                0, 1
            )
        end
        self.lava_alpha = (math.sin((Kristal.getTime() * 30) / 12) * 0.2)
        self.lava_grad_scale = (math.sin((Kristal.getTime() * 30) / 12) * 0.5)
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
                    Kristal.showBorder()
                    Game.world.color = COLORS.white
                    self.fakefader:fadeOutAndRemove(0.5)
                    self.tiles.alpha = 1
                    self.tiles2.alpha = 1
                    self.tiles3.alpha = 1
                    self.tiles4.alpha = 1
                    self.tiles5.alpha = 1
                    self.con = 2
                    Game:setFlag("ripplestop", true)
                end
            end
        end
    end
end

---@param char Player
function map:onFootstep(char, num)
    if not char.is_player or num ~= 1 then return end
    local x, y = char:getRelativePos(18/2, 72/2)
	local sizemod = 1
    local running = (Input.down("cancel") or self.force_run) and not self.force_walk
    if Kristal.Config["autoRun"] and not self.force_run and not self.force_walk then
        running = not running
    end

	if self.frame_timer < 445 then
		local px = Game.world.player.moving_x * Game.world.player:getCurrentSpeed(running)
		local py = Game.world.player.moving_y * Game.world.player:getCurrentSpeed(running)
		self.ripple_fx:makeRipple(x, y, 60, ColorUtils.hexToRGB("#4A91F6"), 220 * sizemod, 1, 18 * sizemod, 1999000, px * 1.05, py * 1.05)
		self.ripple_fx:makeRipple(x, y, 60, ColorUtils.hexToRGB("#4A91F6"), 140 * sizemod, 1, 15 * sizemod, 1999000, px * 1.05, py * 1.05)
	end
end

function map:draw()
    super.draw(self)
    local alpha = Game:getFlag("floodedChurchBorderLastAlpha", 0)
    if Game.world.player then
        local px = Game.world.player.x - 22
        local py = Game.world.player.y - 100
        if not self.font then
            local ok, f = pcall(Assets.getFont, "8bitoperator_jve", 32)
            if ok and f then
                self.font = f
            else
                local ok2, f2 = pcall(Assets.getFont, "sans", 20)
                if ok2 and f2 then
                    self.font = f2
                end
            end
        end
        if self.font and self.debug then
            local prev_font = love.graphics.getFont()
            love.graphics.setFont(self.font)
            local text = string.format("%.2f", alpha)
            love.graphics.setColor(0, 1, 0, 1)
            love.graphics.print(text, px, py)
            love.graphics.setFont(prev_font)
        end
    end
end

return map
