local Burn, super = Class(EnemyStatusCondition)

function Burn:init()
	super.init(self)
	
	self.default_turns = 3
	
	self.icon = "ui/status/burn"
end

function Burn:onTurnStart(battler)
	local mhp = battler.max_health
	local damage = math.floor(mhp/10)
	if damage >= battler.health then
		damage = battler.health - 1
	end
	battler:hurt(damage, nil, nil, {1, 0.5, 0})
end

return Burn