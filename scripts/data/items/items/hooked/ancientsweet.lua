local item, super = Class("ancientsweet", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Didn't age like wine..."
    })
end

return item