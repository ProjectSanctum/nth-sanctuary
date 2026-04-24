local item, super = Class("brave_ax", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Too shiny. Don't want to dirty it."
    })
end

return item