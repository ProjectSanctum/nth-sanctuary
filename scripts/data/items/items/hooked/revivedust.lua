local item, super = Class("revivedust", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
        jamm = "Dust isn't my favorite, but..."
    })
end

return item