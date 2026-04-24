local item, super = Class("wood_blade", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Ow! Splinter..."
    })
end

return item