local item, super = Class("jevilstail", true)

function item:init()
    super.init(self)
	
	self.can_equip = TableUtils.merge(self.can_equip, {
	    jamm = false,
        noel = false,
        ceroba = false,
    })

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "It won't fit...!"
    })
end

return item