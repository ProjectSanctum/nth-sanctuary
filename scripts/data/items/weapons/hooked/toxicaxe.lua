local item, super = Class("toxicaxe", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "How'd you even..."
    })
end

return item