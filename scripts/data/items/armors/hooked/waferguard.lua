local item, super = Class("waferguard", true)

function item:init()
    super.init(self)
	
	self.reactions = TableUtils.merge(self.reactions, {
		jamm = "It looks... holy."
    })
end

return item