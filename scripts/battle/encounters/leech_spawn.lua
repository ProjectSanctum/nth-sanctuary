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
end

function LeechSpawn:onTurnEnd()
    super.onTurnEnd(self)
	self.light_radius = 48
    self.difficulty = self.difficulty + 1
end

function LeechSpawn:getPartyPosition(index)
    local krloc = {94, 50}
    local suloc = {80, 122}
    local raloc = {72, 200}

    if #Game.party == 1 then
        krloc = {80, 122}
    elseif #Game.party == 2 then
        krloc = {94, 86}
        suloc = {80, 166}
    end

    if index == 1 then
        return krloc[1]+(19 + 4), krloc[2]+(38 + 38)
    elseif index == 2 then
        return suloc[1]+(25 + 6), suloc[2]+(43 + 45)
    elseif index == 3 then
        return raloc[1]+(21 + 4), raloc[2]+(40 + 52)
    else
        return super.getPartyPosition(self, index)
    end
end

return LeechSpawn