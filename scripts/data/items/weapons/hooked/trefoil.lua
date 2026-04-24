local item, super = Class("trefoil", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "I'm not a billboard!"
    })
end

return item