local item, super = Class("cheerscarf", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "I never was a good cheerleader..."
    })
end

return item