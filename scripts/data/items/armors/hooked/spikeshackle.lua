local item, super = Class("spikeshackle", true)

function item:init()
    super.init(self)
	
	self.reactions = TableUtils.merge(self.reactions, {
		jamm = "...Okay."
    })
end

return item