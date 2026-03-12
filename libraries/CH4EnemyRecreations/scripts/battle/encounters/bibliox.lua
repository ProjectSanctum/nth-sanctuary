local Bibliox, super = Class(Encounter)

function Bibliox:init()
    super.init(self)

    self.text = "* Bibliox opens up!"

    self.music = "ch4_battle"
    self.background = true

    self.bibliox = self:addEnemy("bibliox", 550, 182)
    self.bibliox = self:addEnemy("bibliox", 526, 284)
end

return Bibliox