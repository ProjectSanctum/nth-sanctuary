local character, super = Class(PartyMember, "lobby_man")

function character:init()
    super.init(self)

    -- Display name
    self.name = "Lobby Man"

    -- Actor (handles sprites)
    self:setActor("ralsei")

    -- Display level (saved to the save file)
    self.level = "??"
    -- Default title / class (saved to the save file)
    self.title = "???"

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
    self.xact_name = "L-Action"

    -- Spells
    self:addSpell("pacify")
    self:addSpell("heal_prayer")

    -- Current health (saved to the save file)
    self.health = 180

    -- Base stats (saved to the save file)
    self.stats = {
        health = 180,
        attack = 15,
        defense = 2,
        magic = 14,
    }
    -- Max stats from level-ups
    self.max_stats = {
        health = 210
    }
    
    -- Party members which will also get stronger when this character gets stronger, even if they're not in the party
    self.stronger_absent = {"kris","susie","ralsei"}

    -- Weapon icon in equip menu
    self.weapon_icon = "ui/menu/equip/scarf"

    -- Equipment (saved to the save file)
    self:setWeapon("red_scarf")
    if Game.chapter >= 2 then
        self:setArmor(1, "amber_card")
        self:setArmor(2, "white_ribbon")
    end

    -- Default light world equipment item IDs (saves current equipment)
    self.lw_weapon_default = "light/pencil"
    self.lw_armor_default = "light/bandage"

    -- Character color (for action box outline and hp bar)
    self.color = COLORS.white
    -- Damage color (for the number when attacking enemies) (defaults to the main color)
    self.dmg_color = COLORS.white
    -- Attack bar color (for the target bar used in attack mode) (defaults to the main color)
    self.attack_bar_color = COLORS.white
    -- Attack box color (for the attack area in attack mode) (defaults to darkened main color)
    self.attack_box_color = COLORS.white
    -- X-Action color (for the color of X-Action menu items) (defaults to the main color)
    self.xact_color = COLORS.white
	-- highlight color A
    self.highlight_color = COLORS.white
		-- highlight color B
    self.highlight_color_alt = COLORS.white

    -- Head icon in the equip / power menu
    self.menu_icon = "party/lobby_man/head"
    -- Path to head icons used in battle
    self.head_icons = "party/lobby_man/icon"
    -- Name sprite (optional)
    self.name_sprite = "party/lobby_man/name"

    -- Effect shown above enemy after attacking it
    self.attack_sprite = "effects/attack/slap_r"
    -- Sound played when this character attacks
    self.attack_sound = "laz_c"
    -- Pitch of the attack sound
    self.attack_pitch = 1.15

    -- Battle position offset (optional)
    self.battle_offset = {2, 6}
    -- Head icon position offset (optional)
    self.head_icon_offset = nil
    -- Menu icon position offset (optional)
    self.menu_icon_offset = nil

    -- Message shown on gameover (optional)
    self.gameover_message = {
        "This is not\nyour fate...!",
        "Please,[wait:5]\ndon't give up!"
    }
end

function character:getTitle()
    local prefix = "LV "..self:getLevel().." "
    local msg = ""
    if Mod:isWeird() then
        msg = "Cohort\nImbues enemies with\na Dark Will."
    else
        msg = "\"Follower\"\n???? ???? ?? ????\n???? ???? ??? ?????"--<-- "They seem to know what they are doing"
    end
    return prefix..msg 

end

function character:drawPowerStat(index, x, y, menu)
    --[[if index == 1 then
        if Game.chapter == 1 then
            -- Chapter 1 Ralsei "Kindness" stat (doggable)
            if not menu.ralsei_dog then
                local icon = Assets.getTexture("ui/menu/icon/smile")
                Draw.draw(icon, x-26, y+6, 0, 2, 2)
                love.graphics.print("Kindness", x, y)
                love.graphics.print("100", x+130, y)
            else
                local icon = Assets.getTexture("ui/menu/icon/smile_dog")
                Draw.draw(icon, x-26, y+6, 0, 2, 2)
                love.graphics.print("Dogness", x, y)
                love.graphics.print("1", x+130, y)
            end
        elseif Game.chapter == 2 then
            -- Chapter 2 Ralsei "Sweetness" stat (non-doggable)
            local icon = Assets.getTexture("ui/menu/icon/lollipop")
            Draw.draw(icon, x-26, y+6, 0, 2, 2)
            love.graphics.print("Sweetness", x, y)
            love.graphics.print("97", x+130, y)
        else
            return
        end
        return true
    elseif index == 2 then
        local icon = Assets.getTexture("ui/menu/icon/fluff")
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Fluffiness", x, y, 0, 0.8, 1)

        Draw.draw(icon, x+130, y+6, 0, 2, 2)
        -- Ralsei loses bonus fluffiness in Chapter 3
        if Game.chapter == 2 then
            Draw.draw(icon, x+150, y+6, 0, 2, 2)
        end
        return true
    elseif index == 3 then
        local icon = Assets.getTexture("ui/menu/icon/fire")
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Guts:", x, y)
        -- Ralsei has Guts (Chapter 3 only...)
        if Game.chapter == 3 then
            Draw.draw(icon, x+90, y+6, 0, 2, 2)
        end
        return true
    end]]
end

return character