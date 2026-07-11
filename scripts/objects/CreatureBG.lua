local CreatureBG, super = Class(BattleBackground)

function CreatureBG:init()
    super.init(self)
    self.offset = 0
    self.h = 0
end

function CreatureBG:update()
    super.update(self)

    self.h = self.h - DTMULT
end


function CreatureBG:drawBackground()
    local fog = Assets.getTexture("battle/backgrounds/perlin_noise_dark_looping")
    local bgtexture = Assets.getTexture("battle/backgrounds/creature_bg")
    
	local canvas = Draw.pushCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)
    Draw.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", -10, -10, SCREEN_WIDTH + 20, SCREEN_HEIGHT + 20)
    Draw.setColor(1, 1, 1, 0.5 + math.sin(self.h/40)/32)
    Draw.drawWrapped(bgtexture, true, true, MathUtils.round(6 - self.h/2), MathUtils.round(2 - self.h/2), 0, 1, 1)
    Draw.drawWrapped(bgtexture, true, true, MathUtils.round(6 - self.h)-10, MathUtils.round(2 - self.h)-10, 0, 2, 2)
    Draw.setColor(1, 1, 1, -math.sin(self.h/20)/8 + 0.5)
    Draw.drawWrapped(fog, true, true, MathUtils.round(12 - self.h*2), MathUtils.round(18 - self.h*2), 0, 2, 2)
    Draw.drawWrapped(fog, true, true, MathUtils.round(0 + self.h)+math.sin(self.h/20)*10, MathUtils.round(0 + self.h), 0, 2, 2)
    Draw.popCanvas(true)
	
    Draw.setColor(1, 1, 1, self.alpha)
    Draw.drawCanvas(canvas)    
end

return CreatureBG