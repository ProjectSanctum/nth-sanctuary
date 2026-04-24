local item, super = Class("noelle_tea", true)

function item:init()
    super.init(self)
	
	self.heal_amounts = TableUtils.merge(self.heal_amounts, {
		jamm = 80
	})

    self.reactions = TableUtils.merge(self.reactions, {
		kris = {
            susie = "(... do they like it?)",
            ralsei = "(They're drinking it...)",
            noelle = "(Umm, do they like it or not...?)",
			jamm = "(What does that look mean...?)"
        },
        susie = {
            susie = "Hell yeah, eggnog!!",
            ralsei = "D-don't drink so fast!",
			jamm = "Chug! Chug! Chug!"
        },
        jamm = {
			jamm = "Tastes like hot cocoa... I like it."
			susie = "Hot cocoa!? Give me some!"
		},
    })
end

return item