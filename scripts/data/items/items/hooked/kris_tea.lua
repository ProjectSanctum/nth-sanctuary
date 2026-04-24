local item, super = Class("kris_tea", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		kris = {
            susie = "(No reaction?)",
            noelle = "(... no reaction?)",
			jamm = "(What, nothing?)"
        },
        susie = {
            susie = "Hell yeah, apple juice!!",
            ralsei = "Don't drink so fast!!",
			jamm = "Chug! Chug! Chug!"
        },
        ralsei = {
            ralsei = "Tastes like blueberries!",
            susie = "Huh? Really?",
			jamm = "That... oddly makes sense."
        },
		jamm = {
			jamm = "It tastes of pain...",
			susie = "The hell does that mean???",
			ralsei = "I... see..."
		}
    })

    self.heal_amounts = TableUtils.merge(self.heal_amounts, {
		jamm = 80
    })
end

return item