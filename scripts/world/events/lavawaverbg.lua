local LavaWaverBG, super = Class(Event)

function LavaWaverBG:init(data)
    super.init(self, data)
    local properties = data and data.properties or {}
    self.debug_select = false
    self.bg_tex = Assets.getTexture(properties["texture"] or "world/events/lavabg")
end

---@see Draw.drawWrapped
local function drawWrappedHack(drawable, wrap_w, wrap_h)
    local dw, dh = drawable:getDimensions()
    local wrap_area_l, wrap_area_u = love.graphics.inverseTransformPoint(0, 0)
    -- changed from SCREEN_WIDTH etc.
    local wrap_area_r, wrap_area_d = love.graphics.inverseTransformPoint(wrap_w, wrap_h)
    local x1, y1 = math.min(wrap_area_l, wrap_area_r), math.min(wrap_area_u, wrap_area_d)
    local x2, y2 = math.max(wrap_area_l, wrap_area_r), math.max(wrap_area_u, wrap_area_d)
    local x_offset = math.floor(x1 / dw) * dw
    local y_offset = math.floor(y1 / dh) * dh
    local wrap_width = math.ceil((x2 - x_offset) / dw)
    local wrap_height = math.ceil((y2 - y_offset) / dh)

    for i = 1, wrap_width do
        for j = 1, wrap_height do
            Draw.draw(drawable, x_offset + (i - 1) * dw, y_offset + (j - 1) * dh)
        end
    end
end

function LavaWaverBG:draw()
    if self.world.color ~= COLORS.black then
        love.graphics.push()
        local tw, th = self.bg_tex:getWidth() * self.scale_x, self.bg_tex:getHeight() * self.scale_y
        local scratchpad = Draw.pushCanvas(self.world.width + tw*2, self.world.height + th*2)
        love.graphics.translate(tw, th)
        Draw.setColor(1, 1, 1, 0.80 + (self.world.map.lava_alpha or 0))
        drawWrappedHack(self.bg_tex, scratchpad:getWidth(), scratchpad:getHeight())
        Draw.setColor(1, 1, 1, 1)
        Draw.popCanvas()
        love.graphics.translate(-self.x, -self.y) -- undo object position
        Draw.pushShader("lavawave", {
            wave_sine = Kristal.getTime() * 90,
            wave_mag = 6,
            wave_height = 10,
            texsize = { scratchpad:getWidth(), scratchpad:getHeight() }
        })
        Draw.draw(scratchpad, -tw, -th)
        Draw.popShader()
        love.graphics.pop()
    end

    super.draw(self)
end

return LavaWaverBG


-- Thank you Dobby233Liu for the help (From the Kristal server)