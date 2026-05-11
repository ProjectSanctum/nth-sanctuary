return {
	egg = function (cutscene)
		--local get = Game:getFlag("egg")
		local rand = love.math.random(1,50)
		if rand == 50 then
			Game.world:mapTransition("fractured_sanctuary/fractured_egg_room", "spawn")
		else
			if Game.world.map.id == "fractured_sanctuary/fractured_2" then
				Game.world:mapTransition("fractured_sanctuary/fractured_3", "entry")
			elseif Game.world.map.id == "fractured_sanctuary/fractured_3" then
				Game.world:mapTransition("fractured_sanctuary/fractured_2", "entry2")
			end
		end
	end,
	scarlet_tree = function (cutscene)
		--local get = Game:getFlag("egg")
		local rand = love.math.random(1,10)
		if rand == 10 then
			Game.world:mapTransition("secrets/citadel_room/tree", "spawn")
		else
			if Game.world.map.id == "secrets/citadel_room/citadel_room_3" then
				Game.world:mapTransition("secrets/citadel_room/edge", "entry")
			elseif Game.world.map.id == "secrets/citadel_room/edge" then
				Game.world:mapTransition("secrets/citadel_room/citadel_room_3", "entry2")
			end
		end
	end,
	egg_tree = function(cutscene)
		if not Game:getFlag("egg") then
			cutscene:text("* (He is behind the tree.)")
		else
			cutscene:text("* (It is a tree.)")
		end
	end,
	egggive = function (cutscene)
		if not Game:getFlag("egg") then
			Game:setFlag("egg", true)
			--Game.inventory:addItem("egg")
			cutscene:text("* (Well,[wait:5] there is a man here.)")
			cutscene:text("* (He has been waiting for you.)")
			cutscene:text("* (He whispers something to your ear,)")
			Assets.playSound("egg")
			cutscene:text("* (And he gives you an Egg.)")
		else
			cutscene:text("* (Well,[wait:5] there is not a man here.)")
		end
	end,
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
	end,
	chase = function(cutscene)
		Game.world.music:fade(0, 2)
		local kris = cutscene:getCharacter("kris")
		local susie = cutscene:getCharacter("susie")
		local ralsei = cutscene:getCharacter("ralsei")
		local jamm = cutscene:getCharacter("jamm")

		cutscene:text("* Hey, [wait:5]wait.", "neutral_side", susie)
		cutscene:text("* I'm starting to think this is more than just another Dark World.", "neutral_side", susie)
		cutscene:text("* What do you mean?", "small_smile", ralsei)
		cutscene:text("* Like, [wait:5]it feels.. [wait:10]More???[wait:10][face:sus_nervous] Like a big Dark World?", "neutral", susie)
		--
		--
		if jamm then
			cutscene:text("* I don't really know about this [wait:5]\"Dark World\" [wait:5]stuff.", "neutral", jamm)
			cutscene:text("* But you're right, [wait:5]this place [wait:3]IS[wait:3] pretty expansive...", "look_left", jamm)
		end
		cutscene:text("* It appears so...", "pensive", ralsei)
		cutscene:text("* I am more worried of the prophec", "pensive", ralsei, {auto = true})
		Assets.playSound("sussurprise")
		susie:shake()
		susie:setSprite("exasperated_right")
		cutscene:text("* SCREW the prophecy, [wait:5]Ralsei!", "teeth_b", susie)
		cutscene:text("* I just wanna get out of here!", "teeth_b", susie)
		cutscene:text("* I don't want to sit here, [wait:5]and twiddle my thumb", "teeth_b", susie, {auto = true})
		Assets.playSound("ghostappear")
		cutscene:wait(2)
		susie:resetSprite()
		susie:setFacing("down")
		cutscene:text("* ...Did you guys hear that?", "sus_nervous", susie)
		susie:setSprite("surprise_step")
		cutscene:text("* Wait, [wait:5]what is THAT?", "sad", susie)
		local h = cutscene:spawnNPC("cultist1",1000, 880)
		h:setAnimation("idle")
		h.layer = 99999999999
		local t = Game.world.timer:every(1/7, function()
			local image = AfterImage(h.sprite, 0.5, 0.02)
			image.physics.speed = 2
			Game.world:addChild(image)
		end)
		local ox, oy = Game.world.camera.x, Game.world.camera.y 
		cutscene:wait(cutscene:panTo(1000, Game.world.camera.y, 1.5, 'out-circ'))
		h:slideTo(1720, h.y, 2, 'in-back')
		cutscene:wait(2)
		cutscene:panTo(ox, oy, 2, 'out-cubic')
		cutscene:detachFollowers()
		susie:setSprite("point_right")
		Game.world.music:play("creepychase", 1)
		cutscene:text("* HEY, [wait:5]GET BACK HERE!", "angry_e", susie)
		susie:resetSprite()
		cutscene:walkTo(susie, 1720, 880, 3)
		cutscene:wait(1)
		cutscene:text("* S-[wait:5]Susie, [wait:5]wait!", "concern", ralsei)
		cutscene:walkTo(ralsei, 1720, 880, 3)
		cutscene:wait(1)
		if jamm then
			cutscene:text("* Well, [wait:5]guess we're doing this.", "stern", jamm)
			
			jamm:walkTo(1720, 880, 3)
		end
		cutscene:attachCamera()
		Game.world.map:doBullets()
		Game.world.timer:cancel(t)
		Game:setFlag("chase_cutscene_prog", 1)
	end,
	postchase = function (cutscene)
		local kris = cutscene:getCharacter("kris")
		local susie = cutscene:getCharacter("susie")
		local ralsei = cutscene:getCharacter("ralsei")
		local jamm = cutscene:getCharacter("jamm")
		ralsei.y = 340
		if jamm then jamm.y = 380 end
		susie.x = 90
		susie:setSprite("point_right")
		cutscene:text("* HEY, [wait:5]YOU!", "angry_c", susie)
		cutscene:text("* YOU CAN'T RUN! [wait:10]GET BACK HERE!", "angry_d", susie)
		susie:resetSprite()
		cutscene:walkTo(susie, 620, susie.y, 2)
		cutscene:wait(cutscene:panTo(800, Game.world.camera.y, 2, 'in-out-cubic'))
		Game.world.music:pause()
		local rect = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
		rect:setColor(COLORS.black)
		rect:setParallax(0)
		rect.layer = WORLD_LAYERS["ui"] - 2
		Game.world:addChild(rect)
		Kristal.hideBorder(0)
		local g = cutscene:getCharacter("guei")
		local origlayer = g.layer
		g:setLayer(rect.layer + 1)
		g:addFX(ColorMaskFX(COLORS.white))
		cutscene:wait(20/30)
		for i = 1, 15 do -- <-- Need to add one singular big slash instead, need effect sprites
			local spr = Sprite("effects/attack/red_slash")
			spr:setOrigin(0, 0.5)
			spr:setPosition(g.x, g.y - g.height)
			Game.world:addChild(spr)
			spr.layer = g.layer + 1
			spr.rotation = math.rad(i * 78)
			spr:play(1/15, false, function() spr:remove() g:shake() end)
			local waw = DamageNumber("damage", love.math.random(6500, 8000), g.x + g.width/2, g.y)
       		waw.layer = g.layer + 3
       		Game.world:addChild(waw)
       		waw:setColor({0, 0, 1})
			Assets.playSound("bigcut", 1, 2 - (i / 15))
			cutscene:wait(3/30)
		end
		cutscene:wait(2)
		rect:remove()
		g:removeFX(ColorMaskFX())
		Assets.playSound("imbue_hit", 2.5, 1)
		local sm = SmokeFx(g.x-10, g.y - g.height/2, 2, 1.5)
		Game.world:spawnObject(sm)
		g.layer = origlayer
		sm:setLayer(g.layer + 1)
		Game.world.camera:shake(20, 0, 0.5, 10, 10) 
		        local static_fx = ShaderFX(Mod.staticBulletShader, {
            ["time"] = function() return Kristal.getTime() end,
            ["brightness"] = 2
        })
        local waw = DamageNumber("msg", "imbued", g.x + g.width/2, g.y)
        waw.layer = 99999999
        Game.world:addChild(waw)
        waw:addFX(static_fx, "static_fx")
		cutscene:wait(3)
		Game:setFlag("chase_cutscene_prog", 2)
		cutscene:startEncounter("creature_a", false)
		
	end
}