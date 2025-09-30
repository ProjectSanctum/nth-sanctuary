---@class HSVShiftFX3: ShaderFX
---@field shader love.Shader
local HSVShiftFX3, super = Class(ShaderFX)

function HSVShiftFX3:init(heartbeat, priority)
    super.init(self, "hsv_transform", {}, nil, priority)

    self.hue_start = -100;
    self.sat_start = 0.6;
    self.val_start = 1;
    self.hue_target = -140;
    self.sat_target = 0.6;
    self.val_target = 1.5;
    self.hue = self.hue_start;
    self.sat = self.sat_start;
    self.val = self.val_start;
    self.wave_time = 2;
    self.heartbeat_mode = heartbeat or false

    -- Unused?
    if (self.wave_time == 0) then
        self.hue = self.hue_target;
        self.sat = self.sat_target;
        self.val = self.val_target;
    end
end

function HSVShiftFX3:update()
    super.update(self)
    if (self.wave_time > 0) then
        self.hue = Ch4Lib.scr_wave(self.hue_start, self.hue_target, self.wave_time, 0);
        self.sat = Ch4Lib.scr_wave(self.sat_start, self.sat_target, self.wave_time, 0);
        self.val = Ch4Lib.scr_wave(self.val_start, self.val_target, self.wave_time, 0);
    end

    if (self.heartbeat_mode) then
        local _percent = Game:getActiveMusic():tell() / Game:getActiveMusic().source:getDuration();
        self.hue = Utils.lerp(self.hue_start, self.hue_target, math.abs(math.sin(_percent * math.pi)));
        self.sat = Utils.lerp(self.sat_start, self.sat_target, math.abs(math.sin(_percent * math.pi)));
        self.val = Utils.lerp(self.val_start, self.val_target, math.abs(math.sin(_percent * math.pi)));
    end

end

function HSVShiftFX3:draw(texture)
    self.shader:send("_hsv", {self.hue, self.sat, self.val})
    super.draw(self, texture)
end

return HSVShiftFX3