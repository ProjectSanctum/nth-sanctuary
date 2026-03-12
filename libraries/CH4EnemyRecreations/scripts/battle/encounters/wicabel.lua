local Wicabel, super = Class(Encounter)

function Wicabel:init()
    super.init(self)

    self.text = "* Wicabel clangs in your way!"

    self.music = "ch4_battle"
    self.background = true

    self.wicabel = self:addEnemy("wicabel", 541, 220)
end

return Wicabel