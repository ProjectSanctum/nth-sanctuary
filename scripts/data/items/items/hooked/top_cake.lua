local item, super = Class("top_cake", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
        jamm = "That's a LOT of sugar.",
    })
end

return item