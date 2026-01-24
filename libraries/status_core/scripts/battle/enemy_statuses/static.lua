local Static, super = Class(EnemyStatusCondition)

function Static:init()
	super.init(self)
	
	self.default_turns = 3
	
	self.icon = "ui/status/static"
end

function Static:onOtherHurt(battler, other, amount)
	battler:hurt(amount, nil, nil, {1, 1, 1})
end

return Static