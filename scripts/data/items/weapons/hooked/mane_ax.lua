local item, super = Class("mane_ax", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "I mean, I'm not THAT strong..."
    })
end

return item