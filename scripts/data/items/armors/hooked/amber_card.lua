local item, super = Class("amber_card", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "It won't fall off like this, right?"
    })
end

return item