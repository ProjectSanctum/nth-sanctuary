local item, super = Class("powerband", true)

function item:init()
    super.init(self)
	
	self.reactions = TableUtils.merge(self.reactions, {
		jamm = "I feel powered up!"
    })
end

return item