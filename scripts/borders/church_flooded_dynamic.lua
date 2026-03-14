---@class Border.stars: Border
local ChurchFloodedBorder, super = Class(ImageBorder)

function ChurchFloodedBorder:init()
    super.init(self, "blank")
    self.normal_texture = Assets.getTexture("borders/church_flooded")
    self.hell_texture = Assets.getTexture("borders/church_flooded_hell")
	self.normal_border_alpha = Game:getFlag("floodedChurchBorderLastAlphaNormal", 0)
	self.hell_border_alpha = Game:getFlag("floodedChurchBorderLastAlphaHell", 0)
	self.border_dim_alpha = Game:getFlag("floodedChurchBorderLastDim", 1)
	self.id = "church_flooded_dynamic"
end

function ChurchFloodedBorder:draw()
    super.draw(self)
	if Game.world.map.border_dim_alpha then
		self.border_dim_alpha = MathUtils.lerp(self.border_dim_alpha, Game.world.map.border_dim_alpha, 0.125*DTMULT)
		Game:setFlag("floodedChurchBorderLastDim", self.border_dim_alpha)
	end
	local col = ColorUtils.mergeColor(COLORS.white, COLORS.black, MathUtils.clamp(self.border_dim_alpha, 0, 1))
	if Game.world.map.normal_border_alpha then
		self.normal_border_alpha = MathUtils.lerp(self.normal_border_alpha, Game.world.map.normal_border_alpha, 0.5*DTMULT)
		Game:setFlag("floodedChurchBorderLastAlphaNormal", self.normal_border_alpha)
	end
    Draw.setColor(col, self.normal_border_alpha * BORDER_ALPHA)
	Draw.draw(self.normal_texture, 0, 0, 0, BORDER_SCALE)
	if Game.world.map.hell_border_alpha then
		self.hell_border_alpha = MathUtils.lerp(self.hell_border_alpha, Game.world.map.hell_border_alpha, 0.5*DTMULT)
		Game:setFlag("floodedChurchBorderLastAlphaHell", self.hell_border_alpha)
	end
    Draw.setColor(col, self.hell_border_alpha * BORDER_ALPHA)
	Draw.draw(self.hell_texture, 0, 0, 0, BORDER_SCALE)
end

return ChurchFloodedBorder