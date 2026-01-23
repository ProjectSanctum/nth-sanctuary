local Waferr, super = Class(EnemyBattler)

function Waferr:init()
    super.init(self)

    -- Enemy name
    self.name = "Waferr"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("waferr")

    -- Enemy health
    self.max_health = 1000
    self.health = 1000
    -- Enemy attack (determines bullet damage)
    self.attack = 17
    -- Enemy defense (usually 0)
    self.defense = 30
    -- Enemy reward
    self.money = 100

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 20

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "liieng/fireorbs",
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "..."
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "A restless spirit known to appear when salvation is at its lowest."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* Liieng gazes into your eyes.",
        "* Smells like...[wait:5] like?",
        "* Liieng's mandibles twitch.",
        "* Liieng emits a ghastly wail."
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* Liieng looks battered."

    -- Register act called "Smile"
    self:registerAct("Smile")
    -- Register party act with Ralsei called "Tell Story"
    -- (second argument is description, usually empty)
    self:getAct("Check").description = "Useless\nanalysis"
    self.sprite.active = false

    local i = 1
    for _, enemy in ipairs(Game.battle:getActiveEnemies()) do
        if enemy.id == self.id then
            self.sprite.siner = (i + 1) * 100
            self.sprite.siner_2 = i * 33
            i = i + 1
        end
    end
end

function Waferr:update()
    super.update(self)

    if self.mercy >= 100 then
		self:setAnimation("spared")
	else
		self:setAnimation("idle")
	end

    if Game.battle.state ~= "TRANSITION" and Game.battle.state ~= "INTRO" then
        self.sprite.active = true
        self.sprite.x = (math.sin(self.sprite.siner_2 / 1.5)) * 3
    end
end

function Waferr:onAct(battler, name)
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

    elseif name == "Tell Story" then
        -- Loop through all enemies
        for _, enemy in ipairs(Game.battle.enemies) do
            -- Make the enemy tired
            enemy:setTired(true)
        end
        return "* You and Ralsei told the dummy\na bedtime story.\n* The enemies became [color:blue]TIRED[color:reset]..."

    elseif name == "Standard" then --X-Action
        -- Give the enemy 50% mercy
        self:addMercy(50)
        if battler.chara.id == "ralsei" then
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
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

return Waferr