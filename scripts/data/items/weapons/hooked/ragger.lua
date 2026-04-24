local item, super = Class("ragger", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Like a rose's thorn..."
    })
end

return item