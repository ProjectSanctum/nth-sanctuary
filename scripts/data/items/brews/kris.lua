local item, super = Class(HealItem, "brews/kris")

function item:init()
    super.init(self)

    -- Display name
    self.name = "KrisBrew"
    -- Name displayed when used in battle (optional)
    self.use_name = nil

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Healing\nvaries"
    -- Shop description
    self.shop = "Kris flavor\n\nHealing \n             varies"
    -- Menu description
    self.description = "It's own-flavored beverage.\nThe flavor just says \"Kris.\""

    -- Amount healed (HealItem variable)
    self.heal_amount = 50
    -- Amount this item heals for specific characters
    self.heal_amounts = {
        ["kris"] = 30,
        ["susie"] = 150,
        ["ralsei"] = 130,
        ["noelle"] = 80,
        ["lobby_man"] = 5,
        ["jamm"] = 90
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
        kris = {
            susie = "(No reaction?)",
            ralsei = "(No reaction...)",
            noelle = "(... no reaction?)"
        },
        susie = {
            susie = "Tastes like apple pie.",
            ralsei = "D-Don't bite the glass."
        },
        ralsei = {
            ralsei = "Golden Flower and honey...",
        },
        noelle = "GIngerbread...",
        lobby_man = "Stale.",
        jamm = {
            jamm = "A little bland?"
        }
    }
end

function item:getBattleHealAmount(id)
    -- Dont heal less than 40HP in battles
    if id == "noelle" and Mod:isWeird() then
        return 170
    end
    return math.max(40, super.getBattleHealAmount(self, id))
end

function HealItem:getHealAmount(id)
    if id == "noelle" and Mod:isWeird() then
        return 170
    end
    return self.heal_amounts[id] or self.heal_amount
end

function item:getReactions()
    if Mod:isWeird() then
        self.reactions.noelle = "..."
    end
    return self.reactions
end

function item:getReaction(user_id, reactor_id)
    return super.getReaction(self, user_id, reactor_id)
end

return item