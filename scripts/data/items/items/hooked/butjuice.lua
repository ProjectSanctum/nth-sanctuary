local item, super = Class("butjuice", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Tastes... Dignified."
    })
end

return item