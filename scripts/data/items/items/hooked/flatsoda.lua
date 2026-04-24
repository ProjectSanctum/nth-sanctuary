local item, super = Class("flatsoda", true)

function item:init()
    super.init(self)

    self.reactions = TableUtils.merge(self.reactions, {
		jamm = "...What? Soda is soda."
    })
end

function item:getHealAmount(id)
    if id == "jamm" then
        return 30
    else
        return self.heal_amount
    end
end

return item