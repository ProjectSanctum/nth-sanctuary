local item, super = Class("spookysword", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Not really my style..."
    })
end

return item