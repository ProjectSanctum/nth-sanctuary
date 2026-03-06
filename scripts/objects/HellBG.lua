local HellBG, super = Class(Object)

function HellBG:init()
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

    self:setScale(1)
    self:setParallax(0.5, 0.5)
    self.layer = WORLD_LAYERS["bottom"]

    self.spr = Assets.getTexture("world/parallax/hell_1")
    self:addFX(ShaderFX("wave_interlace", {
				["wave_sine"] = function () return Kristal.getTime() * 50 end,
				["wave_mag"] = function () return 20 end,
				["wave_height"] = 10,
				["texsize"] = { SCREEN_WIDTH, SCREEN_HEIGHT }
			}), "funky_mode")
    self.bg_speed = 0
    self.bg_speed_max = 1
	self.debug_select = false
end

function HellBG:draw()
    super.draw(self)

    self.bg_speed = self.bg_speed + self.bg_speed_max * DTMULT
    if self.bg_speed_max < 0 and self.bg_speed > 240 then
        self.bg_speed = self.bg_speed - 240
    end

    local xx, yy = 0, 0
    xx = xx + self.bg_speed
    yy = yy + self.bg_speed

    local xx2, yy2 = 0, 0
    xx2 = xx2 + (self.bg_speed / 3)
    yy2 = yy2 + (self.bg_speed / 3)

    Draw.setColor(0.5, 0.5, 0.5, 1)
    Draw.drawWrapped(self.spr, true, true, math.floor(xx), math.floor(yy), 0, 2, 2, 120, 120)
end

return HellBG