local Guei, super = Class(Encounter)

function Guei:init()
    super.init(self)

    self.text = "* Guei wisps in your way!"

    self.music = "ch4_battle"
    self.background = true

    self.guei_1 = self:addEnemy("guei", 550, 182)
    self.guei_2 = self:addEnemy("guei", 526, 284)
end

return Guei