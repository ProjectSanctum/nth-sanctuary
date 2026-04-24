local item, super = Class("scarlixir", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Down the hatch..."
    })
end

return item