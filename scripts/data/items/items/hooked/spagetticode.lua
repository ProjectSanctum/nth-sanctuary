local item, super = Class("spagetticode", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "We call this WET."
    })
end

return item