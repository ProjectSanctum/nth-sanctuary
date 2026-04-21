---@class FracturedHSVFXRevert: ShaderFX
---@field shader love.Shader
local FracturedHSVFXRevert, super = Class(ShaderFX)

function FracturedHSVFXRevert:init(heartbeat, priority)
    super.init(self, "hsv_transform", {}, nil, priority)
    local f = Game.battle:getFX(FracturedHSVFX)
    self.hue_start = 360-f.hue_start;
    self.sat_start = 0.5+f.sat_start;
    self.val_start = 1;
    self.hue_target = 360-f.hue_target;
    self.sat_target = 0.5+f.sat_target;
    self.val_target = 1;
    self.hue = self.hue_start;
    self.sat = self.sat_start;
    self.val = self.val_start;
    self.wave_time = MathUtils.rangeMap(math.abs(self.hue_start - self.hue_target), 0, 255, 1, 10);
    self.heartbeat_mode = heartbeat or false
	self.amount = 1

    -- Unused?
    if (self.wave_time == 0) then
        self.hue = self.hue_target;
        self.sat = self.sat_target;
        self.val = self.val_target;
    end
end

function FracturedHSVFXRevert:update()
    super.update(self)
    if (self.wave_time > 0) then
        self.hue = Ch4Lib.scr_wave(self.hue_start, self.hue_target, self.wave_time, 0);
        self.sat = Ch4Lib.scr_wave(self.sat_start, self.sat_target, self.wave_time, 0);
        self.val = Ch4Lib.scr_wave(self.val_start, self.val_target, self.wave_time, 0);
    end

    if (self.heartbeat_mode) then
        local _percent = Game:getActiveMusic():tell() / Game:getActiveMusic().source:getDuration();
        self.hue = MathUtils.lerp(self.hue_start, self.hue_target, math.abs(math.sin(_percent * math.pi)));
        self.sat = MathUtils.lerp(self.sat_start, self.sat_target, math.abs(math.sin(_percent * math.pi)));
        self.val = MathUtils.lerp(self.val_start, self.val_target, math.abs(math.sin(_percent * math.pi)));
    end
end

function FracturedHSVFXRevert:isActive()
    return super.isActive(self) and self.amount > 0
end

function FracturedHSVFXRevert:draw(texture)
    self.shader:send("_hsv", {self.hue, self.sat, self.val})
	if self.amount < 1 then
		Draw.drawCanvas(texture)
		Draw.setColor(1, 1, 1, self.amount)
		local last_shader = love.graphics.getShader()
		love.graphics.setShader(self.shader)
		Draw.draw(texture)
		Draw.setColor(1, 1, 1, 1)
		love.graphics.setShader(last_shader)
	else
		super.draw(self, texture)
	end
end

return FracturedHSVFXRevert