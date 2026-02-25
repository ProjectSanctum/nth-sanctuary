local Dummy, super = Class(EnemyBattler)

function Dummy:init()
    super.init(self)

    -- Enemy name
    self.name = "Creature Ψ"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("creature_a")

    -- Enemy health
    self.max_health = 4000
    self.health = 4000
    -- Enemy attack (determines bullet damage)
    self.attack = 15
    -- Enemy defense (usually 0)
    self.defense = 0
    -- Enemy reward
    self.money = 100
    self.t_siner = 0

    	
	self.tired_percentage = 0
    self.low_health_percentage = 0
	
	self.disable_mercy = true

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "creatures/guei/basic",

    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {}

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = {
        "AT 37 DF 6\n* You can feel an unholy presence.",
        "The more time passes,[wait:5] the more it feels like darkness entraps your SOUL."
    }

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* It screams, but there's no sound.",
        "* Smells like rot.",
        "* Creature Ψ's hand spasms wildly.",
        "* When did you start being yourself?",
        
    }
end

function Dummy:update()
    super.update(self)
    
    if Game.battle.soul then
        self.sprite.eye.target = Game.battle.soul
    else
        self.sprite.eye.target = Game.battle.party[1]
    end
end

function Dummy:onHurt(damage, battler)
	super.onHurt(self, damage, battler)

    Assets.stopAndPlaySound("spawn_weaker")
end

function Dummy:getAttackDamage(damage, battler, points)
    if battler.chara:checkWeapon("blackshard") or battler.chara:checkWeapon("twistedswd") then
        local dmg = super.getAttackDamage(self, damage, battler, points)
        return math.ceil(dmg * 10)
    else
        local dmg = super.getAttackDamage(self, damage, battler, points)
        return math.ceil(dmg/1.5)
    end
    --return super.getAttackDamage(self, damage, battler, points)
end

function Dummy:onAct(battler, name)
    if name == "Standard" then
        Game.battle:startActCutscene(function(cutscene)
            cutscene:text("* "..battler.chara:getName().." tried to \"[color:yellow]ACT[color:reset]\"...\n* But, the enemy couldn't understand!")
        end)
        return
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

function Dummy:getSpareText(battler, success)
    return "* But,[wait:20] it was not something that\ncan understand MERCY."
end

return Dummy