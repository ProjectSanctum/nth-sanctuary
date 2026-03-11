local TripleMizzle, super = Class(Encounter)

function TripleMizzle:init()
    super.init(self)

    self.text = "* Placeholder."

    self.music = "ch4_battle"
    self.background = true

    self.mizzle_1 = self:addEnemy("mizzle", 548, 130)
    self.mizzle_2 = self:addEnemy("mizzle", 526, 210)
    self.mizzle_3 = self:addEnemy("mizzle", 550, 300)
end

return TripleMizzle