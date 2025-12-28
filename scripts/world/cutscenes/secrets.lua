return {
    frisk = function (cutscene)
        if Game:getFlag("fun") ~= 69 then
            cutscene:text("* (Holy shit it's Frisk from the game UNDERTALE.)")
        else
            cutscene:text("* (It's some sort of [image:npcs/frisk/engine, 0,0,2,2].)")
        end
    end,
    proph = function (cutscene)
        --cutscene:fadeOut(1, {music = true})
        local g = Sprite("world/events/prophecy/rune")
        g:setOrigin(0.5,0.5)
        g:setParallax(0)
        g.layer = 1000
        g:setScale(2)
        g.x, g.y = SCREEN_WIDTH/2, SCREEN_HEIGHT/2
        Game.world:addChild(g)
        g:addFX(ProphecyScrollFXAlt(1), "prop")
        g:setColor(1,0,0)
    
        cutscene:wait(2)
    end
}