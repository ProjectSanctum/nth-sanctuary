local NymphSpawn, super = Class(EnemyBattler)

function NymphSpawn:init()
    super.init(self)

    self.name = "Nymph Spawn"
    self:setActor("nymph")

    self.max_health = 50
    self.health = 50
    self.attack = 15
    self.defense = -5
    self.money = 100
	
    self.disable_mercy = true

    self.tired = false
    self.tired_percentage = -1

    self.can_freeze = false
	
    self.waves = {
        "darkshapesmines"
    }

    self.text = {
        "* You hear your heart beating in \nyour ears.",
        "* When did you start being \nyourself?",
        "* It sputtered in a voice like \ncrushed glass.",
    }
    if Game:hasPartyMember("ralsei") then
        table.insert(self.text, "* Ralsei mutters to himself to \nstay calm.")
    end
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* It's slowing down."

    self:getAct("Check").description = "Consider\nstrategy"
    self:registerAct("Brighten", "Powerup\nlight", "all", 4)
    self:registerAct("DualHeal", "Heal\nparty", {"susie", "ralsei"}, 16)
    self:registerAct("Unleash", "Weaken\nenemy", nil, 72)

    self.dualhealcount = 0

	self.t_siner = 0
    if Game:hasPartyMember("susie") and Game:hasPartyMember("ralsei") then
        self.banish_act_index = 4
    else
        self.banish_act_index = 3
    end
    self.phaseturn = 1
    self.difficulty = 0
	
	self.wake_kris_count = 0
	
	self.shaker = 0
	self.siner = 0
	self.afterimage_timer = 0
end

function NymphSpawn:update()
    super.update(self)
    if Game.battle.state == "MENUSELECT" and Game.battle.state_reason == "ACT" and Game.tension >= 72 then
        self.t_siner = self.t_siner + (1 * DTMULT)
        if Game.battle.menu_items[self.banish_act_index] then
            Game.battle.menu_items[self.banish_act_index].color = function()
                 return (ColorUtils.mergeColor(COLORS.yellow, COLORS.white, 0.5 + (math.sin(self.t_siner / 4) * 0.5)))
            end
        end
    end
	if self.shaker > 0 then
		self.graphics.shake_x = MathUtils.random(-self.shaker, self.shaker)
		self.graphics.shake_y = MathUtils.random(-self.shaker, self.shaker)
	end

    if Game.battle.state ~= "TRANSITION" and Game.battle.state ~= "INTRO" then
		self.siner = self.siner + 0.1 * DTMULT
		self.afterimage_timer = self.afterimage_timer + DTMULT
		self.sprite.y = self.sprite.y + (math.sin(self.siner) * 0.6) * DTMULT
		if self.afterimage_timer >= 15 then
			local image = AfterImage(self.sprite, 0.5, 0.02)
			image.physics.speed = 2
			Game.battle:addChild(image)
			self.afterimage_timer = 0
		end
    end
end

function NymphSpawn:getGrazeTension()
    return 0
end

function NymphSpawn:getSpareText(battler, success)
    return "* But, it was not something that\ncan understand MERCY."
end

function NymphSpawn:isXActionShort(battler)
    return true
end

-- note about damage to PARTY: if ShadowMantle is equipped, then the next happens:
-- damage = round(damage * 0.5)
-- (data.win of chapter 4, scr_damage, line 86)
-- (adding this to not forget to add it to bullet code)
function NymphSpawn:getAttackDamage(damage, battler, points)
    if battler.chara:checkWeapon("blackshard") or battler.chara:checkWeapon("twistedswd") then
        local dmg = super.getAttackDamage(self, damage, battler, points)
        return math.ceil(dmg * 10)
    end
    return super.getAttackDamage(self, damage, battler, points)
end

function NymphSpawn:onShortAct(battler, name)
    if name == "Standard" then
        return "* " .. battler.chara:getName() .. " tried to ACT, but failed!"
    end
    return nil
end

function NymphSpawn:onAct(battler, name)
	if name == "Check" then
        if Game:getTension() >= 72 then
            return {"* NYMPH SPAWN - AT 33 DF 210\n* The Spawn that grew before it could be stopped.", "* The atmosphere feels tense...\n* (You can use [color:yellow]UNLEASH[color:reset]!)"}
        else
            return {"* NYMPH SPAWN - AT 33 DF 210\n* The Spawn that grew before it could be stopped.", "* Expose it to LIGHT... and gather COURAGE to gain TP.", "* Then, use \"[color:yellow]UNLEASH[color:reset]\" to weaken it!" }
		end
    elseif name == "Brighten" then
        for _,party in ipairs(Game.battle.party) do
            party:flash()
        end
        Assets.playSound("boost")
        local bx, by = Game.battle:getSoulLocation()
        local soul = Sprite("effects/soulshine", bx + 5.5, by)
        soul:play(1 / 30, false, function() soul:remove() end)
        soul:setOrigin(0.5)
        soul:setScale(2, 2)
        Game.battle:addChild(soul)
		Game.battle.encounter.light_radius = 63
        return "* "..battler.chara:getName().."'s SOUL shone brighter!"
    elseif name == "DualHeal" then
        self.dualhealcount = self.dualhealcount + 1
        Game.battle:startActCutscene(function(cutscene)
            local susie = Game.battle:getPartyBattler("susie")
            local ralsei = Game.battle:getPartyBattler("ralsei")
            local canproceed = false
            local hashealed = false
            Game.battle.timer:after(7 / 30, function()
                susie:setAnimation("heal_charge") -- Susie starts the animation with the effects
                Assets.playSound("boost")
                battler:flash()
                susie:flash()
                ralsei:flash()
                local bx, by = Game.battle:getSoulLocation()
                local soul = Sprite("effects/soulshine", bx + 5.5, by)
                soul:play(1 / 30, false, function() soul:remove() end)
                soul:setOrigin(0.5)
                soul:setScale(2, 2)
                Game.battle:addChild(soul)
            end)
            Game.battle.timer:after(24 / 30, function()
                ralsei:setAnimation("battle/spell_ready") -- Ralsei starts the animation after a pause
                canproceed = true
            end)
            cutscene:text("* Your SOUL shined its power on\nRALSEI and SUSIE!")
            cutscene:wait(function() return canproceed == true end)
            susie:setAnimation("heal_end_short", function() susie:setAnimation("battle/idle") end)
            ralsei:setAnimation("battle/spell", function()
                for _,party in ipairs(Game.battle.party) do
                    local healnum = MathUtils.round((susie.chara:getStat("magic") + ralsei.chara:getStat("magic")) * 6)
                    Game.battle:applyHealBonuses(healnum, "susie") -- ralsei or susie??? Maybe needs 2 heal bonus appliers?????
                    local healmultiplier = 1.5
                    if self.dualhealcount == 2 then
                        healmultiplier = 1
                    elseif self.dualhealcount == 3 then
                        healmultiplier = 0.8
                    elseif self.dualhealcount == 4 then
                        healmultiplier = 0.3
                    elseif self.dualhealcount > 4 then
                        healmultiplier = 0.2
                    end
                    party:heal(MathUtils.round(healnum * healmultiplier))
                end
                hashealed = true
            end)
            if self.dualhealcount < 4 then
                cutscene:text("* Susie and Susie cast DUAL HEAL!\nEffectiveness of DUAL HEAL has\nlowered!")
            else
                cutscene:text("* Susie and Susie cast DUAL HEAL!")
            end
            cutscene:wait(function() return hashealed == true end)
        end)
        return
    elseif name == "Unleash" then
        battler:setAnimation("act")
        Game.battle:startCutscene(function(cutscene)
            cutscene:text("* "..battler.chara:getName().."'s SOUL emitted a brilliant \nlight!")
            battler:flash()

            local bx, by = battler:getRelativePos(battler.width/2 + 4, battler.height/2 + 4)

            local soul = Game.battle:addChild(TitanSpawnPurifySoul(bx, by))
            soul.color = Game:getPartyMember(Game.party[1].id).soul_color or { 1, 0, 0 }
            soul.layer = 501

            cutscene:wait(30 / 30)
			self.shaker = 1
            local wait = function() return soul.t >= 500 end
            cutscene:wait(wait)
			Assets.playSound("titan_absorb", 1.5, 1.8)
			self.graphics.shake_friction = 0
			self.colormask = self:addFX(ColorMaskFX())
			self.colormask.color = {1, 1, 1}
			self.colormask.amount = 0
			Game.battle.timer:tween(15/30, self, {shaker = 6}, "linear")
			Game.battle.timer:tween(15/30, self.colormask, {amount = 1}, "linear")
			cutscene:wait(15/30)
			local spawn1 = Game.battle.encounter:addEnemy("leech_spawn", self.x, self.y)
			local spawn2 = Game.battle.encounter:addEnemy("leech_spawn", self.x, self.y)
			spawn1:removeAct("Banish")
			spawn2:removeAct("Banish")
			spawn1:registerAct("DualHeal", "Heal\nparty", {"susie", "ralsei"}, 16)
			spawn2:registerAct("DualHeal", "Heal\nparty", {"susie", "ralsei"}, 16)
			spawn1:registerAct("Banish",   "Defeat\nenemy",  nil, 50)
			spawn2:registerAct("Banish",   "Defeat\nenemy",  nil, 50)
			if Game:hasPartyMember("susie") and Game:hasPartyMember("ralsei") then
				spawn1.banish_act_index = 4
				spawn2.banish_act_index = 4
			else
				spawn1.banish_act_index = 3
				spawn2.banish_act_index = 3
			end
			Game.battle.encounter.difficulty = math.max(Game.battle.encounter.difficulty, 2)
			local xx, yy = 550, 200 - 45
			Game.battle.timer:tween(15/30, spawn1, {x = xx, y = yy}, "out-cubic")
			xx, yy = 550 + 10, 200 + 45
			Game.battle.timer:tween(15/30, spawn2, {x = xx, y = yy}, "out-cubic")
			local boom_sprite = Sprite("effects/titan/finisher_explosion", self.x, self.y-self.height)
			boom_sprite:setOrigin(0.5, 0.5)
			boom_sprite:setScale(0.25, 0.25)
			boom_sprite:setFrame(1)
			boom_sprite.rotation = math.rad(MathUtils.random(360))
			Game.battle.timer:tween(4/30, boom_sprite, {scale_x = 0.25 * 3, scale_y = 0.25 * 3})
			boom_sprite.layer = self.layer + 1
			boom_sprite:play(1 / 30, false, function()
				boom_sprite:remove()
			end)
			Game.battle:addChild(boom_sprite)
			local boom_sprite_2 = Sprite("effects/titan/shockwave_bullet_explosion", self.x, self.y-self.height)
			boom_sprite_2:setOrigin(0.5, 0.5)
			boom_sprite_2:setScale(0.5, 0.5)
			boom_sprite_2:setFrame(1)
			boom_sprite_2.rotation = math.rad(MathUtils.random(360))
			boom_sprite_2.layer = self.layer + 1
			boom_sprite_2:play(2 / 30, false, function()
				boom_sprite_2:remove()
			end)
			Game.battle:addChild(boom_sprite_2)
			self.idlee = false
			self.hurt_timer = -1
			self.defeated = true
			self:defeat("PACIFIED", false)
            self:remove()
			Assets.playSound("snd_tspawn", 1, 0.9)
			Assets.playSound("explosion")
            cutscene:text("* The NYMPH SPAWN split in two![wait:5]\n* Gather COURAGE and gain TP to\nfinish them off with [color:yellow]BANISH[color:reset]!")
			Game.battle:finishAction()
        end)
        return
    elseif name == "Standard" then
        Game.battle:startActCutscene(function(cutscene)
            cutscene:text("* "..battler.chara:getName().." tried to \"[color:yellow]ACT[color:reset]\"...\n* But, the enemy couldn't understand!")
        end)
        return
    end
    return super.onAct(self, battler, name)
end


function NymphSpawn:getEnemyDialogue()
    return false
end

function NymphSpawn:onSpared()
	local recruit = RecruitMessage("purified", self.target_x, self.y - 40)
	recruit.start_x = self.target_x
	Game.battle:addChild(recruit)
end

function NymphSpawn:onHurt(damage, battler)
	super.onHurt(self, damage, battler)

    Assets.stopAndPlaySound("spawn_weaker")
end

function NymphSpawn:freeze()
    self:onDefeat()
end

function NymphSpawn:getEncounterText()
	if Game:getTension() < 72 and MathUtils.randomInt(100) < 4 then
		return "* Smells like adrenaline."
    elseif Game:getTension() >= 72 then 
		return "* The atmosphere feels tense...\n* (You can use [color:yellow]UNLEASH[color:reset]!)"
	else
		return super.getEncounterText(self)
	end
end

function NymphSpawn:onDefeat(damage, battler)
    self.idlee = false
    self.hurt_timer = -1
	self.defeated = true
	local sprite = self:getActiveSprite()
	sprite:stopShake()
	Game:addFlag("slain", 1)
	Assets.playSound("titan_absorb", 1.5, 1.8)
	self.graphics.shake_friction = 0
	self.colormask = self:addFX(ColorMaskFX())
	self.colormask.color = {1, 1, 1}
	self.colormask.amount = 0
	self.shaker = 1
	Game.battle.timer:tween(15/30, self, {shaker = 6}, "linear")
	Game.battle.timer:tween(15/30, self.colormask, {amount = 1}, "linear")
	Game.battle.timer:after(15/30, function()
		local spawn1 = Game.battle.encounter:addEnemy("leech_spawn", self.x, self.y)
		local spawn2 = Game.battle.encounter:addEnemy("leech_spawn", self.x, self.y)
		spawn1:removeAct("Banish")
		spawn2:removeAct("Banish")
		spawn1:registerAct("DualHeal", "Heal\nparty", {"susie", "ralsei"}, 16)
		spawn2:registerAct("DualHeal", "Heal\nparty", {"susie", "ralsei"}, 16)
		spawn1:registerAct("Banish",   "Defeat\nenemy",  nil, 50)
		spawn2:registerAct("Banish",   "Defeat\nenemy",  nil, 50)
		if Game:hasPartyMember("susie") and Game:hasPartyMember("ralsei") then
			spawn1.banish_act_index = 4
			spawn2.banish_act_index = 4
		else
			spawn1.banish_act_index = 3
			spawn2.banish_act_index = 3
		end
		Game.battle.encounter.difficulty = math.max(Game.battle.encounter.difficulty, 3)
		local xx, yy = 550, 200 - 45
		Game.battle.timer:tween(15/30, spawn1, {x = xx, y = yy}, "out-cubic")
		xx, yy = 550 + 10, 200 + 45
		Game.battle.timer:tween(15/30, spawn2, {x = xx, y = yy}, "out-cubic")
		local boom_sprite = Sprite("effects/titan/finisher_explosion", self.x, self.y-self.height)
		boom_sprite:setOrigin(0.5, 0.5)
		boom_sprite:setScale(0.25, 0.25)
		boom_sprite:setFrame(1)
		boom_sprite.rotation = math.rad(MathUtils.random(360))
		Game.battle.timer:tween(4/30, boom_sprite, {scale_x = 0.25 * 3, scale_y = 0.25 * 3})
		boom_sprite.layer = self.layer + 1
		boom_sprite:play(1 / 30, false, function()
			boom_sprite:remove()
		end)
		Game.battle:addChild(boom_sprite)
		local boom_sprite_2 = Sprite("effects/titan/shockwave_bullet_explosion", self.x, self.y-self.height)
		boom_sprite_2:setOrigin(0.5, 0.5)
		boom_sprite_2:setScale(0.5, 0.5)
		boom_sprite_2:setFrame(1)
		boom_sprite_2.rotation = math.rad(MathUtils.random(360))
		boom_sprite_2.layer = self.layer + 1
		boom_sprite_2:play(2 / 30, false, function()
			boom_sprite_2:remove()
		end)
		Game.battle:addChild(boom_sprite_2)
		self:defeat("DEFEATED", false)
		self:remove()
		Assets.playSound("snd_tspawn", 1, 0.9)
		Assets.playSound("explosion")
	end)
end

return NymphSpawn