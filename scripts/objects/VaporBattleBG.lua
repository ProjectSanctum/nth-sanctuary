---@class Event.glowy : Object
local Glowy, super = Class(Object)

function Glowy:init()
    super.init(self)
    self.siner = 0
    self.bg_bands = 24
    self.bg_band_height = 25
    self.bg_speed = 0.5
    self.alphade = 0
    self.bg_color = {.4,.4,.4}

    self.spr = Assets.getTexture("world/objects/vapor_sun")

    self.fx = ShaderFX("wave_interlace", {
				["wave_sine"] = function () return Kristal.getTime() * 50 end,
				["wave_mag"] = function () return 10 end,
				["wave_height"] = 10,
				["texsize"] = { SCREEN_WIDTH, SCREEN_HEIGHT }
			}), "funky_mode"
            self:addFX(self.fx)
            self.alpha = 0.01
    self.timer = Timer()
    self.timer:every(1, function()
        local spr = Sprite("effects/ball")
        Game.battle:addChild(spr)
        spr.x,spr.y = love.math.random(0, SCREEN_WIDTH), SCREEN_HEIGHT
        spr.physics.speed_y = -5
        spr.layer = self.layer + 1
        spr:setScale(love.math.random(5,15)/10)
        spr:addFX(self.fx)
        self.timer:after(3, function()
        spr:fadeOutAndRemove(1)
        end)
    end)
end

function Glowy.mergeColorInHSV(a, b, t)
    local col1 = {ColorUtils.RGBToHSV(a[1], a[2], a[3])}
    local col2 = {ColorUtils.RGBToHSV(a[1], a[2], a[3])}
    local result_hsv = TableUtils.lerp(col1, col2, t)
    return {ColorUtils.HSVToRGB(unpack(result_hsv))}
end

function Glowy:update()
    super.update(self)
    self.timer:update()
    self.siner = self.siner + DT
    self.bg_color = Glowy.mergeColorInHSV({1,0.7,0.5}, {1,0.5,1}, (math.sin(self.siner)+1)/2)
    if not self.fading_out then
        self.alpha = MathUtils.approach(self.alpha, 1, 0.1 * DTMULT)
    else
        self.alpha = MathUtils.approach(self.alpha, 0, 0.1 * DTMULT)

        if self.alpha <= 0 then
            self:remove()
        end
    end
end

function Glowy:draw()
    super.draw(self)
    Draw.setColor(0, 0, 0, self.alpha)
    love.graphics.rectangle("fill", -10, -10, SCREEN_WIDTH + 20, SCREEN_HEIGHT + 20)
    Draw.setColor(1, 1, 1, self.alpha)
    love.graphics.draw(self.spr, SCREEN_WIDTH/2-self.spr:getWidth(),Game.battle and Game.battle.battle_ui.y - 9 - self.spr:getHeight()*2 or 0,0,2,2)
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
        
        Draw.setColor({r, g, b}, self.alpha*alpha)
        love.graphics.rectangle("fill", 0,-self.bg_band_height,SCREEN_WIDTH,self.bg_band_height)
        love.graphics.translate(0,-self.bg_band_height)
    end
    love.graphics.pop()
end

function Glowy:isFading()
    return self.fading_out
end

function Glowy:fadeOut()
    self.fading_out = true
end

return Glowy