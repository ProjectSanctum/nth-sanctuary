local item, super = Class("silver_watch", true)

function item:init()
    super.init(self)
	
	self.can_equip = TableUtils.merge(self.can_equip, {
        jamm = false
    })
	
	self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Watch? I already have one!"
    })
end

return item