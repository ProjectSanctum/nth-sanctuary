local item, super = Class("fiberscarf", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Too soft... Too... zzz..."
    })
end

return item