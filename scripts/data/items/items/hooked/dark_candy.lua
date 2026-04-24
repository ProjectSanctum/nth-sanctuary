local item, super = Class("dark_candy", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "I'm not much of a sweet tooth. But..."
    })
end

return item