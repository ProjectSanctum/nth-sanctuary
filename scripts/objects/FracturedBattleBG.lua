local FracturedBattleBG, super = Class(BattleBackground)

function FracturedBattleBG:init()
    super.init(self)
    self.offset = 0
    self.h = 0
    self.glow_siner = 0
    self.timer = self:addChild(Timer())
    
    self.timer:every(1, function()
        self.timer:tween(0.5, self, {h = self.h - 25}, "out-expo")
    end)
end

function FracturedBattleBG:update()
    super.update(self)

    self.h = self.h - DTMULT
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


function FracturedBattleBG:drawBackground()
        -- Draw the black background
    Draw.setColor(0, 0, 0, self.alpha)
    love.graphics.rectangle("fill", -10, -10, SCREEN_WIDTH + 20, SCREEN_HEIGHT + 20)

    local background = Assets.getTexture("battle/backgrounds/redbg")
    local glow  = Assets.getTexture("battle/backgrounds/redbg_glow")

    Draw.setColor(1, 1, 1, self.alpha)
    Draw.drawWrapped(background, true, true, MathUtils.round(0 - self.h), MathUtils.round(0 + self.h), 0, 2, 2)

    Draw.setColor(1, 1, 1, self.alpha * (math.sin(self.glow_siner) * 0.25 + 0.5))
    Draw.draw(glow, 0,0,0,2,2)
end

return FracturedBattleBG