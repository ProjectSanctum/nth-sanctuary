local item, super = Class("pipis", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
        jamm = "Looks like a giant egg..."
    })
end

return item