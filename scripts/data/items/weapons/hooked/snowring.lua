local item, super = Class("snowring", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "It's pretty cold, huh..."
    })
end

return item