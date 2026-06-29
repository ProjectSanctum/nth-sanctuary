return {
    ralseicast = function(cutscene, battler, enemy)
        local ral = cutscene:getCharacter("ralsei")
        ral:resetSprite()
        local radius_points = {}
        local particles = {}
        local snd = Music()
		snd:play("organ_enemy_loop_temp")
		snd:setPitch(0.02)

	    local p = 0.02
	    local charging = false
        for k = 1, 360 do
        	local angle = math.rad(k)
        	local dx = math.cos(angle) * 100
        	local dy = math.sin(angle) * 100
        	table.insert(radius_points, {dx, dy})
        end
            local aura = Sprite("effects/darksmoke")
        	aura:addFX(ColorMaskFX(COLORS.white), "color")
        	Game.battle:addChild(aura)
        	aura.layer = ral.layer + 1
        	aura:setOrigin(0.5, 0.5)
            local x, y = ral.x, ral.y - ral.height

        	charging = true

            aura:setPosition(x, y)
            aura:setScale(0.1)
            aura.alpha = 0
            --Assets.playSound("rocket", 1, 0.5)
        	ral:setAnimation("battle/spell_ready")
            Game.battle.timer:tween(2, aura, {scale_x = 5, scale_y = 5, alpha = 0.55}, 'out-cubic')
        	cutscene:during(function()
           
        		if (p < 0.96) and charging then
        			p = MathUtils.clamp(p + 0.05 * DTMULT, 0, 1)
        		end
        		snd:setPitch(p)
        		-- for i = #particles, 1, -1 do
           			-- local particle = particles[i]
           			-- local dx = aura.x - particle.x
           			-- local dy = aura.y - particle.y
           			-- if dx * dx + dy * dy < 50 then
           			    -- particle:remove()
           			    -- table.remove(particles, i)
           		    -- end
           		-- end
        	end, true)
        	for i = 1, 30 do
                local h = Sprite("effects/darksmoke")
                local offset = TableUtils.pick(radius_points)
        		h:addFX(OutlineFX(COLORS.white))
                h:setPosition(x + offset[1], y + offset[2])
                h:setOrigin(0.5, 0.5)
                Game.battle:addChild(h)
                h.layer = aura.layer + 1
                h.physics.gravity = 0.2
                h.physics.gravity_direction = MathUtils.angle(h.x, h.y, x, y)
        		h:fadeOutAndRemove(1, 0)
                table.insert(particles, h)
                cutscene:wait(1/15)
            end
        	cutscene:wait(1)
        	charging = false
        	snd:stop()
        	Assets.playSound("bigcut")
        	Assets.playSound("laz_c", 1, 0.8)
        	ral:setAnimation("battle/attack")
        	cutscene:wait(0.5)
            local enemy = Game.battle.enemies[1]
        	enemy:hurt(5103, ral)
        	enemy:flash()
        	aura:fadeOutAndRemove(1, 0)
        	Assets.playSound("heavydamage")
        	Game.battle.camera:shake(20, 0, 1)
        	cutscene:wait(2)
        	ral:resetSprite()
            Game.battle:resetAttackers()
            cutscene:after(function ()
                enemy:defeat("SPARED", false)
                Game.battle:setState("TRANSITIONOUT")
            end, true)
    end,
    the_true_end = function(cutscene, battler, enemy)
        Game.battle:setState("CUTSCENE")
        Game.battle:resetAttackers() 
        Game.battle.processing_action = false
    
        Game.battle.should_finish_action = false
        Game.battle.on_finish_keep_animation = nil
        Game.battle.on_finish_action = nil
        Game.battle.attack_done = true
        Game.battle.spell_finished = true

        local dummy = Game.battle.enemies[1]
        dummy.the_true_end = true
        cutscene:slideTo(dummy, dummy.old_x, dummy.old_y, 1, "out-quad")
        cutscene:battlerText(dummy, "OW!!!")
        cutscene:battlerText(dummy, "Alright,\nyou know\nwhat?")
        cutscene:battlerText(dummy, "SCREW YOU!")
        cutscene:battlerText(dummy, "You guys\nare BORING!")
        cutscene:battlerText(dummy, "Last time\nI fought\nsomeone\nlike you...")
        cutscene:battlerText(dummy, "... Let's say,\nthey WERE fun\nenough.")
        local shaking = true
        Game.battle.timer:every(0.1, function()
            if shaking then
                dummy.sprite:shake(2, 0, 0.5, 0.05)
            end
        end)
        cutscene:battlerText(dummy, "But you are just LAME!")
        cutscene:battlerText(dummy, "Lame.\nLame!\nSO LAME!!")
		Game.battle.music:stop()
		Assets.playSound("slidewhist")
        shaking = false
        cutscene:slideToSpeed(dummy, SCREEN_WIDTH + 30, dummy.y, 4)
        cutscene:wait(2)
        dummy:remove()

        -- dummy:defeat("SPARED", false)
        

        --[[local win_text = string.format("* You won!\n* Got 0 EXP and %s %s.", dummy.money, Game:getConfig("darkCurrencyShort"))
        Game.battle:battleText(win_text, function()
            Game.battle:setState("TRANSITIONOUT")
            Game.battle.encounter:onBattleEnd()
        end)]]

        cutscene:after(function() 
            dummy:defeat("SPARED", false)
            Game.battle:onVictory()
        end)
    end
}