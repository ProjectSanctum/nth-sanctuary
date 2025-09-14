local Winglade, super = Class(Encounter)

function Winglade:init()
    super.init(self)

    self.text = "* Guei wisps in your way!"

    self.music = "ch4_battle"
    self.background = true

    self:addEnemy("guei", 520, 140)
    self:addEnemy("guei", 520, 300)
end

return Winglade