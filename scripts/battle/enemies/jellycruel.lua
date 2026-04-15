local Jellycruel, super = Class(EnemyBattler)

function Jellycruel:init()
    super.init(self)

    -- Enemy name
    self.name = "Jellycruel"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("jellycruel")
    self:setOrigin(0.5, 0.5)
    self.spareable_sprite = Sprite("enemies/jellycruel/spareable", 0, 0)
    self:addChild(self.spareable_sprite)
    self.spareable_sprite.alpha = 0
    self.sprite:setRotationOrigin(0.5, 0.5)
    self.spareable_sprite:setRotationOrigin(0.5, 0.5)

    -- Enemy health
    self.max_health = 5000
    self.health = 5000
    -- Enemy attack (determines bullet damage)
    self.attack = 12
    -- Enemy defense (usually 0)
    self.defense = 0
    -- Enemy reward
    self.money = 100

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = -999

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "jellycruel/jellies",
        "jellycruel/circle",
        "jellycruel/TRAGEDY",
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "jellycruel"
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = {"AT[image:enemies/jellycruel/idle, 6,0,0.6,0.6] DF[image:enemies/jellycruel/idle, 6,0,0.6,0.6]\n* The cruellest jelly.\n* Beware its poisonous attacks."}

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* Jellycruel jellies, [wait:5]cruelly.",
        "* I'm quaking in my boots rn bruh :sob:",
        "* What have you done to earn this fate?"
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* The jellycruel has been outcruelled."
    self.spareable_text = "* The jellycruel has been jellied."

    -- Register act called "Smile"
    -- Register party act with Ralsei called "Tell Story"
    -- (second argument is description, usually empty)
    self:registerAct("BegForMercy", "beg", "all")
    -- self:registerAct("DebugSpareable", "funni", "all")
	self.siner = 0
    self.atkup = false
end

function Jellycruel:update()
    super.update(self)
    self.spareable_sprite.x = self.sprite.x
    self.spareable_sprite.y = self.sprite.y
    self.spareable_sprite.rotation = self.sprite.rotation

    if Game.battle.state ~= "TRANSITION" and Game.battle.state ~= "INTRO" then
        self.siner = self.siner + (1 / 6) * DTMULT
        self.sprite.x = MathUtils.lerp(0, (math.sin(self.siner * 1)) * (3 * (self.health / self.max_health)), math.min(self.siner/2, 1))
        self.sprite.y = MathUtils.lerp(0, (math.sin(self.siner * 0.5)) * (8 * (self.health / self.max_health)), math.min(self.siner/2, 1))
		if self.bubble then
			local spr = self.sprite or self
			local x, y = spr:getRelativePos(0, spr.height/2, Game.battle)
			self.bubble.color = self.mercy < 100 and ColorUtils.hexToRGB("#FB0E1C") or ColorUtils.hexToRGB("#0e7dfb")
			self.bubble.x = x - (self.mercy == 100 and 100 or 0)
			self.bubble.y = y
		end
    end
end

function Jellycruel:onSpareable()
    Game.battle.timer:tween(1, self.sprite, {rotation = math.rad(180)}, 'out-expo')
    Game.battle.timer:tween(1, self.spareable_sprite, {alpha = 1}, 'out-expo', function() 
        self:setSprite("spareable") 
        self.spareable_sprite:remove() 
    end)
end

function Jellycruel:getNextWaves()
    return self.mercy == 100 and {} or super.getNextWaves(self)
end

function Jellycruel:onAct(battler, name)
    if name == "Standard" then --X-Action
        self:addMercy(0.1)
        return "* jellycruel."
    elseif name == "DebugSpareable" then
        self:addMercy(100)
        --self.sprite:crossFadeTo("spareable", 1)
        Game.battle.timer:tween(1, self.sprite, {rotation = math.rad(180)}, 'out-expo')
        Game.battle.timer:tween(1, self.spareable_sprite, {alpha = 1}, 'out-expo', function() self:setSprite("spareable") self.spareable_sprite:remove() end)
        return "* spareable."
    elseif name == "BegForMercy" then
        for _, party in ipairs(Game.battle.party) do
            party:statusMessage("msg", "miss")
        end
        if self.acts_unlock then 
            return {
            "* You tried to beg for mercy...", 
            "* But your names weren't [color:yellow]YELLOW[color:white]...", 
            "* Try [color:yellow]ACT[color:reset]ing!"}
        end
        self.acts_unlock = true
        local party_ids = {}
        for _, party in ipairs(Game.battle.party) do
            if party.chara.id ~= "susie" then
                table.insert(party_ids, party.chara.id)
            end
        end
        self:registerAct("BeCool", "Be\ncool", party_ids)
        self:registerAct("BeCruel", "Be\ncruel", "susie")

        return {"* You tried to beg for mercy...", "* But your names weren't [color:yellow]YELLOW[color:white]...", "* But, [wait:5]more [color:yellow]ACT[color:reset]s have been unlocked!"}
    elseif name == "BeCool" then
        battler:setAnimation("act")
        Game.battle:startActCutscene(function(cutscene)
            self:addMercy(10)
            cutscene:text("* Everyone did something cool!")
            self:statusMessage("damage", "+10", {1, 0.25, 0})
            self.attack = 22
            Assets.playSound("retropower")
            self:flash()
            cutscene:text("* The jellycruel did not like that. [wait:10]The next attack is going to hit hard!")
            self.wave_override = self.mercy < 100 and "jellycruel/circle" or nil
            self.atkup = true
        end)

        return
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

function Jellycruel:onTurnStart()
    if self.atkup then
        self.atkup = false
        self:statusMessage("damage", "-10", {1, 0.25, 0})
        self.attack = 12
    end
end
return Jellycruel