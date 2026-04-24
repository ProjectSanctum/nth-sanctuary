local item, super = Class("goldwidow", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "It's so intricate..."
    })
end

return item