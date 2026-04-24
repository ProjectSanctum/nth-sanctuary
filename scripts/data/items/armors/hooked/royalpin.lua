local item, super = Class("royalpin", true)

function item:init()
    super.init(self)
	
	self.reactions = TableUtils.merge(self.reactions, {
		jamm = "...So who is this, exactly?"
    })
end

return item