local item, super = Class("shadowmantle", true)

function item:init()
    super.init(self)
	
	self.reactions = TableUtils.merge(self.reactions, {
		jamm = "How'd you guys get this again?"
    })
end

return item