local item, super = Class("scarfmark", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "...What?"
    })
end

return item