local item, super = Class("spikeband", true)

function item:init()
    super.init(self)
	
	self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Better keep it away from Marcy..."
    })
end

return item