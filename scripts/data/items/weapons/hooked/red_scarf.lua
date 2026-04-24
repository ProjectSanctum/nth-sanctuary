local item, super = Class("red_scarf", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Red is... not my color."
    })
end

return item