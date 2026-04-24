local character, super = Class(PartyMember, "jamm")

function character:init()
    super.init(self)

    self.name = "Jamm"

    self:setActor("jamm")
    self:setLightActor("jamm_lw")
    self:setDarkTransitionActor("jamm_dark_transition")

    self.level = Game.chapter
    self.title = "Slingshotter\nTakes aim, then\nfires."

    self.soul_priority = 1
    self.soul_color = {1, 106/255, 0}

    self.has_act = false
    self.has_spells = true

    self.has_xact = true
    self.xact_name = "J-Action"
	
    self.lw_portrait = "face/jamm/neutral"

    self:addSpell("darksling")
    self:addSpell("numbshot")

    self.health = 215
    self.stats = {
        health = 215,
        attack = 15,
        defense = 4,
        magic = 7
    }

    self.weapon_icon = "ui/menu/equip/sling"

    self:setWeapon("basic_sling")

    self.lw_weapon_default = "light/rope_sling"
    self.lw_armor_default = "light/bandage"

    self.color = {1, 1, 0}
    self.dmg_color = nil
    self.attack_bar_color = {0.5, 0.5, 0}
    self.attack_box_color = {127/255, 106/255, 0}
    self.xact_color = nil
	-- highlight color A
    self.highlight_color = ColorUtils.hexToRGB("#7F6A00FF")
		-- highlight color B
    self.highlight_color_alt = ColorUtils.hexToRGB("#7F0000FF")

    self.menu_icon = "party/jamm/head"
    self.head_icons = "party/jamm/icon"
    self.name_sprite = "party/jamm/name"
	
	if Game:getFlag("marcy_joined") then
		self:setActor("jammarcy")
		self:setLightActor("jammarcy_light")
		self:setDarkTransitionActor("jammarcy_dark_transition")
		self.menu_icon = "party/jamm/withmarcy/head"
		self.head_icons = "party/jamm/withmarcy/icon"
		self.name_sprite = "party/jamm/withmarcy/name"
		self.name = "J&M"
	end

    self.attack_sprite = "effects/attack/sling"
    self.attack_sound = "sling"
    self.attack_pitch = 1

    self.battle_offset = {2, 1}
    self.head_icon_offset = {0, -3}
    self.menu_icon_offset = nil
	
	self.flee_text = {
		"[voice:jamm][facec:jamm/nervous]Nope! I'm out!"
	}
end

function character:onTurnStart(battler)
	if self.stun then
		Game.battle:pushForcedAction(battler, "SKIP")
	end
end

function character:onLevelUp(level)
    self:increaseStat("health", 2)
    if level % 10 == 0 then
        self:increaseStat("attack", 1)
    end
end

function character:onLevelUpLVLib(level)
    self:increaseStat("health", 10)
    self:increaseStat("attack", 2)
    self:increaseStat("defense", 1)
    self:increaseStat("magic", 1)
end

function character:drawPowerStat(index, x, y, menu)
    if index == 1  then
        local icon = Assets.getTexture("ui/menu/icon/demon")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Skills", x, y, 0, 0.7, 1)
        love.graphics.print("Yes", x+130, y)
        return true
    elseif index == 2 then
        local icon = Assets.getTexture("ui/menu/icon/magic")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Father", x, y)
        love.graphics.print("Yes", x+130, y, 0)
        return true
    elseif index == 3 then
        local icon = Assets.getTexture("ui/menu/icon/fire")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Guts:", x, y)

        love.graphics.draw(icon, x+90, y+6, 0, 2, 2)
        love.graphics.print("x", x+111, y)
        love.graphics.print("∞", x+122, y+3)
        
        return true
    end
end

function character:getFleeText()
	if Game:getFlag("marcy_joined") then
		return {
			"[voice:jamm][facec:jamm/nervous]Nope! I'm out!",
			"[voice:marcy][facec:marcy/frown_open]Marcy thinks we should go!"
		}
	end
	return self.flee_text
end

-- function character:getMinimemberID()
    -- if Game:getFlag("marcy_joined") then
        -- return "marcy"
    -- end
    -- return super.getMinimemberID(self)
-- end

function character:getGameOverMessage(main)
    return {
        "Hey, I believe we\ncan do this.",
        main:getName()..",[wait:5]\nlet's try again!"
    }
end

return character
