local item, super = Class(HealItem, "cheesecake")

function item:init()
    super.init(self)

    self.name = "CheeseCake"

    self.type = "item"
    self.icon = nil

    self.effect = "Healing\nvaries"
    self.shop = ""
    self.description = "A steady and nice cheesecake.\nDespite the fact that it's quite old."
    
    self.price = 6
    self.can_sell = nil

    self.target = "ally"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {}
    self.bonus_name = nil
    self.bonus_icon = nil

    self.can_equip = {}
    self.reactions = {
        susie = "Well thats... Cheesy.",
        ralsei = "A bit savory, but nice!",
    }
end

function item:getDescription()
    if math.random() <= 0.2 then
        return "A steady and nice cheesecake.\nDespite the fact that it's quite [color:green]old.[color:reset]"
    end
    return self.description
end

function item:onWorldUse(target)
    Game.world:heal(target, math.ceil(target:getHealth() / 3))
    return true
end

function item:onBattleUse(user, target)
    local heal_amount
    if target.chara:getHealth() <= 0 then
        heal_amount = math.ceil(target.chara:getStat("health") / 3)
    else
        heal_amount = math.ceil(target.chara:getHealth() / 3)
    end
    target:heal(Game.battle:applyHealBonuses(heal_amount, user.chara))
end

return item
