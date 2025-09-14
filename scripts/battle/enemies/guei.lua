local Dummy, super = Class(EnemyBattler)

function Dummy:init()
    super.init(self)

    -- Enemy name
    self.name = "Guei"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("guei")
    self.exercism_used = false

    
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

    self.dialogue_bubble = "round2"

    self.dialogue_offset = {40, 0}

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "[image:dialogueimg/1, 0,0,1,1]",
        "[image:dialogueimg/2, 0,0,1,1]",
        "[image:dialogueimg/3, 0,0,1,1]",
        "[image:dialogueimg/4, 0,0,1,1]",
        "[image:dialogueimg/5, 0,0,1,1]",
        "[image:dialogueimg/6, 0,0,1,1]",
        "[image:dialogueimg/7, 0,0,1,1]",
        
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "A strange spirit said to appear when the moon waxes."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* Guei turns its head like a bird.",
        "* Guei rattles its claws.",
        "* Guei wags its tail.",
        "* Guei howls hauntingly.",
        "* Smells like teens.\n[wait:15]* Smells like spirits."
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* Guei's flames flicker weakly."

    -- Register act called "Smile"
    self:getAct("Check").description = "Usless\nanalysis"
    self:registerAct("Exercism", "20% %\nDelayed\nTIRED")
    -- Register party act with Ralsei called "Tell Story"
    -- (second argument is description, usually empty)
    self:registerAct("Xercism", "60% %\nDelayed\nTIRED", {"ralsei"})
end

function Dummy:selectWave()
    local waves = self:getNextWaves()

    if waves and #waves > 0 then
        local wave = Utils.pick(waves)
        if #Game.battle.enemies > 1 and wave == "clawdrop" then
            wave = "holyfire"
        end
        self.selected_wave = wave
        return wave
    end
end


function Dummy:onAct(battler, name)
    if name == "Exercism" then
        -- Give the enemy 100% mercy
        self:addMercy(20)
        -- Change this enemy's dialogue for 1 turn
        --self.dialogue_override = "... ^^"
        -- Act text (since it's a list, multiple textboxes)
        self.exercism_used = true
        return {
            "* You started the exercism!\nYou encouraged Guei to exercise!"
        }

    elseif name == "Xercism" then
        -- Loop through all enemies
        --for _, enemy in ipairs(Game.battle.enemies) do
        --    -- Make the enemy tired
        --    enemy:setTired(true)
        --end
        self.exercism_used = true
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

return Dummy