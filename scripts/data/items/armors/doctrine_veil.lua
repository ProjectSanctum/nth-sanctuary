local item, super = Class(Item, "doctrine_veil")

function item:init()
    super.init(self)

    -- Display name
    self.name = "DoctrineVeil"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = "No\nvalue"
    -- Menu description
    self.description = "Wearer cannot give MERCY. +5DF"

    -- Default shop price (sell price is halved)
    self.price = 0
    -- Whether the item can be sold
    self.can_sell = false

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
        defense = 5,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = ""
    self.bonus_icon = "ui/menu/icon/up"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        noelle = true,
        ralsei = false,
        kris = false,
        susie = false,
        jamm = false,
        lobby_man = false,
    }

    -- Character reactions
    self.reactions = {
        susie = "Are we going to a funeral?",
        ralsei = "...",
        jamm = "No thanks.",
        lobby_man = "It's for you, Noelle.",
        noelle = {
            lobby_man = "Good."
        }
    }
end

function item:getBonusName()
    if love.math.random(1, 3) ~= 3 then
        self.bonus_icon = "ui/menu/icon/up"
        return "Trance UP"
    else
        self.bonus_icon = nil
        return "Conduit"
    end
end

return item