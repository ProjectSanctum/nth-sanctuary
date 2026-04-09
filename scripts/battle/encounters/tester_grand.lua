local Dummy, super = Class(Encounter)

function Dummy:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* GRAND SANCTUARY BATTLE BG TEST."

    -- Battle music ("battle" is rude buster)
    self.music = "battle3"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    self:addEnemy("tester")
end

function Dummy:createBackground()
    return Game.battle:addChild(GrandBG())
end

return Dummy

