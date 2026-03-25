return function(cutscene)
    --[[for _,follower in ipairs(Game.world.followers) do
        local colormask = follower:addFX(RecolorFX(1,1,1,1,1), id2)
        local mask = follower:addFX(AlphaFX(1), id)
        Game.world.timer:tween(7/30, colormask, {color = {0.5,0.5,0.5,1}})
        Game.world.timer:tween(7/30, mask, {alpha = 0})
		follower.shadow_force_off = true
		follower.highlight_force_off = true
    end
    cutscene:detachFollowers()
    cutscene:detachCamera()

    Assets.playSound("dtrans_lw")
    Game.world.player:setSprite("fall")
    Game.world.player.sprite:play(0.1, true)
    cutscene:slideTo(Game.world.player, Game.world.player.x, Game.world.player.y - 500, 2, "in-back")
    Game.world.player:convertToNPC()
    cutscene:fadeOut(2, {color = {1,1,1}})
    cutscene:wait(2)]]
    Game.world.music:stop()
    Game.world.fader:fadeOut(nil, {
        speed = 0,
    })
    Assets.playSound("locker")
    cutscene:wait(1)
    cutscene:loadMap("0_base_sanctum/base_fast_travel")
    Game.world.fader:fadeIn(nil, {
        speed = 0.25,
    })
end

