local Waferr, super = Class(Encounter)

function Waferr:init()
    super.init(self)

    self.text = "* Waferr shapes up for battle!"

    self.music = "ch4_battle2"
    self.background = true

    self.organ_1 = self:addEnemy("waferr", 550, 142)
    self.organ_2 = self:addEnemy("waferr", 526, 244)
    self.organ_3 = self:addEnemy("waferr", 490, 346)
end

return Waferr