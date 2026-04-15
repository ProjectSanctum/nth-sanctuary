local item, super = Class(Item, "cruelaxe")

function item:init()
    super.init(self)

    -- Display name
    self.name = "CruelAxe"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/axe"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A jelly-like, but solid red axe. It has no special powers, but it looks really crool."

    self.bonus_name = "???"
    self.bonus_icon = "ui/menu/icon/jellycruel"

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
        attack = 12,
    }
    -- Bonus name and icon (displayed in equip menu)
        -- Bonus name and icon (displayed in equip menu)

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        susie = true,
    }

    -- Character reactions
    self.reactions = {
        susie = "Hell yeah!",
        ralsei = "Too cruel for me...",
        noelle = "I guess it's kind of cute in a weird way?",
        jamm = "I'm not a cruel guy..."
    }
end

function item:getDescription()
    return Game:getFlag("fun") == 94 and "A jelly-like, but solid red axe. It has no special powers, but it looks really k rool." 
    or self.description
end

function item:onAttackHit(battler, enemy, damage)
    if damage <= 0 then return end
    for i = 1, 5 do
        local hit = CruelAxeHit("jellycruel/jellycruel",enemy.x, enemy.y)
        hit.layer = enemy.layer + 100
        hit.x = enemy.x + math.random(-enemy.width/2, enemy.width/2)
        Game.battle:addChild(hit)
    end
end

return item