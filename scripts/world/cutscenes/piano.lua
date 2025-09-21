return {
    door = function (cutscene, event)
		event.forceend = true
		event.timer = 0
		if event.clear_darkness then
			--for _, hint in ipairs(Game.world.map:getEvents("pianohint")) do
				--	Game.world.timer:tween(20/30, hint, {hintalpha = 0}, 'out-quad', function() hint:remove() end)
			--end
		end
		if event.destroy_hints then
			for _, hint in ipairs(Game.world.map:getEvents("pianohint")) do
				Game.world.timer:tween(20/30, hint, {hintalpha = 0}, 'out-quad', function() hint:remove() end)
			end
		end
        local man = cutscene:getCharacter("lobbyman")
        Assets.playSound("snd_mysterygo")
        Game.world.timer:tween(0.75, man, {alpha = 0, scale_x = 1, scale_y = 3}, 'out-circ')
        cutscene:wait(1)
        man:remove()
    end,
}
