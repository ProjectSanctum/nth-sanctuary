local item, super = Class(HealItem, "brews/lobby_man")

function item:init()
    super.init(self)

    -- Display name
    self.name = "????Brew"
    -- Name displayed when used in battle (optional)
    self.use_name = nil

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Healing\nvaries"
    -- Shop description
    self.shop = "Try your luck.\n\nHealing \n             varies"
    -- Menu description
    self.description = "It's own-flavored beverage.\nThe flavor is scratched out.\""

    -- Amount healed (HealItem variable)
    self.heal_amount = 50
    -- Amount this item heals for specific characters
    self.heal_amounts = {
        ["kris"] = 10,
        ["susie"] = 10,
        ["ralsei"] = 10,
        ["noelle"] = 10,
        ["lobby_man"] = 100,
        ["jamm"] = 10
    }

    -- Default shop price (sell price is halved)
    self.price = 300
    -- Whether the item can be sold
    self.can_sell = false

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
            susie = "...Ew.",
        },
        ralsei = {
            ralsei = "(Oh...)",
        },
        noelle = "(It's bad.. But I like it?)",
        lobby_man = "Classic morning coffee.",
        jamm = {
            jamm = "It's practically cheese."
        }
    }
end

function item:getBattleHealAmount(id)
    -- Dont heal less than 40HP in battles
    if id == "noelle" and Mod:isWeird() then
        local flag = Game:getFlag("indoct-con")
        return 170
    end
    return math.max(40, super.getBattleHealAmount(self, id))
end

function HealItem:getHealAmount(id)
    if id == "noelle" and Mod:isWeird() then
        local flag = Game:getFlag("indoct-con", 0)
        return 50 + (25 * (flag))
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