local Fizzle_Duo, super = Class(Encounter)

function Fizzle_Duo:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Fizzles condensate in!"

    -- Battle music ("battle" is rude buster)
    self.music = "vaporbattle"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    self:addEnemy("fizzle")
    self:addEnemy("fizzle")

    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
    self.bg = VaporBattleBG()

    self.next_soul_speed = 4
end

function Fizzle_Duo:createSoul(x, y, color)
    local soul = super.createSoul(self, x, y, color)    
    if self.next_soul_speed then
        soul.speed = self.next_soul_speed
    end
    return soul
end

function Fizzle_Duo:onWavesDone()
    self.next_soul_speed = 4
end

function Fizzle_Duo:createBackground()
    self.bg.layer =BATTLE_LAYERS["background"]
    return Game.battle:addChild(self.bg)
end

return Fizzle_Duo