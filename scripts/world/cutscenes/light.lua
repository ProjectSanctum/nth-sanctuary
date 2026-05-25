return {
    intro = function(cutscene)
        Game:setFlag("hometown_time", "night")
		for _, follower in ipairs(Game.world.followers) do
			follower.visible = false
		end
        cutscene:loadMap("light/hometown/torielhouse/kris_room")
		for _, save in ipairs(Game.world:getEvents("savepoint")) do
			save:remove()
		end
        Game.world.music:stop()
        Game.world.music:play("jitterbug_muffled")
        cutscene:fadeIn(2, {alpha = 1, music = false})
        local k = cutscene:getCharacter("kris")
        k:setPosition(502, 256)
        k:setSprite("sleepless_left")
        cutscene:wait(4)
        cutscene:wait(150/30)
		cutscene.muffled_voice = true
		cutscene.muffled_timer_max = 50
		cutscene.muffled_timer = cutscene.muffled_timer_max
		cutscene.muffled_alt = 0
		cutscene.rimshot = false
		cutscene.rimshot_timer_max = 50
		cutscene.rimshot_timer = cutscene.rimshot_timer_max
		cutscene.kris_toss = false
		cutscene.kris_toss_timer = 0
		cutscene.kris_toss_timer_max = 60
		cutscene.kris_toss_alt = 0
		cutscene:during(function()
			if cutscene.muffled_voice then
				if cutscene.muffled_timer == cutscene.muffled_timer_max then
					cutscene.muffled_alt = cutscene.muffled_alt + 1
					local sound = (cutscene.muffled_alt % 2) == 1 and "toriel_muffled" or "sans_muffled"
					Assets.playSound(sound)
				end
				cutscene.muffled_timer = cutscene.muffled_timer - DTMULT
				if cutscene.muffled_timer <= 0 then
					cutscene.muffled_timer = cutscene.muffled_timer_max
				end
			end
			if cutscene.rimshot then
				if cutscene.rimshot_timer == cutscene.rimshot_timer_max then
					Assets.playSound("rimshot_muffled")
				end
				cutscene.rimshot_timer = cutscene.rimshot_timer - DTMULT
				if cutscene.rimshot_timer <= 0 then
					cutscene.rimshot_timer = cutscene.rimshot_timer_max
				end
			end
			if cutscene.kris_toss then
				cutscene.kris_toss_timer = cutscene.kris_toss_timer - DTMULT
				if cutscene.kris_toss_timer <= 0 then
					cutscene.kris_toss_alt = cutscene.kris_toss_alt + 1
					cutscene.kris_toss_timer = cutscene.kris_toss_timer_max
					k:setSprite((cutscene.kris_toss_alt % 2) == 1 and "sleepless_cover_pillow_right" or "sleepless_cover_pillow_left")
					k:shake()
					Assets.playSound("wing")
				end
			end
		end)
        cutscene:wait(2)
        Assets.playSound("wing")
        k:shake()
        k:setSprite("sleepless_right")
        cutscene:wait(2)
        Assets.playSound("wing")
        k:shake()
        k:setSprite("sleepless_cover_right")
        cutscene:wait(2)
        Assets.playSound("wing")
        k:shake()
        k:setSprite("sleepless_cover_left")
        cutscene:wait(2)
		cutscene.muffled_voice = false
		cutscene:wait(2)
        Assets.playSound("wing")
        k:shake()
        k:setSprite("sleepless_left")
        cutscene:wait(3)
		Assets.playSound("rimshot_muffled")
		cutscene:wait(0.5)
		cutscene.muffled_voice = true
		cutscene.muffled_timer_max = 40
		--pillow.visible = false
        k:setSprite("sleepless_cover_1")
        cutscene:wait(2)
        Assets.playSound("wing")
        k:shake()
        k:setSprite("sleepless_cover_3")
		cutscene.rimshot = true
		cutscene:wait(40/30)
		cutscene.muffled_timer_max = 30
		cutscene.rimshot_timer_max = 30
		cutscene.kris_toss = true
		cutscene.kris_toss_timer_max = 30
		Game.world.timer:tween(210/30, cutscene, {kris_toss_timer_max = 10})
		cutscene:wait(4)
		cutscene.muffled_timer_max = 20
		cutscene.rimshot_timer_max = 20
		cutscene:wait(3)
		cutscene:wait(75/30)
		cutscene.muffled_voice = false
		cutscene.rimshot = false
		cutscene.kris_toss = false
		Game.world.music:stop()		
		Assets.playSound("susie_muffled")

            --gotocutscene when we do the transition to the church
    end
}