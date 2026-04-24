local item, super = Class("bounceblade", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "So is this like... a practice sword?"
    })
end

return item