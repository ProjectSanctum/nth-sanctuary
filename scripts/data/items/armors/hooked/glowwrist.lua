local item, super = Class("glowwrist", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "I think Marcy would like this..."
    })
end

return item