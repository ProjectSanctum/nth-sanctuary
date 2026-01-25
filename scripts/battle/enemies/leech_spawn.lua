local LeechSpawn, super = Class(EnemyBattler, "leech_spawn")

function LeechSpawn:init()
    super.init(self)

    self.name = "Leech Spawn"
    self:setActor("leech")

    self.max_health = 2350
    self.health = 2350
    self.attack = 12
    self.defense = -5
    self.money = 100
	
    self.disable_mercy = true

    self.tired = false
    self.tired_percentage = -1

    self.can_freeze = false
	
    self.waves = {
        "darkleech_test"
    }

    self.text = {
        "* You hear your heart beating in \nyour ears.",
        "* When did you start being \nyourself?",
        "* It started to suckle on the ground."
    }
    if Game:hasPartyMember("ralsei") then
        table.insert(self.text, "* Ralsei mutters to himself to \nstay calm.")
    end

	self.low_health_text = nil
	self.tired_text = nil
	self.spareable_text = nil

    self:getAct("Check").description = "Consider\nstrategy"
    self:registerAct("Brighten", "Powerup\nlight", "all", 4)
    self:registerAct("Banish",   "Defeat\nenemy",  nil, 50)

    self.dualhealcount = 0

	self.t_siner = 0
    self.banish_act_index = 3
    self.phaseturn = 1
    self.difficulty = 0
	
	self.wake_kris_count = 0
end

function LeechSpawn:update()
    super.update(self)
    if Game.battle.state == "MENUSELECT" and Game.battle.state_reason == "ACT" and Game.tension >= 50 then
        self.t_siner = self.t_siner + (1 * DTMULT)
        if Game.battle.menu_items[self.banish_act_index] then
            Game.battle.menu_items[self.banish_act_index].color = function()
                 return (ColorUtils.mergeColor(COLORS.yellow, COLORS.white, 0.5 + (math.sin(self.t_siner / 4) * 0.5)))
            end
        end
    end
end

function LeechSpawn:getGrazeTension()
    return 0
end

function LeechSpawn:getSpareText(battler, success)
    return "* But, it was not something that\ncan understand MERCY."
end

function LeechSpawn:isXActionShort(battler)
    return true
end

-- note about damage to PARTY: if ShadowMantle is equipped, then the next happens:
-- damage = round(damage * 0.5)
-- (data.win of chapter 4, scr_damage, line 86)
-- (adding this to not forget to add it to bullet code)
function LeechSpawn:getAttackDamage(damage, battler, points)
    if battler.chara:checkWeapon("blackshard") or battler.chara:checkWeapon("twistedswd") then
        local dmg = super.getAttackDamage(self, damage, battler, points)
        return math.ceil(dmg * 10)
    end
    return super.getAttackDamage(self, damage, battler, points)
end

function LeechSpawn:onShortAct(battler, name)
    if name == "Standard" then
        return "* " .. battler.chara:getName() .. " tried to ACT, but failed!"
    end
    return nil
end

function LeechSpawn:onAct(battler, name)
	if name == "Check" then
        if Game:getTension() >= 50 then
            return {
                "* LEECH SPAWN - AT 27 DF 160\n* The backend darkness that leeches off of your fear.",
                "* The atmosphere feels tense...\n* (You can use [color:yellow]BANISH[color:reset]!)"
            }
        else
            return {
                "* LEECH SPAWN - AT 27 DF 160\n* The backend darkness that leeches off of your fear.",
                "* Expose it to LIGHT... and gather COURAGE to gain TP.",
                "* Then, \"[color:yellow]BANISH[color:reset]\" it!",
            }
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
    elseif name == "Banish" then
        battler:setAnimation("act")
        Game.battle:startCutscene(function(cutscene)
            cutscene:text("* "..battler.chara:getName().."'s SOUL emitted a brilliant \nlight!")
            battler:flash()

            local bx, by = battler:getRelativePos(battler.width/2 + 4, battler.height/2 + 4)

            local soul = Game.battle:addChild(TitanSpawnPurifySoul(bx, by))
            soul.color = Game:getPartyMember(Game.party[1].id).soul_color or { 1, 0, 0 }
            soul.layer = 501

            local wait = function() return soul.t >= 500 end
            cutscene:wait(wait)
            cutscene:after(function()
                if #Game.battle.enemies == 0 then
                    Game.battle:setState("VICTORY")
                end
            end)
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

function LeechSpawn:getEnemyDialogue()
    return false
end

function LeechSpawn:onSpared()
	local recruit = RecruitMessage("purified", self.target_x, self.y - 40)
	recruit.start_x = self.target_x
	Game.battle:addChild(recruit)
end

function LeechSpawn:onHurt(damage, battler)
	super.onHurt(self, damage, battler)

    Assets.stopAndPlaySound("spawn_weaker")
end

function LeechSpawn:onDefeat(damage, battler)
    self:onDefeatFatal(damage, battler)
end

function LeechSpawn:freeze()
    self:onDefeat()
end

function LeechSpawn:getEncounterText()
	if Game:getTension() < 50 and MathUtils.randomInt(100) < 4 then
		return "* Smells like adrenaline."
    elseif Game:getTension() >= 50 then 
		return "* The atmosphere feels tense...\n* (You can use [color:yellow]BANISH[color:reset]!)"
	else
		return super.getEncounterText(self)
	end
end

return LeechSpawn