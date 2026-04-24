local item, super = Class("gingerguard", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Christmas time already...?"
    })
end

return item