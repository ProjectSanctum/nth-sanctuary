local item, super = Class("gigasalad", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Not much of a salad eater..."
    })
end

return item