local item, super = Class("white_ribbon", true)

function item:init()
    super.init(self)
	
	self.reactions = TableUtils.merge(self.reactions, {
		jamm = "How adorable!"
    })
end

return item