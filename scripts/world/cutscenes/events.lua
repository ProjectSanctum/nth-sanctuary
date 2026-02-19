return {
    moss1 = function (cutscene)
        local get = Game:getFlag("moss1")
        if not get then
            Game.world.music.volume = 0
            Assets.playSound("moss_fanfare")
            cutscene:text("* You found the [color:green]Moss!")
            Game.inventory:addItem("moss")
            Game.world.timer:tween(1, Game.world.music, {volume = 1})
            Game:setFlag("moss1", true)
        elseif get == true then
            cutscene:text("* (You already got the moss.)")
        end
    end,

    moss2 = function (cutscene)
        local get = Game:getFlag("moss2")
        if not get then
            Game.world.music.volume = 0
            Assets.playSound("moss_fanfare")
            cutscene:text("* You found the [color:9999ff]DuskMoss!")
            Game.inventory:addItem("duskmoss")
            Game.world.timer:tween(1, Game.world.music, {volume = 1})
            Game:setFlag("moss2", true)
        elseif get == true then
            cutscene:text("* (You already got the moss.)")
        end
    end,

    shard = function(cutscene)
        cutscene:wait(2)
        local this = BurstObj(Game.world.player.x, Game.world.player.y, {0.2, 0.2, 0.2}, "darkshard")
        this:setScale(2)
        Game.world:spawnObject(this)
    end,

    tobykillsyou = function (cutscene)
        local toby = Sprite("npcs/dogcar")
        toby:play()
        toby.x, toby.y = Game.world.player.x+400, Game.world.player.y - 80
        toby:setScale(2)
        Game.world:spawnObject(toby)
        cutscene:wait(1/4)
        					Assets.playSound("drive")
        toby:slideTo(toby.x - 400, toby.y, 1/2)
        cutscene:wait(1/2)
        local a = Game.world:getEvent("pianobig")
        a.con = 4
        Game.lock_movement = true
        cutscene:fadeOut(0, {music = true})
        Assets.playSound("hurt")
        cutscene:wait(1)
        toby:remove()
        cutscene:fadeIn(1, {music = true})
        cutscene:wait(1)
        Game.lock_movement = false
    end,
    prism = function (cutscene)
        local dd = cutscene:getCharacter("ddelta")
		local dd_y = dd.y
        cutscene:setSpeaker(dd)
        if Game:getFlag("prism_quick") ~= true then
			cutscene:text("* delta warriors...[wait:5]\n* you finally arrived")
			cutscene:text("* this is the one and only \"Your Sanctuary\" location")
			cutscene:text("* very unfortunate timing though cuz it's mine now")
			cutscene:wait(0.5)
			cutscene:text("* but i can tell you really want it!!![wait:5]\n* i can tell...")
			cutscene:text("* so take it from me...")
			Game.world.music:pause()
			Assets.playSound("3dprism_appear")
			local wave_mag = 0
			local function getFXWaveMag()
				return wave_mag
			end
			dd:addFX(ShaderFX("wave_interlace", {
				["wave_sine"] = function () return Kristal.getTime() * 100 end,
				["wave_mag"] = function () return getFXWaveMag() end,
				["wave_height"] = 2,
				["texsize"] = { SCREEN_WIDTH, SCREEN_HEIGHT }
			}), "funky_mode")
			Game.world.timer:during(15/30, function()
				dd.y = MathUtils.lerp(dd.y, dd_y - 40, 0.125)
				wave_mag = MathUtils.lerp(wave_mag, 120, 0.125)
			end)
			cutscene:wait(15/30)
			wave_mag = 60
			prism_sprite = Sprite("enemies/3d/idle", dd.x, dd_y)
			prism_sprite:setLayer(dd.layer)
			prism_sprite:play(1/30, true)
			prism_sprite:setOrigin(0.5, 1)
			prism_sprite:setScale(2, 2)
			prism_sprite:addFX(ShaderFX("wave_interlace", {
				["wave_sine"] = function () return Kristal.getTime() * 100 end,
				["wave_mag"] = function () return getFXWaveMag() end,
				["wave_height"] = 2,
				["texsize"] = { SCREEN_WIDTH, SCREEN_HEIGHT }
			}), "funky_mode")
			Game.world:addChild(prism_sprite)
			dd.visible = false
			Game.world.timer:during(15/30, function()
				wave_mag = MathUtils.lerp(wave_mag, 0, 0.25)
			end)
			cutscene:wait(15/30)
			wave_mag = 0
			cutscene:wait(1)
			cutscene:text("* IF YOU DARE!!!")
            Game:setFlag("prism_quick", true)
			Game:saveQuick()
		else
			cutscene:text("* let's just cut to the chase.")
			Game.world.music:pause()
			Assets.playSound("3dprism_appear")
			local wave_mag = 0
			local function getFXWaveMag()
				return wave_mag
			end
			dd:addFX(ShaderFX("wave_interlace", {
				["wave_sine"] = function () return Kristal.getTime() * 100 end,
				["wave_mag"] = function () return getFXWaveMag() end,
				["wave_height"] = 2,
				["texsize"] = { SCREEN_WIDTH, SCREEN_HEIGHT }
			}), "funky_mode")
			Game.world.timer:during(15/30, function()
				dd.y = MathUtils.lerp(dd.y, dd_y - 40, 0.125)
				wave_mag = MathUtils.lerp(wave_mag, 120, 0.125)
			end)
			cutscene:wait(15/30)
			wave_mag = 60
			prism_sprite = Sprite("enemies/3d/idle", dd.x, dd_y)
			prism_sprite:setLayer(dd.layer)
			prism_sprite:play(1/30, true)
			prism_sprite:setOrigin(0.5, 1)
			prism_sprite:setScale(2, 2)
			prism_sprite:addFX(ShaderFX("wave_interlace", {
				["wave_sine"] = function () return Kristal.getTime() * 100 end,
				["wave_mag"] = function () return getFXWaveMag() end,
				["wave_height"] = 2,
				["texsize"] = { SCREEN_WIDTH, SCREEN_HEIGHT }
			}), "funky_mode")
			Game.world:addChild(prism_sprite)
			dd.visible = false
			Game.world.timer:during(15/30, function()
				wave_mag = MathUtils.lerp(wave_mag, 0, 0.25)
			end)
			cutscene:wait(15/30)
			wave_mag = 0
			cutscene:wait(1)
		end
        cutscene:startEncounter("3d")
		prism_sprite:remove()
		dd.y = dd_y
		dd.visible = true
        cutscene:text("* ok you win this is unfinished so have the item")
		Assets.playSound("eb_keyitem")
        cutscene:text("* You got the [color:blue]Sound Stone[color:reset]!")
		Assets.stopSound("eb_keyitem")
        Game.inventory:addItem("sound_stone")
        Game.world.music:play()
    end,
	seenThisMan = function (cutscene, event)
		local flag = Game:getFlag("interacted_with_random_guy")
		if flag==1 then
			cutscene:text("* The man... [wait:10]He told me...")
			cutscene:text("* He told me he wants to speak with you...")
			cutscene:text("* Have you [style:none][color:yellow][sound:creepyJingle]looked between the rooms?")
			Game:setFlag("interacted_with_random_guy", 2)
			return
		elseif flag == 2 then
			cutscene:text("* Heed my advice.")
			return
		elseif flag == 5 then
			cutscene:text("* Guess I'm just crazy.")
			return
		end

		cutscene:text({"* Have you seen this man?",
		"* The others swear I'm crazy, [wait:5]but I know I've seen him!",
		"* (The man gives you a flyer.)",
		"* (The man in the flyer looks all the familiar, [wait:5]yet forgettable.)",
		"* Have you seen him?"})
		local ch = cutscene:choicer({"Yes", "No"})
		if ch == 1 then
			cutscene:text("* You've seen him!? [wait:10]Alas, [wait:5]I speak the truth!")
			Game:setFlag("interacted_with_random_guy", 1)
		else
			cutscene:text("* No? [wait:10]Oh, [wait:5]well, [wait:5]that's a shame.")
			cutscene:text("* If you see him, [wait:5]please let me know.")
			Game:setFlag("interacted_with_random_guy", 5)
		end
	end
}