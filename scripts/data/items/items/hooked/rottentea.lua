local item, super = Class("rottentea", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "It's all chunky..."
    })
end

return item