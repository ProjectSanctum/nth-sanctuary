local item, super = Class("jingleblade", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = {
			jamm = "I know Susie'd try to eat this.",
			susie = "Very funny, Jamm..."
		}
    })
end

return item