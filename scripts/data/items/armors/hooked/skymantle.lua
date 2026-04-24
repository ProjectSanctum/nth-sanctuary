local item, super = Class("skymantle", true)

function item:init()
    super.init(self)
	
	self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Huh, like when I was a kid."
    })
end

return item