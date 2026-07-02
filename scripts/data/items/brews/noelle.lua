local item, super = Class(HealItem, "brews/noelle")

function item:init()
    super.init(self)

    -- Display name
    self.name = "NoelleBrew"
    -- Name displayed when used in battle (optional)
    self.use_name = nil

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Healing\nvaries"
    -- Shop description
    self.shop = "Noelle flavor\n\nHealing \n             varies"
    -- Menu description
    self.description = "It's own-flavored beverage.\nThe flavor just says \"Noelle.\""

    -- Amount healed (HealItem variable)
    self.heal_amount = 50
    -- Amount this item heals for specific characters
    self.heal_amounts = {
        ["kris"] = 145,
        ["susie"] = 400,
        ["ralsei"] = 100,
        ["noelle"] = 100,
        ["lobby_man"] = 125,
        ["jamm"] = 100
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
        kris = {},
        susie = {
            susie = "Seconds, quick!"
        },
        ralsei = {
            ralsei = "It",
        },
        noelle = "It's like a smoothie...",
        lobby_man = "Mmm.",
        jamm = {
            jamm = "Pumpkin spice!",
            susie = "Chug! Chug! Chug!"
        }
    }
end

function item:getReactions()
    if Mod:isWeird() then
        self.reactions.kris = {
            susie = "Is it that bad? Haha!",
            ralsei = "(Why did they shudder?)",
            noelle = "...",
        }
    end
    return self.reactions
end

function item:getBattleHealAmount(id)
    -- Dont heal less than 40HP in battles
    if id == "kris" and Mod:isWeird() then
        return 0
    end
    return math.max(40, super.getBattleHealAmount(self, id))
end

function HealItem:getHealAmount(id)
    if id == "kris" and Mod:isWeird() then
        return 0
    end
    return self.heal_amounts[id] or self.heal_amount
end
return item