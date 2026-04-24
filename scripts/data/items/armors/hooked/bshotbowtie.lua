local item, super = Class("bshotbowtie", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "So, how do I look?"
    })
end

return item