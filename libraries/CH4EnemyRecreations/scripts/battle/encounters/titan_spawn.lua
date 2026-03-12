local TitanSpawn, super = Class(Encounter)

function TitanSpawn:init()
    super.init(self)

    self.text = "* Darkness constricts you...\n* [color:yellow]TP[color:reset] Gain reduced outside of [color:green]???[color:reset]"

    self.music = "titan_spawn"
    self.background = true

    self.titan_spawn_1 = self:addEnemy("titan_spawn", 500, 130)
    self.titan_spawn_2 = self:addEnemy("titan_spawn", 500, 290)
	
    self.reduced_tension = true
	self.light_radius = 48
	self.unleash_threshold = 64
end

function TitanSpawn:onTurnEnd()
    super.onTurnEnd(self)
	self.light_radius = 48
end

function TitanSpawn:onBattleStart(battler)
	if Game:hasPartyMember("kris") then
		self.default_xactions = false
		for _,battler in ipairs(Game.battle.party) do
			if battler.chara.id == "susie" then
				Game.battle:registerXAction("susie", "WakeKris", "Revive\nKris", 16)
			elseif battler.chara.id == "ralsei" then
				Game.battle:registerXAction("ralsei", "ReviveKris", "Revive\nKris", 16)
			end
		end
	end
end

return TitanSpawn