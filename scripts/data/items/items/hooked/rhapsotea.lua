local item, super = Class("rhapsotea", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Brings me back..."
    })
end

return item