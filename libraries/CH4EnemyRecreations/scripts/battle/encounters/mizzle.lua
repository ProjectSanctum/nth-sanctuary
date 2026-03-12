local Mizzle, super = Class(Encounter)

function Mizzle:init()
    super.init(self)

    self.text = "* Mizzle was woken up!"

    self.music = "ch4_battle"
    self.background = true

    self.mizzle_1 = self:addEnemy("mizzle", 550, 182)
    self.mizzle_2 = self:addEnemy("mizzle", 526, 284)
end

return Mizzle