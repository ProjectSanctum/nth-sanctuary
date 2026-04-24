-- Create a healing item and specify its ID (id is optional, defaults to file path)
local item, super = Class(HealItem, "duskmoss")

function item:init()
    super.init(self)

    -- Display name
    self.name = "DuskMoss"
    -- Name displayed when used in battle (optional)
    self.use_name = nil

    -- Item type (item, key, weapon, armor)
    self.type = "item"

    -- Battle description
    self.effect = "Dusks\nout\nHP"
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Darkened moss. Found in the Fast Travel area.\nEarthier than normal Moss."

    -- Amount healed (HealItem variable)
    self.heal_amount = 90
    -- Amount healed for anyone other than Kris
    self.heal_amount_other = 0

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
        susie = "Not as good, but I'll take it.",
        ralsei = "Oh... Kris, you shouldn't have...",
		jamm = "I mean, if you insist...",
    }
end

function item:getHealAmount(id)
    if id == "kris" or id == "susie" then
        return self.heal_amount
    else
        return self.heal_amount_other
    end
end

function item:onBattleUse(user, target)
    super.onBattleUse(target)

    -- Heal Kris too when used on Noelle
    target.chara:addStatBuff("defense", 10)
    target:statusMessage("damage", "+10", {0.6,0.6,1})
    local amount = self:getBattleHealAmountModified(target.chara.id, user.chara)
    target:heal(amount)
end

function item:getBattleText(user, target)
   if user.chara == target.chara then
        return "* "..user.chara:getName().." ate the DuskMoss!\n* Defense increased!"
   else
        return "* "..user.chara:getName().." gave the DuskMoss to "..target.chara:getName().."!\n* "..target.chara:getName().."'s Defense increased!"
   end
end

return item