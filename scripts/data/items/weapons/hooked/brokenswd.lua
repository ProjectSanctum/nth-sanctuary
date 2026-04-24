local item, super = Class("brokenswd", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Fess up. Who got scammed?"
    })
end

return item