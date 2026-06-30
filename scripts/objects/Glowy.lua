---@class Event.glowy : Event
local Glowy, super = Class(Event)

function Glowy:init(data)
    super.init(self, data)
    self.siner = 0
    self.bg_bands = 24
    self.bg_band_height = 25
    self.bg_speed = 0.5
    self.alphade = 0
    self.bg_color = {.4,.4,.4}
    self:setParallax(0)
end

function Glowy.mergeColorInHSV(a, b, t)
    local col1 = {ColorUtils.RGBToHSV(a[1], a[2], a[3])}
    local col2 = {ColorUtils.RGBToHSV(a[1], a[2], a[3])}
    local result_hsv = TableUtils.lerp(col1, col2, t)
    return {ColorUtils.HSVToRGB(unpack(result_hsv))}
end

function Glowy:update()
    super.update(self)
    self.siner = self.siner + DT
    self.bg_color = Glowy.mergeColorInHSV({1,0.7,0.5}, {1,0.5,1}, (math.sin(self.siner)+1)/2)
end

function Glowy:draw()
    super.draw(self)
    love.graphics.push()
    love.graphics.translate(0,SCREEN_HEIGHT + 100)
    local scale = Utils.clampMap(math.sin(Kristal.getTime() * self.bg_speed * math.pi * 0.5), -1, 1, 0.5, 1)
    love.graphics.scale(1, scale)
    
    -- Calculate how squished the bands are (0 = fully squished, 1 = fully expanded)
    local squish_amount = Utils.clampMap(scale, 0.5, 1, 0, 1)
    
    for i=1,self.bg_bands do
        local alpha = Utils.clampMap(i, 1,self.bg_bands, 1,0)
        
        -- Blend color towards red as bands squish together
        local r = self.bg_color[1] * squish_amount + 1 * (1 - squish_amount)
        local g = self.bg_color[2] * squish_amount + 0 * (1 - squish_amount)
        local b = self.bg_color[3] * squish_amount + 1 * (1 - squish_amount)
        
        Draw.setColor({r, g, b}, alpha)
        love.graphics.rectangle("fill", 0,-self.bg_band_height,SCREEN_WIDTH,self.bg_band_height)
        love.graphics.translate(0,-self.bg_band_height)
    end
    love.graphics.pop()
end

return Glowy