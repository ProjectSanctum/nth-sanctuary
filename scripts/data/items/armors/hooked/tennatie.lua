local item, super = Class("tennatie", true)

function item:init()
    super.init(self)
	
	self.reactions = TableUtils.merge(self.reactions, {
		jamm = "I'll just... wrap it around my arm."
    })
end

return item