local item, super = Class("rouxlsroux", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Huh. Roux... Not bad."
    })
end

return item