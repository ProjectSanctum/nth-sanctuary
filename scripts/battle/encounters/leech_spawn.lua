local LeechSpawn, super = Class(Encounter)

function LeechSpawn:init()
    super.init(self)

    self.text = "*          constricts you...\n* [color:yellow]TP[color:reset] Gain reduced outside of [color:green][shake:10]-[shake:0] [color:reset]"

    self.music = "titan_spawn2"
    self.background = true

    self.titan_spawn_1 = self:addEnemy("leech_spawn", 500, 130)
    self.titan_spawn_2 = self:addEnemy("leech_spawn", 500, 290)
	
    self.reduced_tension = true
	self.light_radius = 48
	self.difficulty = 1
	self.unleash_threshold = 50
end

function LeechSpawn:onTurnEnd()
    super.onTurnEnd(self)
	self.light_radius = 48
    self.difficulty = self.difficulty + 1
end

return LeechSpawn