---@class Border.stars: Border
local ChurchFloodedBorder, super = Class(ImageBorder)

function ChurchFloodedBorder:init()
    super.init(self, "blank")
    self.hell_texture_alt = Assets.getTexture("borders/church_flooded")
	self.hell_border_alpha_alt = Game:getFlag("floodedChurchBorderLastAlphaAlt", 0)
	self.id = "church_flooded_dynamic_alt"
end

function ChurchFloodedBorder:draw()
    super.draw(self)
	if Game.world.map.hell_border_alpha_alt then
		self.hell_border_alpha_alt = MathUtils.lerp(self.hell_border_alpha_alt, Game.world.map.hell_border_alpha_alt, 0.5*DTMULT)
		Game:setFlag("floodedChurchBorderLastAlphaAlt", self.hell_border_alpha_alt)
	end
    love.graphics.setColor(1, 1, 1, self.hell_border_alpha_alt * BORDER_ALPHA)
	Draw.draw(self.hell_texture_alt, 0, 0, 0, BORDER_SCALE)
end

return ChurchFloodedBorder