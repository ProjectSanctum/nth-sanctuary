local item, super = Class("execbuffet", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Never liked the fancy shit..."
    })
end

return item