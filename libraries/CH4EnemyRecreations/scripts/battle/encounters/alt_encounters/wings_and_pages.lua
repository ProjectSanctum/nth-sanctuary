local WingsAndPages, super = Class(Encounter)

function WingsAndPages:init()
    super.init(self)

    self.text = "* The flapping of wings and pages fills the room."

    self.music = "ch4_battle"
    self.background = true

    self.bibliox = self:addEnemy("bibliox", 550, 182)
    self.winglade = self:addEnemy("winglade", 526, 284)
end

return WingsAndPages