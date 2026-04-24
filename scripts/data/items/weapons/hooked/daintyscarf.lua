local item, super = Class("daintyscarf", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "I can't even heal us."
    })
end

return item