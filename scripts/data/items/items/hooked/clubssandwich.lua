local item, super = Class("clubssandwich", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "I can barely taste the tomato. Wait..."
    })
end

return item