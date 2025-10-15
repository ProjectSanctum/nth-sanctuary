local ThreeDPrism, super = Class(EnemyBattler)

function ThreeDPrism:init()
    super.init(self)

    -- Enemy name
    self.name = "3D Spinning Prism"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("3d")

    -- Enemy health
    self.max_health = 1
    self.health = 999999
    -- Enemy attack (determines bullet damage)
    self.attack = 40
    -- Enemy defense (usually 0)
    self.defense = -100
    -- Enemy reward
    self.money = 100

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "3d/cubes-3",
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        {
            "This is so cool guys",
            "I'm spinning!!!!"
        },
        "SPIN",
        "I'm gonna fucking kill you",
        "The FittnessGram Pacer Test is a       "
    }
    self.dialogue_offset = {30, 0}
    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT [image:infinite, -5, 0, 2,2] DF [image:infinite,-5,0,2,2] \n* Start fucking running"

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* Placeholder Text",
        "* Spinning and Spinning and Spinning and Spinning and Spinning and Spinning and Spinning and",
        "* Too many excess vacation days? Take a goddamn vacation straight to [shake:2][color:red]HELL",
        "[font:main_mono,64]Hello",
        "* woa",
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* damn he dyin"

    self:getAct("Check").description = "Useless\nanalysis"
    -- Register act called "Smile"
    self:registerAct("HoldBreath", "Move\nfaster", nil, 2)
    self:registerAct("Gyrate", "Spin\n6%\nmercy")
	
    self.progress = 0
end

function ThreeDPrism:isXActionShort(battler)
    return true
end

function ThreeDPrism:onAct(battler, name)
    if name == "HoldBreath" then
		if Game.battle.encounter.holdbreath then
			return "* Kris held their breath...\n* Nothing happened."
		else
			Game.battle.encounter.holdbreath = true
			return "* Kris held their breath.\n* Their heartbeat quickened.\n* The SOUL now moves faster."
		end
	elseif name == "Gyrate" then
        self:addMercy(6)
        Assets.stopAndPlaySound("pirouette", 0.7, 1.1)
        battler:setAnimation("pirouette")
		return "* Kris spun around three-dimensionally!"
    elseif name == "Standard" then --X-Action
        Assets.stopAndPlaySound("pirouette", 0.7, 1.1)
        battler:setAnimation("pirouette")
        if battler.chara.id == "ralsei" then
			self:addMercy(3)
			return "* Ralsei demonstrates 3D rotation!"
        elseif battler.chara.id == "susie" then
			self:addMercy(2)
			return "* Susie spun like a turntable!"
		elseif battler.chara.id == "jamm" then
			self:addMercy(2)
			return "* Jamm revolved around the Z-axis!"
		else
			self:addMercy(2)
			return "* "..battler.chara:getName().." spun around in 3D!"
		end
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

function ThreeDPrism:onShortAct(battler, name)
    if name == "Standard" then --X-Action
        Assets.stopAndPlaySound("pirouette", 0.7, 1.1)
        battler:setAnimation("pirouette")
        if battler.chara.id == "ralsei" then
			self:addMercy(3)
			return "* Ralsei demonstrates 3D rotation!"
		elseif battler.chara.id == "susie" then
			self:addMercy(2)
			return "* Susie spun like a turntable!"
		elseif battler.chara.id == "jamm" then
			self:addMercy(2)
			return "* Jamm revolved around the Z-axis!"
		else
			self:addMercy(2)
			return "* "..battler.chara:getName().." spun around in 3D!"
		end
    end

    return super.onShortAct(self, battler, name)
end

function ThreeDPrism:onTurnEnd()
    self.progress = self.progress + 1
end

function ThreeDPrism:getNextWaves()	
    if (self.progress == 0) then
        return { "3d/cubes-1" }
    elseif (self.progress == 1) then
        return { "3d/cubes-2" }
    elseif (self.progress == 2) then
        return { "3d/cubes-3" }
    elseif (self.progress == 3) then
        return { "3d/cubes-1" }
    elseif (self.progress == 4) then
        return { "3d/cubes-2" }
    elseif (self.progress == 5) then
        return { "3d/cubes-3" }
    elseif (self.progress == 6) then
        return { "3d/cubes-1-hard" }
    elseif (self.progress == 7) then
        return { "3d/cubes-2-hard" }
    elseif (self.progress == 8) then
		self.progress = 5
        return { "3d/cubes-3-hard" }
    end

    return super.getNextWaves(self)
end

return ThreeDPrism