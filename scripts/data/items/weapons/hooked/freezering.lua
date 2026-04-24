local item, super = Class("freezering", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "It's cold..."
    })
end

return item