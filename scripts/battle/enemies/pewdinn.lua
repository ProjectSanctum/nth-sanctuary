local Pewdinn, super = Class(EnemyBattler)

function Pewdinn:init()
    super.init(self)

    -- Enemy name
    self.name = "Pewdinn"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("pewdinn")

    -- Enemy health
    self.max_health = 550
    self.health = 550
    -- Enemy attack (determines bullet damage)
    self.attack = 12.5
    -- Enemy defense (usually 0)
    self.defense = 0
    -- Enemy reward
    self.money = 100

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 20

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "pewdinn/pews",
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "Glory to Shade!",
        "Long Prosper!",
        "Confess.",
        "Pray and kneel.",
        "Listen to the sermon.",
        
        
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 15 DF 0\n* The fire to their head is more than \njust cosmetic."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* Pewdinn creaks softly.",
        "* Smells like old wood.",
        "* Flames crackle around Pewdinn's hand.",
        "* Pewdinn puts a hymnal on its back.",
        
    }
    self.dialogue_mercy = {
        "[wave]Ooooh! I feel divine!",
        "[wave]Consider me blessed!",
        "[wave]You make my flames flicker.",     
        "[wave]Now that was a sermon..." 
    }
 
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* Pewdinn's flame is weak."

    -- Register act called "Smile"
    self:registerAct("Smile")
    -- Register party act with Ralsei called "Tell Story"
    -- (second argument is description, usually empty)
    self:registerAct("FanFlame", "60% &\nHeat up", {"ralsei"})
    self:registerAct("CharcoalShot", "50%\nHeat & \nHurt", {"jamm"})
    self:registerAct("BlowOut", "40% &\nPiss off", {"susie"})
    if #Game.battle.party > 1 then
        self:registerAct("XFan", "Spare\nall", "all", 64)
    end
    
    self.atkup = false
    self.charcoaled = false
end

function Pewdinn:onSpareable()
    super.onSpareable(self)
    self:setAnimation("spare")
end

function Pewdinn:getEnemyDialogue()
    if self.dialogue_override then
        local dialogue = self.dialogue_override
        self.dialogue_override = nil
        return dialogue
    end

    if self.mercy >= 100 then
        return TableUtils.pick(self.dialogue_mercy)
    end

    return TableUtils.pick(self.dialogue)
end

function Pewdinn:getNextWaves()
    local waves = super.getNextWaves(self)

    local shared = {
        ["pewdinn/pews"] = true,
    }
    local first_enemy = nil
    for _, enemy in ipairs(Game.battle.enemies) do
        if enemy.health > 0 then
            first_enemy = enemy
            break
        end
    end
    
    local filter = {}

    for _, wave in ipairs(waves) do
        if shared[wave] then
            if self == first_enemy then
                table.insert(filter, wave)
            end
        else
            table.insert(filter, wave)
        end
    end

    return filter
end

function Pewdinn:onAct(battler, name)
    if name == "Smile" then
        -- Give the enemy 100% mercy
        self:addMercy(100)
        -- Change this enemy's dialogue for 1 turn
        self.dialogue_override = "... ^^"
        -- Act text (since it's a list, multiple textboxes)
        return {
            "* You smile.[wait:5]\n* The dummy smiles back.",
            "* It seems the dummy just wanted\nto see you happy."
        }

    elseif name == "FanFlame" then
        -- Loop through all enemies
        self:addMercy(60)
        Game.battle:startActCutscene(function(cutscene)
            self:statusMessage("damage", "+5", {1, 0.25, 0})
            self.attack = self.attack + 5
			Game.battle.timer:tween(1, Game.battle.encounter, {heat_wave_mag_bg = Game.battle.encounter.heat_wave_mag_bg + 2})
			Game.battle.encounter.heat_wave_mag = Game.battle.encounter.heat_wave_mag + 2
            self.atkup = true
            self.charcoaled = true
            self:setAnimation("fire")
            self:flash()
			Game.battle.timer:script(function(wait)
				Assets.playSound("board_bomb")
				Assets.playSound("board_torch", 1, 1)
				wait(4/30)
				Assets.playSound("board_torch", 1, 1.2)
				wait(4/30)
				Assets.playSound("board_torch", 1, 1)
				wait(4/30)
				Assets.playSound("board_torch", 1, 0.8)
			end)
            cutscene:text("* You and Ralsei fanned Pewdinn's flames!\n* The flame burned brighter!")
            self.dialogue_override = "[shake:1]Ooooh, that's hot!"
        end)
        return 

    elseif name == "Standard" then --X-Action
        -- Give the enemy 50% mercy
        self:addMercy(50)
        if battler.chara.id == "ralsei" then
            Game.battle.timer:tween(1, Game.battle.encounter, {heat_wave_mag_bg = Game.battle.encounter.heat_wave_mag_bg + 1})
			Game.battle.encounter.heat_wave_mag = Game.battle.encounter.heat_wave_mag + 1
            -- R-Action text
            return "* Ralsei bowed politely.\n* The dummy spiritually bowed\nin return."
        elseif battler.chara.id == "susie" then
            -- S-Action: start a cutscene (see scripts/battle/cutscenes/dummy.lua)
            Game.battle:startActCutscene("dummy", "susie_punch")
            return
        else
            -- Text for any other character (like Noelle)
            return "* "..battler.chara:getName().." straightened the\ndummy's hat."
        end
    elseif name == "CharcoalShot" then
        Game.battle:startActCutscene(function (cutscene, battler)
            local char = Game.battle:getPartyBattler("jamm")
            char:setAnimation("battle/attackready")
            cutscene:text("* Jamm slung a piece of charcoal!")
            char:setAnimation("battle/attack")
            cutscene:wait(cutscene:playSound("criticalswing"))
            self:addMercy(50)
            self:hurt(80)
            Assets.playSound("damage")
            self:statusMessage("damage", "+5", {1, 0.25, 0})
            self:setAnimation("fire")
            self:getActiveSprite():flash()
			Game.battle.timer:script(function(wait)
				Assets.playSound("board_bomb")
				Assets.playSound("board_torch", 1, 1)
				wait(4/30)
				Assets.playSound("board_torch", 1, 1.2)
				wait(4/30)
				Assets.playSound("board_torch", 1, 1)
				wait(4/30)
				Assets.playSound("board_torch", 1, 0.8)
			end)
			Game.battle.timer:tween(1, Game.battle.encounter, {heat_wave_mag_bg = Game.battle.encounter.heat_wave_mag_bg + 2})
			Game.battle.encounter.heat_wave_mag = Game.battle.encounter.heat_wave_mag + 2
            cutscene:text("* Pewdinn's ATTACK rose from the charcoal!")
            self.attack = self.attack + 5
            self.atkup = true
            self.charcoaled = true
        end)
    elseif name == "BlowOut" then
        self:addMercy(40)
        return "* Susie blew at Pewdinn's flames!"
    elseif name == "XFan" then
        for _, enemy in ipairs(Game.battle.enemies) do
            enemy:spare()
        end
        return "* Everybody fanned the enemies!"
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

function Pewdinn:onTurnStart()
    if self.charcoaled then
        if self:canSpare() then
            self:setAnimation("spared")
        else
            self:resetSprite()
        end
    end
    if self.atkup then
        self.atkup = false
        self.charcoaled = false
        self:statusMessage("damage", "-5", {1, 0.25, 0})
        self.attack = self.attack - 5
		Game.battle.timer:tween(0.5, Game.battle.encounter, {heat_wave_mag_bg = math.max(Game.battle.encounter.heat_wave_mag_bg - 1, 0)})
		Game.battle.encounter.heat_wave_mag = math.max(Game.battle.encounter.heat_wave_mag - 1, 0)
		Game.battle.encounter.apply_heatfx_to_bullets = false
    end
end

return Pewdinn