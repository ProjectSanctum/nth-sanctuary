local item, super = Class("autoaxe", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Woah! Shakes a lot..."
    })
end

return item