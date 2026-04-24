local item, super = Class("deluxedinner", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "I always hated the accessories."
    })
end

return item