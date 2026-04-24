local item, super = Class("princessrbn", true)

function item:init()
    super.init(self)
	
	self.can_equip = TableUtils.merge(self.can_equip, {
        jamm = false
    })
	
	self.reactions = TableUtils.merge(self.reactions, {
		jamm = "I'm already wearing gloves!"
    })
end

return item