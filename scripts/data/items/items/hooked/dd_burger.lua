local item, super = Class("dd_burger", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Huh. Leftovers. Neat."
    })
end

return item