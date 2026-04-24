local item, super = Class("everybodyweapon", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Now how do I use this..."
    })
end

return item