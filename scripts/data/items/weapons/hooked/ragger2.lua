local item, super = Class("ragger2", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Don't even think about it."
    })
end

return item