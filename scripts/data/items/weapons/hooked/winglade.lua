local item, super = Class("winglade", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "It's... an enemy...?"
    })
end

return item