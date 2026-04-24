local item, super = Class("mousetoken", true)

function item:init()
    super.init(self)
	
	self.reactions = TableUtils.merge(self.reactions, {
		jamm = "This brings back memories."
    })
end

return item