local item, super = Class("lightcandy", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Not the last time I eat chalk."
    })
end

return item