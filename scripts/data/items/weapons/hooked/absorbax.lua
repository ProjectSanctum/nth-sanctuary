local item, super = Class("absorbax", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Feels... vampiric."
    })
end

return item