local item, super = Class("flexscarf", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Flexible..."
    })
end

return item