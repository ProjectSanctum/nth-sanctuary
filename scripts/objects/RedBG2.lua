local RedBG2, super = Class(BattleBackground)

function RedBG2:init()
    super.init(self)
    self.offset = 0
    self.h = 0
    self.glow_siner = 0
end

function RedBG2:update()
    super.update(self)

    self.h = self.h - DTMULT
    self.glow_siner = self.glow_siner + 0.05 * DTMULT


    if not self.fading_out then
        self.alpha = MathUtils.approach(self.alpha, 1, 0.1 * DTMULT)
    else
        self.alpha = MathUtils.approach(self.alpha, 0, 0.1 * DTMULT)

        if self.alpha <= 0 then
            self:remove()
        end
    end
end

function RedBG2:drawWrappedHack(drawable, wrap_x, wrap_y, x, y, r, sx, sy, ox, oy, kx, ky)
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

    local screen_l, screen_u = love.graphics.inverseTransformPoint(-SCREEN_WIDTH/4, -SCREEN_HEIGHT/4)
    local screen_r, screen_d = love.graphics.inverseTransformPoint(SCREEN_WIDTH + SCREEN_WIDTH/4, SCREEN_HEIGHT + SCREEN_HEIGHT/4)

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


function RedBG2:drawBackground()
        -- Draw the black background
    Draw.setColor(0, 0, 0, self.alpha)
    love.graphics.rectangle("fill", -10, -10, SCREEN_WIDTH + 20, SCREEN_HEIGHT + 20)

    local background = Assets.getTexture("battle/backgrounds/redbg_cruel")
    local glow  = Assets.getTexture("battle/backgrounds/redbg_glow")

    Draw.setColor(1, 1, 1, self.alpha)
    self:drawWrappedHack(background, true, true, MathUtils.round(0 - self.h)+(math.sin(self.glow_siner)*10)*2.5, MathUtils.round(0 + self.h), math.rad(-15), 2, 2)

    Draw.setColor(1, 1, 1, self.alpha * (math.sin(self.glow_siner) * 0.25 + 0.5))
    Draw.draw(glow, 0,0,0,2,2)
end

return RedBG2