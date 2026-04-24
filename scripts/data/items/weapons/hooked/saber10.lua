local item, super = Class("saber10", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Ow! Prickly..."
    })
end

return item