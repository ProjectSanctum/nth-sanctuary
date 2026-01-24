local NymphSpawn, super = Class(EnemyBattler)

function NymphSpawn:init()
    self.idlee = true
    super.init(self)
        Game.battle.timer:every(1/2, function()
        if self.idlee then
                    local image = AfterImage(self.sprite, 0.5, 0.02)
        image.physics.speed = 2
        Game.battle:addChild(image)
        end
    end)

    -- Enemy name
    self.name = "Nymph Spawn"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("nymph")

    -- Enemy health
    self.max_health = 2500
    self.health = 2500
    -- Enemy attack (determines bullet damage)
    self.attack = 15
    -- Enemy defense (usually 0)
    self.defense = -5
    -- Enemy reward
    self.money = 100
    self.disable_mercy = true
    self.tired = false

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 20

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "basic",
        "chaserorb",
        "movingarena"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {}

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 23 DF 8\n* The Spawn that grew before\nit could be stopped."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* You hear your heart beating in your ears.",
        "* When did you start being yourself?",
        "* It sputtered in a voice like crushed glass.",
        "* Smells like adrenaline.",
    }
    if Game:hasPartyMember("ralsei") then
        table.insert(self.text, "* Ralsei mutters to himself to stay calm.")
    end
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* It's slowing down."

	self:getAct("Check").description = "Consider\nstrategy"
    self:registerAct("Brighten", "Powerup\nlight", "all", 4)

    self.banish_amt = 48

    self:registerAct("Unleash", "Weaken\nenemy", nil, self.banish_amt)
	
    self.t_siner = 0
	
    self.tired_percentage = -1000
    self.can_freeze = false

    self.banish_act_index = 3
	self.shaker = 0
end

function NymphSpawn:getGrazeTension()
    return 0
end

function NymphSpawn:update()
    super.update(self)
    if (Game.battle.state == "MENUSELECT") and (Game.tension >= self.banish_amt) then
        self.t_siner = self.t_siner + (1 * DTMULT)
        if Game.battle.menu_items[self.banish_act_index] then
            if Game.battle.menu_items[self.banish_act_index].name == "Unleash" then
                Game.battle.menu_items[self.banish_act_index].color =
                    function()
                        return (ColorUtils.mergeColor(COLORS.yellow, COLORS.white, 0.5 + (math.sin(self.t_siner / 4) * 0.5)))
                    end
            end
        end
    end
	if self.shaker > 0 then
		self.graphics.shake_x = MathUtils.random(-self.shaker, self.shaker)
		self.graphics.shake_y = MathUtils.random(-self.shaker, self.shaker)
	end
end

function NymphSpawn:isXActionShort(battler)
    return true
end

function NymphSpawn:onHurt(damage, battler)
    super.onHurt(self)

    Assets.playSound("snd_spawn_weaker")
end

function NymphSpawn:hurt(amount, battler, on_defeat, color, show_status, attacked)
    if battler.chara:checkWeapon("blackshard") or battler.chara:checkWeapon("twistedswd") then
        amount = amount * 10
    end
    super.hurt(self, amount, battler, on_defeat, color, show_status, attacked)
end

function NymphSpawn:onTurnEnd()
    Game.battle.encounter.light_size = 48
end

function NymphSpawn:getEncounterText()
    if (Game.tension >=  self.banish_amt) then
        return "* The atmosphere feels tense...\n(You can use [color:yellow]UNLEASH[color:reset]!)"
    end
    return super.getEncounterText(self)
end

function NymphSpawn:onShortAct(battler, name)
    if name == "Standard" then
        return "* " .. battler.chara:getName() .. " tried to ACT, but failed!"
    end
    return nil
end

function NymphSpawn:onAct(battler, name)
    if name == "Brighten" then
        battler:flash()
        Game.battle.timer:after(7 / 30, function()
            Assets.playSound("boost")
            battler:flash()

            for _, chara in ipairs(Game.battle.party) do
                chara:flash()
            end
            local bx, by = Game.battle:getSoulLocation()
            local soul = Sprite("effects/soulshine", bx, by)
            soul:play(1 / 30, false, function() soul:remove() end)
            soul:setOrigin(0.25, 0.25)
            soul:setScale(2, 2)
            Game.battle:addChild(soul)
        end)

        Game.battle.encounter.light_size = 63

        return "* " .. battler.chara:getName() .. "'s SOUL shone brighter!"
    elseif name == "Unleash" then
        battler:setAnimation("act")

        Game.battle:startCutscene(function(cutscene)
            cutscene:text("* " .. battler.chara:getName() .. "'s SOUL emitted a brilliant light!")
            battler:flash()
            cutscene:playSound("revival")
            cutscene:playSound("snd_great_shine", 1, 0.8)

            local bx, by = Game.battle:getSoulLocation()
            local soul = Game.battle:addChild(TitanSpawnPurifySoul(bx+20, by+20))
            soul.color = Game:getPartyMember(Game.party[1].id).soul_color or { 1, 0, 0 }
            soul.layer = 501
            --  soul.graphics.fade = 0.20
            --soul.graphics.fade_to = 0

            local flash_parts = {}
            local flash_part_total = 20
            local flash_part_grow_factor = 0.5
            for i = 1, flash_part_total - 1 do
                -- width is 1px for better scaling
                local part = Rectangle(bx + 20, 0, 1, SCREEN_HEIGHT)
                part:setOrigin(0.5, 0)
                part.layer = soul.layer - i
                part:setColor(1, 1, 1, -(i / flash_part_total))
                part.graphics.fade = flash_part_grow_factor / 16
                part.graphics.fade_to = math.huge
                part.scale_x = i * i * 2
                part.graphics.grow_x = flash_part_grow_factor * i * 2
                table.insert(flash_parts, part)
                Game.battle:addChild(part)
            end

            local rect = nil

            local function fade(step, color)
                rect = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                rect:setParallax(0, 0)
                rect:setColor(color)
                rect.layer = soul.layer + 1
                rect.alpha = 0
                rect.graphics.fade = step
                rect.graphics.fade_to = 1
                Game.battle:addChild(rect)
                cutscene:wait(1 / step / 45)
            end

            cutscene:wait(30 / 30)

            -- soul:remove()
            fade(0.06, { 1, 1, 1 })


            if Game.battle.encounter.toggle_smoke then
                Game.battle.encounter.darkness_controller:remove()
            end
			self.shaker = 1
            cutscene:wait(20 / 30)
            for _, part in ipairs(flash_parts) do
                part:remove()
            end

            rect.graphics.fade = 0.02
            rect.graphics.fade_to = 0


            local wait = function() return soul.t > 540 end
            cutscene:wait(wait)
			Assets.playSound("titan_absorb", 1.5, 1.8)
			self.graphics.shake_friction = 0
			self.colormask = self:addFX(ColorMaskFX())
			self.colormask.color = {1, 1, 1}
			self.colormask.amount = 0
			Game.battle.timer:tween(15/30, self, {shaker = 5}, "linear")
			Game.battle.timer:tween(15/30, self.colormask, {amount = 1}, "linear")
			cutscene:wait(15/30)
			local spawn1 = Game.battle.encounter:addEnemy("leech_spawn", self.x, self.y)
			local spawn2 = Game.battle.encounter:addEnemy("leech_spawn", self.x, self.y)
			local xx, yy = 550, 200 - 45
			Game.battle.timer:tween(15/30, spawn1, {x = xx, y = yy}, "out-cubic")
			xx, yy = 550 + 10, 200 + 45
			Game.battle.timer:tween(15/30, spawn2, {x = xx, y = yy}, "out-cubic")
			local boom_sprite = Sprite("effects/spr_finisher_explosion", self.x, self.y-self.height)
			boom_sprite:setOrigin(0.5, 0.5)
			boom_sprite:setScale(0.25, 0.25)
			boom_sprite:setFrame(1)
			Game.battle.timer:tween(4/30, boom_sprite, {scale_x = 0.25 * 3, scale_y = 0.25 * 3})
			boom_sprite.layer = self.layer + 1
			boom_sprite:play(2 / 30, false, function()
				boom_sprite:remove()
			end)
			Game.battle:addChild(boom_sprite)
			self.idlee = false
			self.hurt_timer = -1
			self.defeated = true
			self:defeat("PACIFIED", false)
            self:remove()
			Assets.playSound("snd_tspawn", 1, 0.9)
			Assets.playSound("explosion_firework_bc", 1.5, 0.8)
            cutscene:text("* The NYMPH SPAWN split in two![wait:5]\n* Gather COURAGE and gain TP to finish them off with [color:yellow]BANISH[color:reset]!")
			Game.battle:finishAction()
        end)

        return
    elseif name == "Standard" then
        Game.battle:startActCutscene(function(cutscene)
            cutscene:text("* " ..
                battler.chara:getName() ..
                " tried to \"[color:yellow]ACT[color:reset]\"...\n* But, the enemy couldn't understand!")
        end)
        return
    elseif name == "Check" then
        if Game:getTension() >= self.banish_amt then
            return {"* NYMPH SPAWN - AT 33 DF 210\n* The Spawn that grew before it could be stopped.", "* The atmosphere feels tense...\n* (You can use \"[color:yellow]UNLEASH[color:reset]\"!)"}
        else
            return {"* NYMPH SPAWN - AT 33 DF 210\n* The Spawn that grew before it could be stopped.", "* Expose it to LIGHT... and gather COURAGE to gain TP.", "* Then, use \"[color:yellow]UNLEASH[color:reset]\" to weaken it!" }
		end
	end
    return super:onAct(self, battler, name)
end

function NymphSpawn:getSpareText(battler, success)
    return "* But, it was not something that\ncan understand MERCY."
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
	Game.battle.timer:tween(15/30, self, {shaker = 5}, "linear")
	Game.battle.timer:tween(15/30, self.colormask, {amount = 1}, "linear")
	Game.battle.timer:after(15/30, function()
		local spawn1 = Game.battle.encounter:addEnemy("leech_spawn", self.x, self.y)
		local spawn2 = Game.battle.encounter:addEnemy("leech_spawn", self.x, self.y)
		local xx, yy = 550, 200 - 45
		Game.battle.timer:tween(15/30, spawn1, {x = xx, y = yy}, "out-cubic")
		xx, yy = 550 + 10, 200 + 45
		Game.battle.timer:tween(15/30, spawn2, {x = xx, y = yy}, "out-cubic")
		local boom_sprite = Sprite("effects/spr_finisher_explosion", self.x, self.y-self.height)
		boom_sprite:setOrigin(0.5, 0.5)
		boom_sprite:setScale(0.25, 0.25)
		boom_sprite:setFrame(1)
		Game.battle.timer:tween(4/30, boom_sprite, {scale_x = 0.25 * 3, scale_y = 0.25 * 3})
		boom_sprite.layer = self.layer + 1
		boom_sprite:play(2 / 30, false, function()
			boom_sprite:remove()
		end)
		Game.battle:addChild(boom_sprite)
		self:defeat("DEFEATED", false)
		self:remove()
		Assets.playSound("snd_tspawn", 1, 0.9)
		Assets.playSound("explosion_firework_bc", 1.5, 0.8)
	end)
end

return NymphSpawn