local Numb, super = Class(EnemyStatusCondition)

function Numb:init()
	super.init(self)
	
	self.default_turns = 3
	
	self.icon = "ui/status/numb"
end

function Numb:onStatus(battler)
	battler.numb = 0
	self.invincible = 0
end

function Numb:onHurt(battler, amount)
	battler.numb = battler.numb + amount
	return self.invincible * amount
end

function Numb:onCure(battler)
	self.invincible = 1
	battler:hurt(battler.numb, nil, nil, {0.2, 1, 1})
end

return Numb