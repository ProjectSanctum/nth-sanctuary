local item, super = Class("blueribbon", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "GO US!"
    })
end

return item