local item, super = Class("bittertear", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "So... it's water."
    })
end

return item