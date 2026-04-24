local item, super = Class("revivemint", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		susie = {
            susie = "I'm ALIVE!!!",
            ralsei = "(You weren't dead)",
			jamm = "(Not with that attitude, Ralsei.)"
        },
        jamm = "And we used it here, why?"
    })
end

return item