local Poison, super = Class(StatusCondition)

function Poison:init()
	super.init(self)
	
	self.name = "Poison"
	
	self.desc = "Slowly lowers your HP when it's your turn, but never kills."
	
	self.default_turns = 3
	
	self.icon = "ui/status/poison"
	
	self.poison_timer = 0
	self.poison_damage = false
end

function Poison:onUpdate(battler)
	if self.poison_damage then
		self.poison_timer = (self.poison_timer or 0) + DTMULT

		if self.poison_timer >= 6 then
			self.poison_timer = self.poison_timer - 6

			if battler.chara:getHealth() > MathUtils.round(battler.chara:getStat("health") / 4) then
				battler.chara:setHealth(battler.chara:getHealth() - 1)
			end
		end
	end
end

function Poison:onTurnStart(battler)
	self.poison_damage = true
    self.poison_timer = 0
end

function Poison:onActionsEnd(battler)
	self.poison_damage = false
    self.poison_timer = 0
end

return Poison