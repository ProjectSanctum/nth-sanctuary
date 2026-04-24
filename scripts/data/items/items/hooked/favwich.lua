local item, super = Class("favwich", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "IT'S JUST SO GOOD!"
    })
end

return item