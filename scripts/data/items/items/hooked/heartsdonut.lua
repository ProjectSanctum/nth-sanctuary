local item, super = Class("heartsdonut", true)

function item:init()
    super.init(self)
	
	self.heal_amounts = TableUtils.merge(self.heal_amounts, {
        ["jamm"] = 70
    })

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Red jam is good jam."
    })
end

return item