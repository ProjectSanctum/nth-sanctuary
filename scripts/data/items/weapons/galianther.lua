local item, super = Class(Item, "galianther")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Galianther"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/sword"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A strong, gray-feathered sword-sling combo.\nSlightly increases money won."

    -- Default shop price (sell price is halved)
    self.price = 0
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
        attack = 10,
		defense = 4,
    }
    -- Bonus name and icon (displayed in equip menu)
        -- Bonus name and icon (displayed in equip menu)

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        kris = true,
        jamm = true,
    }

    -- Character reactions
    self.reactions = {
        susie = "Why is the handle so damn small!?",
        ralsei = "It's very unwieldy...",
        noelle = "(Is that a shield or a guard...?)",
        jamm = "Hey, it can be used as a slingshot!"
    }
end

function item:applyMoneyBonus(gold)
    return gold * 1.1
end

return item