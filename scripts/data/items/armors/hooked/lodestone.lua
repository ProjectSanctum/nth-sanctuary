local item, super = Class("lodestone", true)

function item:init()
    super.init(self)
	
	self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Slow and steady wins the race."
    })
end

return item