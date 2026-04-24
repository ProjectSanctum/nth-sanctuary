local item, super = Class("chainmail", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "I know not to respond."
    })
end

return item