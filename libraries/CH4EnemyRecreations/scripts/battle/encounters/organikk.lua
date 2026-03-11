local Organikk, super = Class(Encounter)

function Organikk:init()
    super.init(self)

    self.text = "* Organikk accosts you!"

    self.music = "ch4_battle"
    self.background = true

    self.organ_1 = self:addEnemy("organikk", 550, 182)
    self.organ_2 = self:addEnemy("organikk", 526, 284)
end

return Organikk