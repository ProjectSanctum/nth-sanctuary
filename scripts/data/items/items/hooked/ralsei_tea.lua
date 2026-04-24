local item, super = Class("ralsei_tea", true)

function item:init()
    super.init(self)
	
	self.heal_amounts = TableUtils(self.heal_amounts, {
		jamm = 90
	}

    self.reactions = TableUtils.merge(self.reactions, {
        kris = {
            susie = "(No reaction?)",
            ralsei = "(I'm happy!)",
			jamm = "(Are they enjoying it?)"
        },
        susie = {
            susie = "Hey, it's like marshmallows!!",
            ralsei = "D-don't drink so fast!!",
			jamm = "Chug! Chug! Chug!"
        },
        ralsei = {
			ralsei = "Um... isn't this water?",
			jamm = "Gotta stay hydrated."
		},
        jamm = {
			jamm = "Tastes like... cinnamon?",
			ralsei = "(I'll take it.)"
		},
    })
end

return item