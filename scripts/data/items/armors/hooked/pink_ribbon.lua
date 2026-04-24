local item, super = Class("pink_ribbon", true)

function item:init()
    super.init(self)
	
	self.reactions = TableUtils.merge(self.reactions, {
		jamm = "How adorable!"
    })
end

return item