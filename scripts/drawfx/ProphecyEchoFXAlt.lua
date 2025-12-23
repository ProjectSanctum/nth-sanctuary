---@class ProphecyEchoFX: FXBase
local ProphecyEchoFXAlt, super = Class(FXBase)

function ProphecyEchoFXAlt:init(speed, priority)
    super.init(self, priority)
	self.tick = 0
	self.scroll_speed = speed
end

function ProphecyEchoFXAlt:draw(texture)
	self.tick = self.tick + (((1/15) * self.scroll_speed) * DTMULT)
	local amt = math.sin((self.tick / 15) * (2 * math.pi)) * (self.scroll_speed * 6)
    Draw.setColor(1,1,1,0.4)
    Draw.drawCanvas(texture, -amt, -amt);
    Draw.drawCanvas(texture, amt, amt);
    Draw.setColor(COLORS.white)

    super.draw(self, texture)
end

return ProphecyEchoFXAlt