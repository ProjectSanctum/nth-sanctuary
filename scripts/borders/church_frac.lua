---@class Border.church_frac: Border
local ChurchFracBorder, super = Class(ImageBorder)

function ChurchFracBorder:init()
    super.init(self, "church_frac")
    self.id = "church_frac"
    
    self.hue_start = love.math.random(-255, 255)
    self.sat_start = love.math.random(5, 15)/10
    self.val_start = 1.0
    self.hue_target = love.math.random(-255, 255)
    self.sat_target = love.math.random(5, 15)/10
    self.val_target = 1.0
    self.hue = self.hue_start
    self.sat = self.sat_start
    self.val = self.val_start
    self.wave_time = love.math.random(1, 10)
    
    self.shader = love.graphics.newShader([[
        extern number hue;
        extern number sat;
        extern number val;
        
        vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
            vec4 pixel = Texel(texture, texture_coords);
            
            float r = pixel.r;
            float g = pixel.g;
            float b = pixel.b;
            
            float max_val = max(max(r, g), b);
            float min_val = min(min(r, g), b);
            float delta = max_val - min_val;
            
            float h = 0.0;
            float s = (max_val == 0.0) ? 0.0 : (delta / max_val);
            float v = max_val;
            
            if (delta != 0.0) {
                if (max_val == r) {
                    h = mod((g - b) / delta + 6.0, 6.0);
                } else if (max_val == g) {
                    h = (b - r) / delta + 2.0;
                } else {
                    h = (r - g) / delta + 4.0;
                }
                h = h / 6.0;
            }
            
            h = mod(h + hue / 360.0, 1.0);
            s = clamp(s * sat, 0.0, 1.0);
            v = clamp(v * val, 0.0, 1.0);
            
            float c = v * s;
            float x = c * (1.0 - abs(mod(h * 6.0, 2.0) - 1.0));
            float m = v - c;
            
            float new_r, new_g, new_b;
            
            if (h < 1.0/6.0) {
                new_r = c; new_g = x; new_b = 0.0;
            } else if (h < 2.0/6.0) {
                new_r = x; new_g = c; new_b = 0.0;
            } else if (h < 3.0/6.0) {
                new_r = 0.0; new_g = c; new_b = x;
            } else if (h < 4.0/6.0) {
                new_r = 0.0; new_g = x; new_b = c;
            } else if (h < 5.0/6.0) {
                new_r = x; new_g = 0.0; new_b = c;
            } else {
                new_r = c; new_g = 0.0; new_b = x;
            }
            
            new_r = new_r + m;
            new_g = new_g + m;
            new_b = new_b + m;
            
            return vec4(new_r, new_g, new_b, pixel.a) * color;
        }
    ]])
end

function ChurchFracBorder:update()
    super.update(self)
end

function ChurchFracBorder:draw()
    if self.wave_time > 0 then
        self.hue = Ch4Lib.scr_wave(self.hue_start, self.hue_target, self.wave_time, 0)
        self.sat = Ch4Lib.scr_wave(self.sat_start, self.sat_target, self.wave_time, 0)
        self.val = Ch4Lib.scr_wave(self.val_start, self.val_target, self.wave_time, 0)
    end
    
    local last_shader = love.graphics.getShader()
    love.graphics.setShader(self.shader)
    
    self.shader:send("hue", self.hue)
    self.shader:send("sat", self.sat)
    self.shader:send("val", self.val)
    
    super.draw(self)
    
    love.graphics.setShader(last_shader)
end

return ChurchFracBorder
