local item, super = Class("chocdiamond", true)

function item:init()
    super.init(self)
	
	self.heal_amounts = TableUtils.merge(self.reactions, {
		["jamm"] = 40
    })

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "I thought this was hollow...?"
    })
end

return item