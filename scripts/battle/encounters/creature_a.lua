local ImbuedGuei, super = Class(Encounter)

function ImbuedGuei:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = [[
* Darkness pours everywhere... [wait:10]\n
* The creature's presence makes you shake.
]]

    -- Battle music ("battle" is rude buster)
    self.music = "battle_creature"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    self.g = self:addEnemy("creature_a")
    self.orig_layer = self.g.layer

    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
    self.fakefade = Rectangle(0,0,999,999)
    self.fakefade:setColor(COLORS.black)
    self.fakefade.alpha = 0
    Game.battle:addChild(self.fakefade)
end

function ImbuedGuei:onBattleStart()
	Game:setFlag("imbued_battle_fading", false)
end

function ImbuedGuei:createBackground()
    return Game.battle:addChild(CreatureBG())
end

function ImbuedGuei:getDialogueCutscene()
    if self.g.health <= 1000 then
        return function(cutscene, battler)
            Game.battle.music:fade(0, 2)
            
            self.g.layer = BATTLE_LAYERS["ui"]
            self.fakefade.layer = self.g.layer - 1
            Game.battle:setState("ACTIONSELECT")
            Game.battle.current_selecting = 0
            Game.battle:setState("CUTSCENE")
            Game.battle.battle_ui.encounter_text:setText("")
            Game.battle.timer:tween(2, self.fakefade, {alpha = 0.5})
            cutscene:wait(3)
            local spr = self.g.sprite.eye.sprite
            local aura = Sprite("effects/darksmoke")
			aura:addFX(ColorMaskFX(COLORS.white), "color")
			Game.battle:addChild(aura)
			aura.layer = self.g.layer + 1
			aura:setOrigin(0.5, 0.5)
            local x, y = spr:getScreenPos()
            aura:setPosition(x, y)
            aura:setScale(10)
            aura.alpha = 0
            Assets.playSound("rocket", 1, 0.5)
            Game.battle.timer:tween(2, aura, {scale_x = 2, scale_y = 2, alpha = 1}, 'out-cubic')
            local radius_points = {}
            local particles = {}
            for k = 1, 360 do
                local angle = math.rad(k)
                local dx = math.cos(angle) * 100
                local dy = math.sin(angle) * 100
                table.insert(radius_points, {dx, dy})
            end
            cutscene:during(function()
                for i = #particles, 1, -1 do
                    local particle = particles[i]
                    local dx = aura.x - particle.x
                    local dy = aura.y - particle.y
                    if dx * dx + dy * dy < 32 then
                        particle:remove()
                        table.remove(particles, i)
                    end
                end
            end)
            for i = 1, 30 do
                local p = Sprite("effects/particle")
                local offset = TableUtils.pick(radius_points)
                p:setPosition(x + offset[1], y + offset[2])
                p:setOrigin(0.5, 0.5)
                Game.battle:addChild(p)
                p.layer = aura.layer + 1
                p.physics.gravity = 0.2
                p.physics.gravity_direction = MathUtils.angle(p.x, p.y, x, y)
                table.insert(particles, p)
                cutscene:wait(1/15)
            end
            cutscene:wait(1)
            Assets.playSound("ghostappear", 1, 0.75)
            Assets.playSound("great_shine", 0.8, 0.75)
            local e = Sprite("enemies/creature_a/eye")
            e:setPosition(x, y)
	        e:setOrigin(0.5, 0.5)
	        e:setScale(2)
	        e.graphics.spin = 0.01
	        e.layer = aura.layer
            e.alpha = 0
	        Game.battle:addChild(e)
	        Game.battle.timer:tween(1, e.graphics, {spin = 0.15}, 'out-cubic')
            Game.battle.timer:tween(1, e, {scale_x = 6, scale_y = 6, alpha = 0.7}, 'out-cubic', function()
                Game.battle.timer:tween(1, e, {scale_x = 1, scale_y = 1, alpha = 0}, 'in-cubic', function() e:remove() end)
            end)
            Game.battle.timer:tween(3, aura, {scale_x = 10, scale_y = 10, alpha = 0}, 'out-cubic', function() aura:remove() end)
            Game.battle.timer:tween(1.5, self.fakefade, {alpha = 0}, 'out-cubic')
            -- cutscene:wait(3)
            Game.battle.timer:every(1/30, function()
                for Kristal = 1, 2 do --                    <-- Evil moniey deletr
                    local a = self.g.x + ((love.math.random() * self.g.width) - (self.g.width / 2)) * 2
                    local b = self.g.y - (love.math.random() * self.g.height) * 2
                    local sparkle = HealSparkle(a, b)
                    sparkle:setLayer(WORLD_LAYERS["below_ui"])
                    sparkle:setColor(137/255, 157/255, 254/255, 1)
                    Game.battle:addChild(sparkle)
                end
            end, 4)
            --cutscene:wait(1)
            Assets.playSound("creature_heal")
            self.g:statusMessage("damage", "4000", {0.5, 0.6, 1})
            local ralsei = Game.battle:getPartyBattler("ralsei")
            local susie = Game.battle:getPartyBattler("susie")
            local jamm = Game.battle:getPartyBattler("jamm")
            ralsei:shake()
            ralsei:setSprite("shocked_right")
            cutscene:wait(2)
            cutscene:text("[shake:0.62][speed:0.5]* No... [wait:10]W-[wait:5]Wait...","concern_smile", ralsei)
            cutscene:text("[shake:0.62][speed:0.5]* It... [wait:10]Healed itself...","concern_smile", ralsei)            
            cutscene:text("[shake:0.62][speed:0.5]* This is hopeless. [wait:10][face:down_alt]It's just like the titan...","down", ralsei)
            cutscene:text("* Ralsei, [wait:10]that doesn't matter right now!", "pissed", jamm)
            cutscene:text("* Focus on this thing! [wait:10]Kris, [wait:5]can you still hold on?", "bangs/nervous_b", susie)
            cutscene:text("[shake:0.62][speed:0.5]* ...","roaring", ralsei)
            cutscene:text("[shake:0.62][speed:0.5]* ...","roaring", ralsei)
            cutscene:text("[shake:0.62][speed:0.5]* ...[wait:5]Kris, [wait:5]Susie, [wait:5]I...","roaring", ralsei)
            cutscene:text("[shake:0.62][speed:0.5]* ...","down", ralsei)
            cutscene:text("[shake:0.7][speed:0.75]* I won't back down like before..!", "determined", ralsei)
            cutscene:gotoCutscene("imbued", "ralseicast")
            --Assets.playSound("chargeshot_fire", 1, 0.7)
            --Assets.playSound("dtrans_square", 1, 0.7)
            --Assets.playSound("board_bomb", 1, 1)
        end
    end
end

return ImbuedGuei