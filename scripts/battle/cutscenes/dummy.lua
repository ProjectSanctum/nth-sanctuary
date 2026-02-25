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
        local dummy = Game.battle.enemies[1]

        Game.battle.timer:tween(2, Game.battle.music, {volume = 0.01, pitch = 0.01})
        cutscene:wait(2.5)
    
        local cam = Game.battle.camera
        local normal_x, normal_y = cam.x, cam.y
    
        local cam_done = false
        Game.battle.timer:tween(1, cam, {zoom_x = 4, zoom_y = 4})
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
    
        shaking = false
    
        Game.battle.music:stop()
        Game.battle.music:play("mad_battle", 1, 1)

        dummy:triggerTrueBattle(true)
        cutscene:battlerText(dummy, "Fools.\nFools!\nFOOLS!!")
        
        -- Game.battle:setState("ACTIONSDONE")
    end,
}