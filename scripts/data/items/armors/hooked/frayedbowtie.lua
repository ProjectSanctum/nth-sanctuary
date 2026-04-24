local item, super = Class("frayedbowtie", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Ehh... Okay...?"
    })
end

return item