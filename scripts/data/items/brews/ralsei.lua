local item, super = Class(HealItem, "brews/ralsei")

function item:init()
    super.init(self)

    -- Display name
    self.name = "RalseiBrew"
    -- Name displayed when used in battle (optional)
    self.use_name = nil

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Healing\nvaries"
    -- Shop description
    self.shop = "Ralsei flavor\n\nHealing \n             varies"
    -- Menu description
    self.description = "It's own-flavored beverage.\nThe flavor just says \"Ralsei.\""

    -- Amount healed (HealItem variable)
    self.heal_amount = 50
    -- Amount this item heals for specific characters
    self.heal_amounts = {
        ["kris"] = 130,
        ["susie"] = 120,
        ["ralsei"] = 120,
        ["noelle"] = 80,
        ["lobby_man"] = 1,
        ["jamm"] = 80
    }

    -- Default shop price (sell price is halved)
    self.price = 600
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {}
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = {
            susie = "This tastes like cake!",
            ralsei = "Aww, Susie!"
        },
        ralsei = {
            ralsei = "Hot cocoa!",
            susie = "Chug! Chug! Chug!"
        },
        noelle = "Slightly sweet...",
        lobby_man = "Flavorless.",
        jamm = {
            jamm = "Thick and creamy."
        }
    }
end

function item:getBattleHealAmount(id)
    return math.max(40, super.getBattleHealAmount(self, id))
end

return item