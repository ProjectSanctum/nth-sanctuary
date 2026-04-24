-- Create a healing item and specify its ID (id is optional, defaults to file path)
local item, super = Class(HealItem, "moss")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Moss"
    -- Name displayed when used in battle (optional)
    self.use_name = nil

    -- Item type (item, key, weapon, armor)
    self.type = "item"

    -- Battle description
    self.effect = "Mosses\nout\nHP"
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Delectable meal.\nPart of every Kris or Susie's balanced diet."

    -- Amount healed (HealItem variable)
    self.heal_amount = 125
    -- Amount healed for anyone other than Kris
    self.heal_amount_other = 1

    -- Default shop price (sell price is halved)
    self.price = -50
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none/nil)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "Yummers",
        ralsei = "O-Oh...",
        noelle = "Ew, Kris!!",
        jamm = "Not the weirdest thing I've eaten...",
    }
end

function item:getHealAmount(id)
    if id == "kris" or id == "susie" then
        return self.heal_amount
    else
        return self.heal_amount_other
    end
end

return item