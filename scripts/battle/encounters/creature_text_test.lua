local Dummy, super = Class(Encounter)

function Dummy:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Imbued Speech Bubble Test."

    -- Battle music ("battle" is rude buster)
    self.music = "battle_creature"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    self:addEnemy("creature_text_test")

    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
end

function Dummy:createBackground()
    return Game.battle:addChild(CreatureBG())
end
return Dummy