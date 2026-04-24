local item, super = Class("puppetscarf", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "It feels weird..."
    })
end

return item