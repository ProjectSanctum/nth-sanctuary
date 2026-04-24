local item, super = Class("susie_tea", true)

function item:init()
    super.init(self)
	
	self.heal_amounts = TableUtils.merge(self.heal_amounts, {
		jamm = 70
	})

    self.reactions = TableUtils.merge(self.reactions, {
        ralsei = {
            ralsei = "It's grape juice!",
            susie = "Huh, really?",
			jamm = "I could go for some grape juice."
        },
        jamm = "Raspberry juice...?",
    })
end

return item