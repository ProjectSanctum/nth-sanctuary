local item, super = Class("dice_brace", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "Spells \"Memory...\""
    })
end

return item