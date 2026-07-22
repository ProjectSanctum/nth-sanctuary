local item, super = Class(Item, "radiaxe")

function item:init()
    super.init(self)

    -- Display name
    self.name = "RadiAxe"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/axe"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "An axe that glows an assortment of radiant colors... Or is it just green?"

    self.bonus_name = nil
    self.bonus_icon = nil

    -- Default shop price (sell price is halved)
    self.price = 250
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "none"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {
        attack = 14,
    }
    -- Bonus name and icon (displayed in equip menu)
        -- Bonus name and icon (displayed in equip menu)

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        susie = true,
    }

    -- Character reactions
    self.reactions = {
        susie = "Hey, it's Ralsei-colored.",
        ralsei = "The colors are so pretty!",
        noelle = "(Is this meant to be a sign?)",
        jamm = "That stuff seeps through my gloves."
    }
end

return item