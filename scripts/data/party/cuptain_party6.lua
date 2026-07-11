local character, super = Class(PartyMember, "cuptain_party6")

function character:init()
    super.init(self)

    -- Display name
    self.name = "Cuptain"

    -- Actor (handles sprites)
    self:setActor("cuptain_party")

    -- Display level (saved to the save file)
    self.level = 4
    -- Default title / class (saved to the save file)
    self.title = "Cuptain"

    -- Determines which character the soul comes from (higher number = higher priority)
    self.soul_priority = -1
    -- The color of this character's soul (optional, defaults to red)
    self.soul_color = {1, 0, 0}

    -- Whether the party member can act / use spells
    self.has_act = false
    self.has_spells = true

    -- Whether the party member can use their X-Action
    self.has_xact = true
    -- X-Action name (displayed in this character's spell menu)
    self.xact_name = "CUP-Action"

    -- Spells
    self:addSpell("pacify")
    self:addSpell("compel")
    --self:addSpell("blood_tax")
    

    -- Current health (saved to the save file)
    self.health = 35

    -- Base stats (saved to the save file)
    self.stats = {
        health = 35,
        attack = 1,
        defense = -20,
        magic = 30,
    }
    -- Max stats from level-ups
    
    -- Party members which will also get stronger when this character gets stronger, even if they're not in the party
    self.stronger_absent = {"kris","susie","ralsei"}

    -- Weapon icon in equip menu
    self.weapon_icon = "ui/menu/equip/none"

    -- Equipment (saved to the save file)
    self:setWeapon("empty_all")

    -- Default light world equipment item IDs (saves current equipment)
    self.lw_weapon_default = "light/pencil"
    self.lw_armor_default = "light/bandage"

    -- Character color (for action box outline and hp bar)
    self.color = {1, 54/255, 81/255}
    -- Damage color (for the number when attacking enemies) (defaults to the main color)
    self.dmg_color = {1, 54/255, 81/255}
    -- Attack bar color (for the target bar used in attack mode) (defaults to the main color)
    self.attack_bar_color = {1, 54/255, 81/255}
    -- Attack box color (for the attack area in attack mode) (defaults to darkened main color)
    self.attack_box_color = {1, 54/255, 81/255}
    -- X-Action color (for the color of X-Action menu items) (defaults to the main color)
    self.xact_color = {1, 54/255, 81/255}
	-- highlight color A
    self.highlight_color = {1, 54/255, 81/255}
		-- highlight color B
    self.highlight_color_alt = {1, 54/255, 81/255}

    -- Head icon in the equip / power menu
    self.menu_icon = "party/cuptain/head"
    -- Path to head icons used in battle
    self.head_icons = "party/cuptain/icon"
    -- Name sprite (optional)
    self.name_sprite = "party/cuptain/name"

    -- Effect shown above enemy after attacking it
    self.attack_sprite = "effects/attack/slap_r"
    -- Sound played when this character attacks
    self.attack_sound = "laz_c"
    -- Pitch of the attack sound
    self.attack_pitch = 1.15

    -- Battle position offset (optional)
    self.battle_offset = {2, 6}
    -- Head icon position offset (optional)
    self.head_icon_offset = {0, -5}
    -- Menu icon position offset (optional)
    self.menu_icon_offset = {6, 5}

    -- Message shown on gameover (optional)
    self.gameover_message = {
        "This is not\nyour fate...!",
        "Please,[wait:5]\ndon't give up!"
    }
end

function character:getTitle()
    return "LV4 Cuptain\nMarches with the\nleader to victory."
end

function character:onPowerSelect(menu)
    if MathUtils.random() <  0.5 then
        menu.cup_L = true
    else
        menu.cup_L = false
    end
end

function character:drawPowerStat(index, x, y, menu)
    if index == 1 then
        local icon = Assets.getTexture("ui/menu/icon/exclamation")
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Authority", x, y)
        love.graphics.print("5", x+140, y)
        return true
    elseif index == 2 then
        love.graphics.print("Allies", x-26, y, 0, 1, 1)
        
        local icon = Assets.getTexture("infinite")
        Draw.draw(icon, x+124, y+10, 0, 2, 2)
        return true
    elseif index == 3 then
        local icon = Assets.getTexture("ui/menu/icon/cup_R")
        if menu.cup_L then 
            icon = Assets.getTexture("ui/menu/icon/cup_L")
        end
        
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Lost", x+4, y, 0, 1, 1)
        local rec = self:getFlag("recruited") or "None?"
        love.graphics.print(rec, x+140, y, 0, 1, 1)
        
        return true
    end
end

return character