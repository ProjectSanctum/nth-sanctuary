local RedBG2, super = Class(BattleBackground)

function RedBG2:init()
    super.init(self)
    self.offset = 0
    self.h = 0
    self.glow_siner = 0
end

function RedBG2:update()
    super.update(self)

    self.h = self.h -1
    self.glow_siner = self.glow_siner + 0.05 


    if not self.fading_out then
        self.alpha = MathUtils.approach(self.alpha, 1, 0.1 * DTMULT)
    else
        self.alpha = MathUtils.approach(self.alpha, 0, 0.1 * DTMULT)

        if self.alpha <= 0 then
            self:remove()
        end
    end
end


function RedBG2:drawBackground()
        -- Draw the black background
    Draw.setColor(0, 0, 0, self.alpha)
    love.graphics.rectangle("fill", -10, -10, SCREEN_WIDTH + 20, SCREEN_HEIGHT + 20)

    local background = Assets.getTexture("battle/backgrounds/redbg_cruel")
    local glow  = Assets.getTexture("battle/backgrounds/redbg_glow")

    Draw.setColor(1, 1, 1, self.alpha)
    Draw.drawWrapped(background, true, true, MathUtils.round(0 - self.h)+(math.sin(self.glow_siner)*10)*2.5, MathUtils.round(0 + self.h), 0, 2, 2)

    Draw.setColor(1, 1, 1, self.alpha * (math.sin(self.glow_siner) * 0.25 + 0.5))
    Draw.draw(glow, 0,0,0,2,2)
end

return RedBG2