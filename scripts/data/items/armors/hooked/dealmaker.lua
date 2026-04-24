local item, super = Class("dealmaker", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Not really a glasses guy, but..."
    })
end

return item