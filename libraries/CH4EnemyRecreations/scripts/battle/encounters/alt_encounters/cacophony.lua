local Cacophony, super = Class(Encounter)

function Cacophony:init()
    super.init(self)

    self.text = "* It's a cacophony!"

    self.music = "ch4_battle"
    self.background = true

    self.organikk = self:addEnemy("organikk", 550, 182)
    self.wicabel = self:addEnemy("wicabel", 526, 284)
end

return Cacophony