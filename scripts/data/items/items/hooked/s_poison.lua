local item, super = Class("s_poison", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Blech! What is this!?"
    })
end

return item