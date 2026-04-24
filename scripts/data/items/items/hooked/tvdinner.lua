local item, super = Class("tvdinner", true)

function item:init()
    super.init(self)

    self.reaction_variants[1].jamm = "What flavor is this? I like it."
    self.reaction_variants[2].jamm = "It... TASTES like meat, at least."
    self.reaction_variants[3].jamm = "Cinnamon, nice!"
end

return item