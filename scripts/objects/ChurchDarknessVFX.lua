local ChurchDarknessVFX, super = Class(Object)

function ChurchDarknessVFX:init(x, y)
    super.init(self, x, y)
	
	self.siner = 0
	self.window_alpha = 0.2
	self.darkness_strength = 0
	self.bg_active = false
	self.window_active = false
	self.window_invert_tall_tex = Assets.getTexture("world/objects/town_church_window_invert_tall")
	self.window_invert_circle_tex = Assets.getTexture("world/objects/town_church_window_invert_circle")
	self.window_invert_short_tex = Assets.getTexture("world/objects/town_church_window_invert_short")
	self.overlay = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)
	self.overlay:setColor(ColorUtils.hexToRGB("#191F34"))
	self.overlay:setParallax(0, 0)
	self.overlay.alpha = 0
	self.overlay.layer = WORLD_LAYERS["below_ui"]
	Game.world:addChild(self.overlay)
end

function ChurchDarknessVFX:update()
    super.update(self)
	self.siner = self.siner + 0.2 * DTMULT
	if self.bg_active then
		self.darkness_strength = math.sin(self.siner / 4)
		self.overlay.alpha = 0.4 + (self.darkness_strength * 0.3)
	else
		self.darkness_strength = 0
		self.overlay.alpha = 0
	end
end

function ChurchDarknessVFX:draw()
    super.draw(self)
	if self.window_active then
		Draw.setColor(1, 1, 1, self.window_alpha + (math.sin(self.siner / 4) * 0.8))
	else
		Draw.setColor(1, 1, 1, self.window_alpha)
	end
	Draw.draw(self.window_invert_tall_tex, 292*2, 110*2, 0, 2, 2)
	Draw.draw(self.window_invert_circle_tex, 281*2, 195*2, 0, 2, 2)
	Draw.draw(self.window_invert_short_tex, 246*2, 257*2, 0, 2, 2)
	Draw.draw(self.window_invert_short_tex, 335*2, 257*2, 0, 2, 2)
	Draw.setColor(1, 1, 1, 1)
end

return ChurchDarknessVFX