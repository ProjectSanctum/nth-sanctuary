local NymphSpawn, super = Class(Encounter)

function NymphSpawn:init()
    super.init(self)

    self.text = "*          constricts you...\n* [color:yellow]TP[color:reset] Gain reduced outside of [color:green][shake:10]-[shake:0] [color:reset]"

    self.music = "titan_spawn2"
    self.background = true

    self:addEnemy("nymph_spawn")

    self.reduced_tension = true
	self.light_radius = 48
	self.difficulty = 1
	self.unleash_threshold = 64
end

function NymphSpawn:onTurnEnd()
    super.onTurnEnd(self)
	self.light_radius = 48
    self.difficulty = self.difficulty + 1
end

function NymphSpawn:onBattleStart(battler)
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

return NymphSpawn