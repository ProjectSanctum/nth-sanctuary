local item, super = Class("silver_card", true)

function item:init()
    super.init(self)
	
	self.reactions = TableUtils.merge(self.reactions, {
		jamm = "(Did they max it out...?)"
    })
end

return item