return {
    entry = function (cutscene)
        cutscene:text("* (Walking beyond this door is the point of [color:yellow]no return.[color:white])")
        cutscene:text("* (You will not be able to go back.)")
        local ch = cutscene:choicer({"Enter", "Not Yet"})

        if ch == 1 then
            cutscene:fadeOut(0, {music = true})
            Assets.playSound("locker", 1, 0.5)
            cutscene:wait(1)
            Game.world:loadMap("final/final-intro")
            cutscene:gotoCutscene("finale", "intro")
        else
            cutscene:text("* (Get ready.)")
            cutscene:walkTo(Game.world.player, Game.world.player.x, Game.world.player.y+80, 1)
        end
    end,
    intro = function (cutscene)
        cutscene:fadeIn(0, {music = true})
        local g = Game.world.music
        g:pause()
        cutscene:wait(1)
        print("in")
        g:play()
        local a = Sprite("player/heart")
        a:setParallax(0,0)
        a:setOrigin(0.5, 0.5)
        a.x, a.y = SCREEN_WIDTH/2, SCREEN_HEIGHT/2
        a:setScale(2)
        a:setColor(1,0,0)
        Game.stage:addChild(a)
        cutscene:wait(1.6)
        a:remove()
        cutscene:wait(0.7)
        local k = Sprite("party/kris/dark/walk/down_1")
        k:setParallax(0,0)
        k:setOrigin(0.5, 0.5)
        k.x, k.y = SCREEN_WIDTH/2, SCREEN_HEIGHT/2
        k:setScale(2)
        k:addFX(ColorMaskFX({0,1,1}))
        Game.stage:addChild(k)
        local s = Sprite("party/susie/dark/walk/down_1")
        s:setParallax(0,0)
        s:setOrigin(0.5, 0.5)
        s.x, s.y = SCREEN_WIDTH/2-k.width*3, SCREEN_HEIGHT/2
        s:setScale(2)
        s:addFX(ColorMaskFX({1,0,1}))
        local r = Sprite("party/ralsei/dark/walk/down_1")
        r:setParallax(0,0)
        r:setOrigin(0.5, 0.5)
        r.x, r.y = SCREEN_WIDTH/2+k.width*3, SCREEN_HEIGHT/2
        r:setScale(2)
        r:addFX(ColorMaskFX({0,1,0}))
        Game.stage:addChild(s)
        Game.stage:addChild(r)
        cutscene:wait(1.8)
        local n = Sprite("party/noelle/dark/walk/down_1")
        n:setParallax(0,0)
        n:setOrigin(0.5, 0.5)
        n.x, n.y = SCREEN_WIDTH/2-k.width*6, SCREEN_HEIGHT/2
        n:setScale(2)
        n:addFX(ColorMaskFX({1,1,0}))
        local j = Sprite("party/jamm/dark/walk/down_1")
        j:setParallax(0,0)
        j:setOrigin(0.5, 0.5)
        j.x, j.y = SCREEN_WIDTH/2+k.width*6, SCREEN_HEIGHT/2
        j:setScale(2)
        j:addFX(ColorMaskFX({1,1,0}))
        Game.stage:addChild(n)
        Game.stage:addChild(j)
        cutscene:wait(3.9)
        k:remove()
        s:remove()
        r:remove()
        n:remove()
        j:remove()
        cutscene:wait(0.32)
        local proph = Sprite("world/events/prophecy/rune")
        local a = 0
        proph:setParallax(0)
        proph:setScale(2)
        proph:setOrigin(0.5, 0.5)
        proph.x, proph.y = SCREEN_WIDTH/2, SCREEN_HEIGHT/2
		proph.fx = proph:addFX(ProphecyScrollFX(nil, 3), "prop")
		proph.efx = proph:addFX(ProphecyEchoFXAlt(0, 2), "echo")
		proph.afx = proph:addFX(AlphaFX(0, 1), "alpha")
        Game.stage:addChild(proph)
		Game.world.timer:tween(30/30, proph.efx, {scroll_speed = 2})
		Game.world.timer:tween(10/30, proph.afx, {alpha = 1})
        cutscene:during(function ()
            a = a+DTMULT/30
            print(math.abs(math.sin(a)))
			local col = ColorUtils.mergeColor(COLORS.blue, ColorUtils.hexToRGB("#42D0FF"), math.abs(math.sin(a)))
            proph.fx:setProphecyColor(col[1], col[2], col[3], 1)
        end)
        cutscene:wait(8.43)
        local rect = Rectangle(0,0,999,999)
        rect.alpha = 0
        Game.stage:addChild(rect)
        Game.stage.timer:tween(0.67, rect, {alpha = 1})
        cutscene:wait(0.67)
        proph:remove()
        cutscene:loadMap("final/final-1")
        rect:fadeOutAndRemove(1)



        
    end
}