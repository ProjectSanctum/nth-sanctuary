local item, super = Class("spincake", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "I need to sit down..."
    })
end

return item