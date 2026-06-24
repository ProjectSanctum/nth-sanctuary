return {
    intro = function(cutscene)
		cutscene.lightning_timers = nil
		local function lightningFlash()
			if cutscene.lightning_timers then
				for _, timer in ipairs(cutscene.lightning_timers) do
					Game.world.timer:cancel(timer)
				end
			end
			if cutscene.church_lightning then
				cutscene.church_lightning:remove()
			end
			if cutscene.church_door_lightning then
				cutscene.church_door_lightning:remove()
			end
			cutscene.lightning_timers = {}
			local top_layers = {"treeup"}
			local palettesys = Game.world:getEvent("hometowndaynight")
			palettesys.night = 2
			palettesys.overlay.alpha = 0
			if Game.world.map.id == "light/hometown/town_church" then
				cutscene.church_lightning = Sprite("world/maps/hometown/church_lightning", 440, 0)
				cutscene.church_lightning:setScale(2)
				cutscene.church_lightning:setLayer(Game.world:parseLayer("objects"))
				Game.world:addChild(cutscene.church_lightning)
			end
			if cutscene.church_door then
				cutscene.church_door_lightning = Sprite("world/objects/church_door_lightning", cutscene.church_door.x, cutscene.church_door.y)
				cutscene.church_door_lightning:setScale(2)
				cutscene.church_door_lightning:setFrame(cutscene.church_door.frame)
				cutscene.church_door_lightning:setLayer(Game.world:parseLayer("objects") + 0.01)
				Game.world:addChild(cutscene.church_door_lightning)
			end
			if cutscene.church_darkness then
				cutscene.church_darkness.lightning_cancel_alpha = 0
			end
			for _, chara in ipairs(Game.stage:getObjects(Character)) do
				if chara:getFX("lightning") then
					chara:removeFX("lightning")
				end
				chara:addFX(LightningFlashFX(1, 2), "lightning")
			end
			for _, layer_id in ipairs(top_layers) do
				local layer = Game.world.map:getTileLayer(layer_id)
				if layer:getFX("palhack") then
					layer:removeFX("palhack")
				end
				layer:addFX(PaletteFX("world/town_palette", 2), "palhack")
			end
			table.insert(cutscene.lightning_timers, Game.world.timer:tween(80/30, palettesys, {night = 1}, "out-cubic"))
			table.insert(cutscene.lightning_timers, Game.world.timer:tween(80/30, palettesys.overlay, {alpha = 0.6}, "out-cubic"))
			if cutscene.church_lightning then
				table.insert(cutscene.lightning_timers, Game.world.timer:tween(80/30, cutscene.church_lightning, {alpha = 0}, "out-cubic"))
			end
			if cutscene.church_door_lightning then
				table.insert(cutscene.lightning_timers, Game.world.timer:tween(80/30, cutscene.church_door_lightning, {alpha = 0}, "out-cubic"))
			end
			if cutscene.church_darkness then
				table.insert(cutscene.lightning_timers, Game.world.timer:tween(80/30, cutscene.church_darkness, {lightning_cancel_alpha = 1}, "out-cubic"))
			end
			for _, chara in ipairs(Game.stage:getObjects(Character)) do
				local fx = chara:getFX("lightning")
				table.insert(cutscene.lightning_timers, Game.world.timer:tween(80/30, fx, {alpha = 0}, "out-cubic"))
			end
			for _, layer_id in ipairs(top_layers) do
				local layer = Game.world.map:getTileLayer(layer_id)
				local fx = layer:getFX("palhack")
				table.insert(cutscene.lightning_timers, Game.world.timer:tween(80/30, fx, {palette_index = 1}, "out-cubic"))
			end
			table.insert(cutscene.lightning_timers, Game.world.timer:after(80/30, function()
				for _, chara in ipairs(Game.stage:getObjects(Character)) do
					chara:removeFX("lightning")
				end
				for _, layer_id in ipairs(top_layers) do
					local layer = Game.world.map:getTileLayer(layer_id)
					layer:removeFX("palhack")
				end
				palettesys.night = 1
				palettesys.overlay.alpha = 0.6
				if cutscene.church_darkness then
					cutscene.church_darkness.lightning_cancel_alpha = 1
				end
				if cutscene.church_door_lightning then
					cutscene.church_door_lightning:remove()
				end
				if cutscene.church_lightning then
					cutscene.church_lightning:remove()
				end
				cutscene.lightning_timers = nil
			end))
		end
        cutscene:fadeOut(0)
		Kristal.hideBorder(0)
		cutscene:wait(0.5)
		local menu = Object(0, 0)
		menu.inherit_color = true
		menu.index = 1
		menu:setScale(1)
		menu.alpha = 0
		menu.x = 0
		menu.y = -40
		menu:setParallax(0)
		menu.layer = 1000
		Game.world:addChild(menu)
		cutscene:wait(0.5)
		local text = Text("Choose your destiny.", 0, 240-60, nil, nil, {
			align = "center"
		})
		text.inherit_color = true
		menu:addChild(text)
		local normal_text = Text("NORMAL", 0, 240-20, nil, nil, {
			align = "center"
		})
		normal_text.inherit_color = true
		menu:addChild(normal_text)
		local violence_text = Text("VIOLENCE", 0, 240+20, nil, nil, {
			align = "center"
		})
		violence_text.inherit_color = true
		menu:addChild(violence_text)
		local weird_text = Text("WEIRD", 0, 240+60, nil, nil, {
			align = "center"
		})
		weird_text.inherit_color = true
		menu:addChild(weird_text)
		local heart = Sprite("player/heart", SCREEN_WIDTH/2-normal_text:getTextWidth()/2-32, 240-60+8) 
		heart.inherit_color = true
		heart.color = COLORS.red
		menu:addChild(heart)

		Game.world.timer:tween(1, menu, {y = menu.y + 40, alpha = 1}, 'out-sine')
		cutscene:wait(function()
			if Input.pressed("up") and menu.index > 1 then
				Assets.playSound("ui_move")
				menu.index = menu.index - 1
			elseif Input.pressed("down") and menu.index < 3 then
				Assets.playSound("ui_move")
				menu.index = menu.index + 1
			end
			normal_text:setColor(COLORS.white)
			violence_text:setColor(COLORS.white)
			weird_text:setColor(COLORS.white)
			if menu.index == 1 then
				normal_text:setColor(COLORS.yellow)
				heart.x = SCREEN_WIDTH/2-normal_text:getTextWidth()/2-32
				heart.y = 240-20+8
			end
			if menu.index == 2 then
				violence_text:setColor(COLORS.yellow)
				heart.x = SCREEN_WIDTH/2-violence_text:getTextWidth()/2-32
				heart.y = 240+20+8
			end
			if menu.index == 3 then
				weird_text:setColor(COLORS.yellow)
				heart.x = SCREEN_WIDTH/2-weird_text:getTextWidth()/2-32
				heart.y = 240+60+8
			end
			if Input.pressed("confirm") then
				Assets.playSound("ui_select")
				if menu.index < 3 then
					Assets.playSound("ui_spooky_action")
				else
					Assets.playSound("ominous")
				end
				Game:setFlag("route", menu.index)
				return true
			end
			return false
		end)
		Game.world.timer:tween(2, menu, {scale_x = 0, scale_y = 0, x = SCREEN_WIDTH/2, y = 0, alpha = 0}, 'out-sine')
		cutscene:wait(2.25)
		text:remove()
		normal_text:remove()
		violence_text:remove()
		weird_text:remove()
		heart:remove()
		menu.scale_x = 1
		menu.scale_y = 1
		menu.x = 0
		menu.alpha = 0
		menu.index = 0
		menu.y = 0
		local skip_title = false
		local text = Text("Skip the introduction?", 0, 220, nil, nil, {
			align = "center"
		})
		text.inherit_color = true
		menu:addChild(text)
		local yes_text = Text("Yes", -120, 220+40, nil, nil, {
			align = "center"
		})
		yes_text.inherit_color = true
		menu:addChild(yes_text)
		local no_text = Text("No", 120, 220+40, nil, nil, {
			align = "center"
		})
		no_text.inherit_color = true
		menu:addChild(no_text)
		local heart = Sprite("player/heart", SCREEN_WIDTH/2-8, 220+40+8) 
		heart.inherit_color = true
		heart.color = COLORS.red
		menu:addChild(heart)
		
		Game.world.timer:tween(0.5, menu, {alpha = 1}, 'out-sine')
		cutscene:wait(function()
			if Input.pressed("left") and menu.index ~= 1 then
				Assets.playSound("ui_move")
				menu.index = 1
			elseif Input.pressed("right") and menu.index ~= 2 then
				Assets.playSound("ui_move")
				menu.index = 2
			end
			if menu.index == 1 then
				yes_text:setColor(COLORS.yellow)
				no_text:setColor(COLORS.white)
				heart.x = SCREEN_WIDTH/2-120-yes_text:getTextWidth()/2-32
			elseif menu.index == 2 then
				yes_text:setColor(COLORS.white)
				no_text:setColor(COLORS.yellow)
				heart.x = SCREEN_WIDTH/2+120-no_text:getTextWidth()/2-32
			end
			if Input.pressed("confirm") and menu.index ~= 0 then
				Assets.playSound("ui_select")
				skip_title = menu.index == 1 and true or false
				return true
			end
			return false
		end)
		menu:remove()
		cutscene:wait(1)
		if skip_title then
			local items_to_add = {"scarlixir","scarlixir","scarlixir","rhapsotea","rhapsotea","rhapsotea","ancientsweet","shadowcrystal","claimbclaws","sheetmusic"}
			Game:addPartyMember("susie")
			Game:addPartyMember("ralsei")
			cutscene:detachCamera()
			cutscene:loadMap("0_base_sanctum/base_center")
			for _, item in ipairs(items_to_add) do
				Game.inventory:addItem(item)
			end
			Game:getPartyMember("kris"):setWeapon("winglade")
			Game:getPartyMember("kris"):setArmor(1, "waferguard")
			Game:getPartyMember("kris"):setArmor(2, "tennatie")
			Game:getPartyMember("susie"):setWeapon("absorbax")
			Game:getPartyMember("susie"):setArmor(1, "spikeband")
			Game:getPartyMember("susie"):setArmor(2, "shadowmantle")
			Game:getPartyMember("ralsei"):setWeapon("scarfmark")
			Game:getPartyMember("ralsei"):setArmor(1, "princessrbn")
			Game:getPartyMember("ralsei"):setArmor(2, nil)
			Kristal.hideBorder(0)
			cutscene:gotoCutscene("primary.intro", true)
			return
		end
        Game:setFlag("hometown_time", "night")
		for _, follower in ipairs(Game.world.followers) do
			follower.visible = false
		end
        cutscene:loadMap("light/hometown/torielhouse/kris_room")
		for _, save in ipairs(Game.world:getEvents("savepoint")) do
			save:remove()
		end
        local k = cutscene:getCharacter("kris")
        k:setPosition(502, 256)
        k:setSprite("sleepless_left")
		local bed = Sprite("world/maps/hometown/torielhouse/kris_bed", 466, 176)
		bed:setScale(2)
		bed:setLayer(k.layer - 0.11)
		Game.world:addChild(bed)
		local pillow = Sprite("world/maps/hometown/torielhouse/kris_bed_pillow", 488, 194)
		pillow:setScale(2)
		pillow:setLayer(k.layer - 0.1)
		Game.world:addChild(pillow)
		local phone = Sprite("world/objects/kris_phone_floor_1", ((Game.world.camera.x - SCREEN_WIDTH/2) + 408) - 40, 
		((Game.world.camera.y - SCREEN_HEIGHT/2) + 336) - 94)
		phone:setScale(2)
		phone:setLayer(k.layer - 0.1)
		Game.world:addChild(phone)
		local wagon = LightIntroWagon(470, 330)
		wagon:setLayer(k.layer - 0.1)
		Game.world:addChild(wagon)
        Game.world.music:stop()
        Game.world.music:play("jitterbug_muffled")
        cutscene:fadeIn(2, {music = false})
		Kristal.showBorder(2)
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
		pillow.visible = false
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
        k:setSprite("sleepless_cover_2")
		cutscene:wait(90/30)
		Assets.playSound("noise")
        pillow:setSprite("world/maps/hometown/torielhouse/kris_bed_pillow_messy")
		pillow.visible = true
        k:setSprite("sleepless_left")
		cutscene:wait(60/30)
        cutscene:fadeOut(0)
		Assets.playSound("susie_muffled")
		cutscene:wait(90/30)
		cutscene:setSpeaker("susie")
		cutscene:text("[speed:0.5]* Kris,[wait:5] are you listening?")
		bed:remove()
		pillow:remove()
		wagon:remove()
		phone:remove()
		Game:setFlag("hometown_rain_drop_wait", 8)
		Game:setFlag("hometown_rain_max_particles", 240)
        cutscene:loadMap("light/hometown/krisyard")
		Game.world.music:stop()
		cutscene:detachCamera()
		Game.world.camera:setPosition(Game.world.camera.x, 276)
		s = cutscene:spawnNPC("susie_lw", 300, 436)
		s:setSprite("look_down_left")
        cutscene:fadeIn(0)
		local rainfx = Game.stage:getObjects(LightRainEffect)[1]
		if not rainfx then
			rainfx = LightRainEffect()
			Game.world:addChild(rainfx)
		end
		cutscene:wait(2)
		cutscene:text("* Kris.[wait:5] I want to make sure you know...[wait:5]", "dejected_smile")
		cutscene:text("* What I saw in there...[wait:5]\n* It's nothing to be worried about.[wait:5] I swear.", "dejected_smile")
		cutscene:text("* I'll meet you and Noelle at the festival tomorrow.", "sincere")
		cutscene:wait(0.5)
		s:setSprite("rain_windblow_1")
		cutscene:text("* Until then,[wait:5] try to get some rest,[wait:5] dumbass.", "small_smile")
		Game:setFlag("hometown_raining", 1)
		rainfx.faded_in_starting_rainsfx = true
		rainfx.rain_active = true
		if not rainfx.rain_outdoors_sfx then
			rainfx.rain_outdoors_sfx = Music()
			rainfx.rain_outdoors_sfx:play("raining", 0, 1)
		end
		rainfx.rain_outdoors_sfx:setPitch(0.9)
		rainfx.rain_outdoors_sfx:fade(1, 2)
		s:setAnimation("rain_windblow")
		cutscene:wait(2)
		s.sprite.anim_speed = 0
		cutscene:wait(2)
		cutscene:text("* See you tomorrow,[wait:5] Kris.", "small_smile")
		s:setSprite("walk_look_down")
		s:setFacing("down")
		cutscene:wait(0.5)
		cutscene:walkTo(s, s.x, 640, 2, "down")
		cutscene:wait(2)
		rainfx.rain_outdoors_sfx:fade(0.5, 2)
        cutscene:fadeOut(2)
		cutscene:wait(2)
		Game:setFlag("hometown_raining", 2)
        cutscene:loadMap("light/hometown/town_church")
		s = cutscene:spawnNPC("susie_lw", 860, -40)
		s:setSprite("walk_look_down")
		s:setFacing("down")
		cutscene:attachCameraImmediate()
		Game.world.camera.target = s
		Game.world.player.visible = false
		Game.world.music:stop()
		Game.world.map.image_layers["churchup"].visible = false
		cutscene.church_door = ChurchDoorDarkness(566, 528)
		cutscene.church_door:setLayer(Game.world:parseLayer("objects"))
		Game.world:addChild(cutscene.church_door)
		cutscene.church_darkness = ChurchDarknessVFX(0, 0)
		cutscene.church_darkness:setLayer(Game.world:parseLayer("objects"))
		Game.world:addChild(cutscene.church_darkness)
		local rainfx = Game.stage:getObjects(LightRainEffect)[1]
		if not rainfx then
			rainfx = LightRainEffect()
			Game.world:addChild(rainfx)
		end
		if not rainfx.rain_outdoors_sfx then
			rainfx.rain_outdoors_sfx = Music()
			rainfx.rain_outdoors_sfx:play("raining", 0.5, 1)
		end
		rainfx.rain_outdoors_sfx:setPitch(0.9)
        cutscene:fadeIn(1)
		cutscene:walkToSpeed(s, s.x, 500, 3, "down")
		cutscene:wait(0.5)
		cutscene:setSpeaker("susie")
		cutscene:text("* Test fucking dialogue[wait:30]", nil, s, {skip = false, auto = true})
		cutscene:text("* Test fucking dialogue 2[wait:30]", nil, s, {skip = false, auto = true})
		cutscene:wait(function()
			if s.y >= 500 then
				return true
			end
			return false
		end)
		s:setSprite("walk_unhappy")
		s:setFacing("down")
		cutscene:wait(0.5)
		s:setFacing("left")
		cutscene:wait(0.5)
		s:setFacing("up")
		cutscene:wait(0.5)
		s:setFacing("right")
		cutscene:wait(0.5)
		cutscene:walkTo(s, 960, 510, 0.5, "right")
		cutscene:wait(1)
		cutscene:text("* Test fucking Jamm Car dialogue")
		cutscene:detachCamera()
        cutscene:panTo(740, 580, 1, "out-cubic")
		cutscene.wind_sound = Music()
		cutscene.wind_sound:play("wind_highplace", 0, 0.6)
		cutscene.windpitch = 1
		Assets.playSound("dooropen", 0.7, 0.4)
		Assets.playSound("dooropen", 0.7, 0.5)
		cutscene.church_darkness.bg_active = true
		cutscene.church_darkness.window_active = true
		cutscene.church_door:setFrame(2)
		cutscene.wind_sound:fade(1, 1)
		rainfx.rain_outdoors_sfx:fade(0.3, 1)
		cutscene:during(function()
			cutscene.wind_sound:setPitch(cutscene.windpitch)
		end)
		Game.world.timer:tween(1, cutscene, {windpitch = 1.5}, "linear")
		cutscene:wait(0.5)
		Assets.playSound("sussurprise")
		s:setSprite("shock_down")
		s:shake()
		s:alert(20/30, {play_sound = false})
		cutscene:wait(1)
		s:setSprite("walk_unhappy")
		Game.world.music:play("cultchase")
		cutscene:wait(cutscene:walkTo(s, s.x - 100, 730, 10/30, "down"))
		cutscene:wait(cutscene:walkTo(s, 600, 730, 20/30, "left"))
		s:setFacing("up")
		Assets.playSound("thunder_instant")
		lightningFlash()
		cutscene:wait(function()
			if Input.pressed("menu") then
				Assets.stopAndPlaySound("thunder_instant")
				lightningFlash()
			end
			return false
		end)
    end
}