local Jellycruel, super = Class(Encounter)

function Jellycruel:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* A strong aura emanates from the jellycruel."

    -- Battle music ("battle" is rude buster)
    self.music = "battle_vapor"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    self:addEnemy("jellycruel")
end

return Jellycruel