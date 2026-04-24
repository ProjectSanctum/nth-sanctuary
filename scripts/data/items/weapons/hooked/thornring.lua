local item, super = Class("thornring", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "And I thought Ragger2 was bad..."
    })
end

return item