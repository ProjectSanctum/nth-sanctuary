local item, super = Class("twinribbon", true)

function item:init()
    super.init(self)
	
	self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Woah! Pop idle much???"
    })
end

return item