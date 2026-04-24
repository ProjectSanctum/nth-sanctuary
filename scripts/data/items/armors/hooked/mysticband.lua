local item, super = Class("mysticband", true)

function item:init()
    super.init(self)
	
	self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Here we go, DarkSling!"
    })
end

return item