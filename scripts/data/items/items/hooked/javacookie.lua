local item, super = Class("javacooke", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Better than Bedrock."
    })
end

return item