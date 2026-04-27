-- Port of `obj_fx_screenbloom` from Chapter 4
---@class ScreenBloomFX : FXBase
---@overload fun(self: ScreenBloomFX, priority: number): ScreenBloomFX
local ScreenBloomFX, super = Class("FXBase")

function ScreenBloomFX:init(priority)
    super.init(self, priority)

    ---@type 0|1|2|3
    self.style = 3
    self.bright = false
    self.distance = 5
    self.amplitude = 3
    self.period = 20
    self.strength = 1

    self.x_off = 0
    self.y_off = 0

    self.siner = 0
end

function ScreenBloomFX:update()
    self.siner = self.siner + DTMULT
end

---@param texture love.Canvas
function ScreenBloomFX:draw(texture)
    Draw.drawCanvas(texture)
    local eff_can = Draw.pushCanvas(texture:getWidth(), texture:getHeight(), {
        clear = self.bright -- ?
    })
    love.graphics.translate(self.x_off, self.y_off)

    local old_bm, old_bm_al = love.graphics.getBlendMode()
    if self.bright then
        love.graphics.setBlendMode("add")
    end

    local final_strength = self.strength
    local distance = self.distance + (math.sin(self.siner / self.period) * self.amplitude)

    if self.style == 1 then
        Draw.setColor(1, 1, 1, 0.6)
        Draw.draw(texture, -distance*2, -distance*2)
        Draw.draw(texture, distance*2, -distance*2)
        Draw.draw(texture, -distance*2, distance*2)
        Draw.draw(texture, distance*2, distance*2)
    end
    if self.style == 0 or self.style == 1 then
        Draw.setColor(1, 1, 1, 0.5)
        local sc = self.style == 0 and 1/2 or 1 -- ?
        Draw.draw(texture, -distance, -distance, 0, sc, sc)
        Draw.draw(texture, distance, -distance, 0, sc, sc)
        Draw.draw(texture, -distance, distance, 0, sc, sc)
        Draw.draw(texture, distance, distance, 0, sc, sc)
    end

    local function lengthdir_x(radius, angle)
        return math.cos(math.rad(angle)) * radius
    end
    local function lengthdir_y(radius, angle)
        return math.sin(math.rad(angle)) * radius
    end
    if self.style == 2 then
        Draw.setColor(1, 1, 1, 0.6)
        for i = 0, 3 do
            local ang = 90*i + self.siner*2
            Draw.draw(texture, lengthdir_x(distance*2, ang), lengthdir_y(distance*2, ang))
        end
    end
    if self.style == 2 or self.style == 3 then
        Draw.setColor(1, 1, 1, 0.5)
        for i = 0, 3 do
            local ang = 45 + 90*i + self.siner*2
            Draw.draw(texture, lengthdir_x(distance, ang), lengthdir_y(distance, ang))
        end
    end
    if self.style == 2 then
        final_strength = 1 -- ?
    end

    Draw.popCanvas()
    Draw.setColor(1, 1, 1, final_strength)
    Draw.drawCanvas(eff_can)
    Draw.setColor(1, 1, 1)
    love.graphics.setBlendMode(old_bm, old_bm_al) -- too late?
end

return ScreenBloomFX