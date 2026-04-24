-- Create a healing item and specify its ID (id is optional, defaults to file path)
local item, super = Class(HealItem, "zenmoss")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Zenith Moss"
    -- Name displayed when used in battle (optional)
    self.use_name = nil

    -- Item type (item, key, weapon, armor)
    self.type = "item"

    -- Battle description
    self.effect = "Ultimate\nmossing"
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "One of a kind.\nEveryone gains a boost."

    -- Amount healed (HealItem variable)
    self.heal_amount = 999
    -- Amount healed for anyone other than Kris
    self.heal_amount_other = 1

    -- Default shop price (sell price is halved)
    self.price = -50
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "party"
    -- Where this item can be used (world, battle, all, or none/nil)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "Woah...",
        ralsei = "I feel stronger...",
		jamm = "I feel... tough.",
    }
end

function item:getHealAmount(id)
    return self.heal_amount
end

function item:onWorldUse(target)
    for _,party_member in ipairs(Game.party) do
        party_member.stats.health = party_member.stats.health + 25
        Game.world:heal(party_member, 500)
    end
    return true
end
function item:onBattleUse(user, target) end

return item