local item, super = Class(HealItem, "jamm_tea")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Jamm Tea"
    -- Name displayed when used in battle (optional)
    self.use_name = nil

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Healing\nvaries"
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "It's own-flavored tea.\nThe flavor just says \"Jamm.\""
    -- Amount healed (HealItem variable)
    self.heal_amount = 50
    self.heal_amounts = {
        ["kris"] = 40,
        ["susie"] = 100,
        ["ralsei"] = 70,
        ["noelle"] = 60,
        ["jamm"] = 80,
    }

    -- Default shop price (sell price is halved)
    self.price = 10
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
            susie = "(What's with that look...?)",
            ralsei = "(They don't like it?)",
			jamm = "(Why are they staring at me like that?)",
		},
		susie = {
            susie = "Hell yeah, root beer!!",
            ralsei = "Don't drink so fast!!",
			jamm = "Chug! Chug! Chug!"
		},
		ralsei = {
            susie = "Huh, really?",
            ralsei = "Tastes like blackberries!",
			jamm = "(What's a blackberry taste like?)",
		},
		noelle = {
            noelle = "Tastes like... Peppermint!",
			jamm = "Fair enough.",
		},
		jamm = {
            susie = "It tastes like color?! Gimme some!",
			jamm = "Orange flavored. Neat.",
		},
    }
end

function item:getBattleHealAmount(id)
    -- Dont heal less than 40HP in battles
    return math.max(40, super.getBattleHealAmount(self, id))
end

return item
