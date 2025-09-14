local Guei, super = Class(EnemyBattler)

function Guei:init()
    super.init(self)

    -- Enemy name
    self.name = "Guei"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("guei")
	self:setAnimation("idle")

    
    -- Enemy health
    self.max_health = 470
    self.health = 470
    -- Enemy attack (determines bullet damage)
    self.attack = 13
    -- Enemy defense (usually 0)
    self.defense = 0
    -- Enemy reward
    self.money = 100

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    --self.spare_points = 20
    self.spareable_text = "* Guei looks satisfied in some odd way."

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "holyfire",
        "clawdrop"
    }

	self.dialogue = { "..." }
    self.dialogue_offset = { 0, -48 }

    self.excerism = false
    self.balloon_type = 0

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "A strange spirit said to appear when the moon waxes."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* Guei turns its head like a bird.",
        "* Guei rattles its claws.",
        "* Guei wags its tail.",
        "* Guei howls hauntingly."
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* Guei's flames flicker weakly."

    -- Register act called "Smile"
    self:getAct("Check").description = "Useless\nanalysis"
    self:registerAct("Exercism", "20% &\nDelayed\nTIRED")
    -- Register party act with Ralsei called "Tell Story"
    -- (second argument is description, usually empty)
    self:registerAct("Xercism", "60% &\nDelayed\nTIRED", {"ralsei"})
end

function Guei:onAct(battler, name)
    if name == "Exercism" then
        -- Give the enemy 100% mercy
        self:addMercy(20)
        -- Change this enemy's dialogue for 1 turn
        --self.dialogue_override = "... ^^"
        -- Act text (since it's a list, multiple textboxes)
        self.excerism = true
        return {
            "* You started the exercism!\nYou encouraged Guei to exercise!"
        }

    elseif name == "Xercism" then
        -- Loop through all enemies
        --for _, enemy in ipairs(Game.battle.enemies) do
        --    -- Make the enemy tired
        --    enemy:setTired(true)
        --end
        self.excerism = true
        self:addMercy(60)
        return "* Everyone encouraged Guei to exercise!"

    elseif name == "Standard" then --X-Action
        -- Give the enemy 50% mercy
        if battler.chara.id == "ralsei" then
            -- R-Action text
            self:addMercy(40)
            local s = {
                "* Ralsei quoted a holy book!",
                "* Ralsei told a family-friendly story about a lovable yet lonely ghost!"
            }
            local choice = Utils.pick(s)
            return choice
        elseif battler.chara.id == "susie" then
            -- S-Action: start a cutscene (see scripts/battle/cutscenes/dummy.lua)
            self:addMercy(40)
            local s = {
            "* Susie told a story about the living dead!",
            "* Susie told a ghost story!"
            }
            local choice = Utils.pick(s)
            return choice
        else
            -- Text for any other character (like Noelle)
            self:addMercy(40)
            local s = {
                "* "..battler.chara:getName().." lit an incense stick!",
                "* "..battler.chara:getName().." did something mysterious!",
                "* "..battler.chara:getName().." said a prayer!",
                "* "..battler.chara:getName().." made a ghastly sound!"
            }
            local choice = Utils.pick(s)
            return choice
        end
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

function Guei:getEncounterText()
    for _,v in ipairs(Game.battle.enemies) do
		if v.tired then
			if Game.tension >= 16 then
				if Game:hasPartyMember("jamm") then
					return "* Guei looks [color:blue]TIRED[color:reset]. Try using Ralsei's [color:blue]PACIFY[color:reset] or Jamm's [color:blue]NUMBSHOT[color:reset]!"
				else
					return "* Guei looks [color:blue]TIRED[color:reset]. Perhaps Ralsei's MAGIC, [color:blue]PACIFY[color:reset] would be effective..."
				end
			else
				if Game:hasPartyMember("jamm") then
					return "* Guei looks [color:blue]TIRED[color:reset]. [color:yellow]DEFEND[color:reset] to gain [color:yellow]TP[color:reset], then try Ralsei's [color:blue]PACIFY[color:reset] or Jamm's [color:blue]NUMBSHOT[color:reset]!"
				else
					return "* Guei looks [color:blue]TIRED[color:reset]. [color:yellow]DEFEND[color:reset] to gain [color:yellow]TP[color:reset], then try Ralsei's MAGIC, [color:blue]PACIFY[color:reset]...!"
				end
			end
		end
	end
    if self.low_health_text and self.health <= (self.max_health * self.low_health_percentage) then
        return self.low_health_text

    elseif self.tired_text and self.tired then
        return self.tired_text

    elseif self.spareable_text and self:canSpare() then
        return self.spareable_text
    end
	if love.math.random(0, 100) < 3 then
		return "* Smells like teens.\n* Smells like spirits."
	else
		local text = super.getEncounterText(self)
		return text
	end
end

function Guei:spawnSpeechBubble(...)
    if self.excerism then
        self.balloon_type = 7
    else
        self.balloon_type = Utils.pick{1, 2, 3, 4, 5, 6}
    end

    local x, y = self.sprite:getRelativePos(0, self.sprite.height/2, Game.battle)
    if self.dialogue_offset then
        x, y = x + self.dialogue_offset[1], y + self.dialogue_offset[2]
    end
    local textbox = GueiTextbox(x, y, self.balloon_type)
    Game.battle:addChild(textbox)
    return textbox
end

function Guei:onTurnEnd()
    if self.excerism then
		self:setTired(true)
    end
end

return Guei