return {
    susie_punch = function(cutscene, battler, enemy)
        cutscene:text("* Susie threw a punch at\nthe dummy.")

        Assets.playSound("damage")
        enemy:hurt(1, battler)
        cutscene:wait(1)

        cutscene:text("* You,[wait:5] uh,[wait:5] look like a weenie.[wait:5]\n* I don't like beating up\npeople like that.", "nervous_side", "susie")

        if cutscene:getCharacter("ralsei") then
            cutscene:text("* Aww,[wait:5] Susie!", "blush_pleased", "ralsei")
        end
    end,
    the_true_fight = function(cutscene, battler, enemy)
        Game.battle:setState("CUTSCENE")
        Game.battle:resetAttackers() 
        Game.battle.processing_action = false
    
        Game.battle.should_finish_action = false
        Game.battle.on_finish_keep_animation = nil
        Game.battle.on_finish_action = nil
        Game.battle.attack_done = true
        Game.battle.spell_finished = true

        local dummy = Game.battle.enemies[1]
        Game.battle.timer:tween(2, Game.battle.music, {volume = 0.01, pitch = 0.01})
        cutscene:wait(2.5)
    
        local cam = Game.battle.camera
        local normal_x, normal_y = cam.x, cam.y
    
        local cam_done = false
        Game.battle.timer:tween(1, cam, {zoom_x = 3, zoom_y = 3})
        Game.battle.timer:tween(1, cam, {x = 550, y = 155}, nil, function()
            cam_done = true
        end)
    
        cutscene:wait(2)
    
        local dununnn = Assets.playSound("dununnn")
    
        dummy:flash()
        dummy:setSprite("mad")
    
        cutscene:wait(2)
    
        local cam_back_done = false
        Game.battle.timer:tween(1, cam, {zoom_x = 1, zoom_y = 1})
        Game.battle.timer:tween(1, cam, {x = normal_x, y = normal_y}, nil, function() 
            cam_back_done = true
        end)
    
        local shaking = true
        Game.battle.timer:every(0.1, function()
            if shaking then
                dummy.sprite:shake(2, 0, 0.5, 0.05)
            end
        end)
    
        cutscene:wait(1.5)

        dummy:flash()
        local afterimage1 = AfterImage(dummy, 0.5)
        local afterimage2 = AfterImage(dummy, 0.6)
        afterimage1.physics.speed_x = -2.5
        afterimage2.physics.speed_x = -5
        afterimage1:setLayer(dummy.layer + 1)
        afterimage2:setLayer(dummy.layer + 2)
        Game.battle:addChild(afterimage1)
        Game.battle:addChild(afterimage2)
        Assets.playSound("bell_bounce_short")
        Assets.playSound("bell_bounce_short",.35,.7)
        Assets.playSound("bell_bounce_short",.2,.4)
    
        shaking = false
        dummy.siner_active = true
    
        Game.battle.music:stop()
        Game.battle.music:play("mad_battle", 1, 1)

        dummy:triggerTrueBattle(true)
        if Game.battle.state ~= "ATTACKING" or Game.battle.state ~= "ACTIONSDONE" or dummy.trigger_cause ~= "fight" then
            cutscene:text("* Suddenly, the dummy began to float!\n* Regaular ACTs won't work anymore!")
        end

        Game.battle:finishAllActions()
        Game.battle:setState("ACTIONSDONE")
        -- Game.battle:updateActionsDone()
        
        -- Game.battle.current_selecting = 0
        -- Game.battle:setState("ACTIONSDONE")
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
        shaking = false
        cutscene:slideTo(dummy, SCREEN_WIDTH + 30, dummy.y, 2)
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