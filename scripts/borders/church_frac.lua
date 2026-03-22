---@class Border.church_frac: Border
local ChurchFracBorder, super = Class(ImageBorder)

function ChurchFracBorder:init()
    super.init(self, "church_frac")
    self.id = "church_frac"
    
    self.hue_start = -255
    self.sat_start = 5/10
    self.val_start = 1.25
    self.hue_target = 255
    self.sat_target = 15/10
    self.val_target = 1.25
    self.hue = self.hue_start
    self.sat = self.sat_start
    self.val = self.val_start
    self.wave_time = 25
    
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
    self.interlace_tex = Assets.getTexture("borders/church_frac_interlace")
end

function ChurchFracBorder:update()
    super.update(self)
end

function ChurchFracBorder:drawWrapped(drawable, wrap_x, wrap_y, x, y, r, sx, sy, ox, oy, kx, ky)
    local dw, dh = drawable:getDimensions()

    if x then
        x, y = x or 0, y or 0
        r, sx, sy = r or 0, sx or 1, sy or 1
        ox, oy = ox or 0, oy or 0
        kx, ky = kx or 0, ky or 0

        love.graphics.push()
        if x ~= 0 or y ~= 0 then love.graphics.translate(x, y) end
        if r ~= 0 then love.graphics.rotate(r) end
        if sx ~= 1 or sy ~= 1 then love.graphics.scale(sx, sy) end
        if kx ~= 0 or ky ~= 0 then love.graphics.shear(kx, ky) end
        if ox ~= 0 or oy ~= 0 then love.graphics.translate(-ox, -oy) end
    end

    local screen_l, screen_u = love.graphics.inverseTransformPoint(0, 0)
    local screen_r, screen_d = love.graphics.inverseTransformPoint(BORDER_WIDTH, BORDER_HEIGHT)

    local x1, y1 = math.min(screen_l, screen_r), math.min(screen_u, screen_d)
    local x2, y2 = math.max(screen_l, screen_r), math.max(screen_u, screen_d)

    local x_offset = math.floor(x1 / dw) * dw
    local y_offset = math.floor(y1 / dh) * dh

    local wrap_width = math.ceil((x2 - x_offset) / dw)
    local wrap_height = math.ceil((y2 - y_offset) / dh)

    if wrap_x and wrap_y then
        for i = 1, wrap_width do
            for j = 1, wrap_height do
                Draw.draw(drawable, x_offset + (i - 1) * dw, y_offset + (j - 1) * dh)
            end
        end
    elseif wrap_x then
        for i = 1, wrap_width do
            Draw.draw(drawable, x_offset + (i - 1) * dw, 0)
        end
    elseif wrap_y then
        for j = 1, wrap_height do
            Draw.draw(drawable, 0, y_offset + (j - 1) * dh)
        end
    end

    if x then
        love.graphics.pop()
    end
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
	self:drawWrapped(self.interlace_tex, false, true, 0, 0, 0, BORDER_SCALE, (BORDER_SCALE + 0.5) / Kristal.getGameScale())
    
    love.graphics.setShader(last_shader)
end

return ChurchFracBorder
