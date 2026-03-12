local ScentedCandles, super = Class(Encounter)

function ScentedCandles:init()
    super.init(self)

    self.text = "* Smells like scented candles."

    self.music = "ch4_battle"
    self.background = true

    self.guei = self:addEnemy("guei", 550, 182)
    self.balthizard = self:addEnemy("balthizard", 526, 284)
end

return ScentedCandles