local FX, super = Class(FXBase)

function FX:init(priority)
    super.init(self, priority)

    self.shader = Assets.getShader("crt")
    self.aberration = 0.34
    self.time = 0
    self.speed = 0.5
end

local function wave(arg0, arg1, arg2, arg3)
	local a4 = (arg1 - arg0) * 0.5
	return arg0 + a4 + (math.sin(((Kristal.getTime() + (arg2 * arg3)) / arg2) * (2 * math.pi)) * a4);
end

function FX:draw(texture)
	self.speed = wave(0, 0.75, 4, 0)
	self.time = self.time + self.speed * DTMULT
    Draw.pushShader(self.shader, {
        aberation_amount = self.aberration,
        TIME = self.time
    })
    Draw.drawCanvas(texture)
    Draw.popShader()
end

return FX