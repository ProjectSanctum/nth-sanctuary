local item, super = Class("ironshackle", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Huh??? You're restraining me???"
    })
end

return item