local item, super = Class("twistedswd", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "How do I even use this?"
    })
end

return item