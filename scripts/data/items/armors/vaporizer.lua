local item, super = Class(Item, "vaporizer")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Vaporizer"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = "Glowing\nBracelet"
    -- Menu description
    self.description = "A light beaded bracelet that shines with the glow of a sunset."

    -- Default shop price (sell price is halved)
    self.price = 100
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

    self.bonus_name = "Pinkness UP"
    self.bonus_icon = "ui/menu/icon/upb"

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {
        defense = 2,
        magic = 2
    }
    -- Bonus name and icon (displayed in equip menu)

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        susie = false
    }

    -- Character reactions
    self.reactions = {
        susie = "Smells weird.",
        ralsei = "I-It's like pearls!",
        noelle = "(What if I gave this to Susie...)",
        jamm = "Marcy would like this.",
    }

    -- Character reactions to wearing two
end

return item
