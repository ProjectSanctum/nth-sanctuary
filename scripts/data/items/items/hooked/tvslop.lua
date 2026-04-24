local item, super = Class("tvslop", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
        jamm = "...School food. Yuck.",
    })
end

return item