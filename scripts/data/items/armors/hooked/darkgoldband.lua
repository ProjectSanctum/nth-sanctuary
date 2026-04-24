local item, super = Class("darkgoldband", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "How are we even carrying this?"
    })
end

return item