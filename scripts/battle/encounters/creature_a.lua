local Dummy, super = Class(Encounter)

function Dummy:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = [[
* Creature Ψ attacks. [wait:10]\n
* Its presence alone makes you shake.
]]

    -- Battle music ("battle" is rude buster)
    self.music = "titan_spawn2"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    self:addEnemy("creature_a")

    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
end

return Dummy