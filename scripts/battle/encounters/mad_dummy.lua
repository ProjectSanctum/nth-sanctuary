local Dummy, super = Class(Encounter)

function Dummy:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Lights![wait:5] Camera![wait:5] Action![wait:5]\n* The battle scene begins!"

    -- Battle music ("battle" is rude buster)
    self.music = "battle"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    self:addEnemy("mad_dummy")

    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
end

return Dummy