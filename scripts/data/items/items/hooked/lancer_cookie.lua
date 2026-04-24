local item, super = Class("lancer_cookie", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "(Better keep this away from Marcy...)"
    })
end

return item