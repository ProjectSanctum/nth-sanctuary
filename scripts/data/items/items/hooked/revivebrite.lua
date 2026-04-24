local item, super = Class("revivebrite", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
        jamm = "Mints aren't my favorite, but..."
    })
end

return item