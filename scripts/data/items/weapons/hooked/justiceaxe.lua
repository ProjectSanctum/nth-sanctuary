local item, super = Class("justiceaxe", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = {
			jamm = "So you... robbed an old guy?",
			susie = "He gave it to us!!!"
		}
    })
end

return item