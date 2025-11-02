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
    self.attack = 20
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
    self:registerAct("Challenge", "A very\nterrible\nidea", "susie")
	
    self.progress = 0
	self.exit_on_defeat = false
	self.tired_percentage = -1
    self.sprite.anim_delay = (1/30)
    self.sprite.loop = true
	self.sprite:setAnimation(function(sprite, wait)
		while true do
			sprite:setFrame(1)
			wait(sprite.anim_delay)
			while sprite.frame < #sprite.frames do
				sprite:setFrame(sprite.frame + math.floor(Game.battle.encounter.rage_anim_speed))
				wait(sprite.anim_delay)
				sprite:setFrame(sprite.frame + math.ceil(Game.battle.encounter.rage_anim_speed))
				wait(sprite.anim_delay)
			end
		end
	end)
	self.challenge_acted = false
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
	elseif name == "Challenge" then
        battler:setAnimation("act")
        Game.battle:startActCutscene(function(cutscene)
			if self.challenge_acted then
				Assets.playSound("rocket")
				Game.battle.timer:tween(0.5, Game.battle.encounter, {rage_anim_speed = 2}, "in-quad", function()
					Game.battle.encounter.rage_anim_speed = 2
				end)
				Game.battle.timer:tween(0.5, self.sprite, {color = {1,0,0}}, "in-quad")
				if self.tired then
					self:setTired(false)
				end
				cutscene:text("* Susie challenged the Prism![wait:5]\n* The difficulty became unfair!")
				self.dialogue_override = "Time for you to [color:red]DIE[color:reset]"
			else
				cutscene:text("* Susie challenged the Prism!")
				cutscene:text("* Heh,[wait:1] I bet I could do this with my eyes closed!", "teeth_smile", "susie")
				Assets.playSound("rocket")
				Game.battle.timer:tween(1, Game.battle.encounter, {rage_anim_speed = 2}, "in-quad", function()
					Game.battle.encounter.rage_anim_speed = 2
				end)
				Game.battle.timer:tween(1, self.sprite, {color = {1,0,0}}, "in-quad")
				if self.tired then
					self:setTired(false)
				end
				cutscene:text("* The Prism turned red with anger![wait:5]\n* You definitely shouldn't have done that!")
				self.dialogue_override = "You will [color:red]REGRET[color:reset] those\nwords you hear me"
			end
			self.last_comment = self.comment
			self.name = "3D Prism"
			self.comment = "(Furious)"
			self.attack = 40
			self:removeAct("Challenge")
			self:registerAct("BegForMercy", "Revert\ndifficulty", "all", 8)
			Game.battle.encounter.raged = true
		end)
	elseif name == "BegForMercy" then
        battler:setAnimation("act")
        Game.battle:startActCutscene(function(cutscene)		
			if self.challenge_acted then
				self:addMercy(25)
				Assets.playSound("sparkle_gem")
				Game.battle.timer:tween(0.5, Game.battle.encounter, {rage_anim_speed = 1}, "in-quad", function()
					Game.battle.encounter.rage_anim_speed = 1
				end)
				Game.battle.timer:tween(0.5, self.sprite, {color = {1,1,1}}, "in-quad")
				cutscene:text("* Everyone begged for mercy![wait:5]\n* The Prism obliges and tones down\nthe difficulty.")
			else
				cutscene:text("* Everyone begged for the Prism to tone down its attacks!")
				Assets.playSound("sparkle_gem")
				Game.battle.timer:tween(1, Game.battle.encounter, {rage_anim_speed = 1}, "in-quad", function()
					Game.battle.encounter.rage_anim_speed = 1
				end)
				Game.battle.timer:tween(1, self.sprite, {color = {1,1,1}}, "in-quad")
				self:addMercy(25)
				cutscene:text("* The prism turns towards you for a moment,[wait:5] then slows down...")
				self.challenge_acted = true
				Game.battle.encounter.raged = false
			end
			self.comment = self.last_comment or ""
			if self.comment ~= "" then
				self.name = "3D Prism"
			else
				self.name = "3D Spinning Prism"
			end
			self.attack = 20
			if self.progress == 5 then
				self.progress = 2
			elseif self.progress == 6 then
				self.progress = 3
			elseif self.progress == 7 then
				self.progress = 1
			end
			self:removeAct("BegForMercy")
			self:registerAct("Challenge", "Still a\nterrible\nidea", "susie")
		end)
    elseif name == "Standard" then --X-Action
        return self:onShortAct(battler, name)
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

function ThreeDPrism:setTired(bool, hide_message)
	super.setTired(self, bool, hide_message)
    if self.comment ~= "" then
		self.name = "3D Prism"
	else
		self.name = "3D Spinning Prism"
	end
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
	if Game.battle.encounter.raged then
		if (self.progress == 0) then
			return { "3d/cubes-1" }
		elseif (self.progress == 1) then
			return { "3d/cubes-2" }
		elseif (self.progress == 2) then
			return { "3d/cubes-3" }
		elseif (self.progress == 3) then
			return { "3d/cubes-1-hard" }
		elseif (self.progress == 4) then
			return { "3d/cubes-2-hard" }
		elseif (self.progress == 5) then
			return { "3d/cubes-3-hard" }
		elseif (self.progress == 6) then
			return { "3d/cubes-1-hard" }
		elseif (self.progress == 7) then
			return { "3d/cubes-2-hard" }
		elseif (self.progress == 8) then
			self.progress = 5
			return { "3d/cubes-3-hard" }
		end
	else
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
	end
    return super.getNextWaves(self)
end

function ThreeDPrism:onSpared()
    super.onSpared(self)
    Game.battle.spare_sound:stop()
    Game.battle.spare_sound:play()

    local spare_flash = self:addFX(ColorMaskFX())
    spare_flash.amount = 0

    local sparkle_timer = 0
    local parent = self.parent

    Game.battle.timer:during(5/30, function()
        spare_flash.amount = spare_flash.amount + 0.2 * DTMULT
        sparkle_timer = sparkle_timer + DTMULT
        if sparkle_timer >= 0.5 then
            local x, y = Utils.random(0, self.width), Utils.random(0, self.height)
            local sparkle = SpareSparkle(self:getRelativePos(x, y))
            sparkle.layer = self.layer + 0.001
            parent:addChild(sparkle)
            sparkle_timer = sparkle_timer - 0.5
        end
   end, function()
        spare_flash.amount = 0
		Game.battle.timer:tween(2, self.sprite, {anim_delay = 1}, "in-quad", function()
			self.sprite:stop(true)
		end)
        local img1 = AfterImage(self, 0.7, (1/25) * 0.7)
        local img2 = AfterImage(self, 0.4, (1/30) * 0.4)
        img1:addFX(ColorMaskFX())
        img2:addFX(ColorMaskFX())
        img1.physics.speed_x = 4
        img2.physics.speed_x = 8
        parent:addChild(img1)
        parent:addChild(img2)
    end)
	
    self:defeat(pacify and "PACIFIED" or "SPARED", false)

	Game.battle.encounter.con = 2
    Game.battle.music:stop()
end

function ThreeDPrism:onDefeat(damage, battler)
    super.onDefeat(self, damage, battler)
    self.hurt_timer = -1
    self.defeated = true

    self:defeat("VIOLENCED", true)
	Game.battle.encounter.con = 2
    Game.battle.music:stop()
end

return ThreeDPrism