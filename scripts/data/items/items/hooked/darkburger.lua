local item, super = Class("darkburger", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Burnt food isn't all that bad."
    })
end

return item