local item, super = Class("mechasaber", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Mmm. Might accidentally extend it."
    })
end

return item