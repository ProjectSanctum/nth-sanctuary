local item, super = Class("blackshard", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "...And you got this from the Knight?"
    })
end

return item