local item, super = Class(Item, "lancercon")

function item:init()
    super.init(self)

    -- Display name
    self.name = "LancerCon"
    -- Name displayed when used in battle (optional)
    self.use_name = nil

    -- Item type (item, key, weapon, armor)
    self.type = "key"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Lancer's controller. It's covered in dirt."
    -- Menu description if there's multiple controllers
    self.description_multi = "Lancer's controllers. They're covered in dirt."

    -- Default shop price (sell price is halved)
    self.price = 0
    -- Whether the item can be sold
    self.can_sell = false

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "none"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "none"
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
    self.reactions = {}
end

function item:getCollected()
    return Game:getFlag("lancer_controllers", 0)
end

function item:getName()
    if self:getCollected() > 1 then
        return self.name .. "X" .. self:getCollected()
    end
    return self.name
end

function item:getDescription()
    if self:getCollected() > 1 then
        return self.description_multi
    end
    return self.description
end

return item