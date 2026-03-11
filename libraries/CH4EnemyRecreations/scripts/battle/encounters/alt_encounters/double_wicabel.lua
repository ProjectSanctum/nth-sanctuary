local Wicabel, super = Class(Encounter)

function Wicabel:init()
    super.init(self)

    self.text = "* Wicabel clangs in your way!"

    self.music = "ch4_battle"
    self.background = true

    self.wicabel = self:addEnemy("wicabel", 475 + 41, 56 + 112)
    self.wicabel = self:addEnemy("wicabel", 488 + 41, 188 + 112)
end

return Wicabel