local Dummy, super = Class(Encounter)

function Dummy:init()
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
end

function Dummy:createBackground()
    self.bg.layer =BATTLE_LAYERS["background"]
    return Game.battle:addChild(self.bg)
end

return Dummy