local VaporSun, super = Class(Object)

function VaporSun:init(x, y)
    self.spr = Assets.getTexture("world/objects/vapor_sun")
    super.init(self, x, y, self.spr:getWidth(), self.spr:getHeight())

    self:setScale(2)
    self:setOrigin(0.5, 0.5)
    self.layer = WORLD_LAYERS["bottom"]

    self:addFX(ShaderFX("wave_interlace", {
				["wave_sine"] = function () return Kristal.getTime() * 50 end,
				["wave_mag"] = function () return 10 end,
				["wave_height"] = 25,
				["texsize"] = { SCREEN_WIDTH, SCREEN_HEIGHT }
			}), "funky_mode")
end

function VaporSun:draw()
    super.draw(self)

    Draw.draw(self.spr)
end

return VaporSun