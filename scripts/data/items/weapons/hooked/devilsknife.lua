local item, super = Class("devilsknife", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Hey, I'm not a farmer!"
    })
end

return item