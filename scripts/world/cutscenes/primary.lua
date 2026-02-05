return {
    intro = function (cutscene)
		Kristal.hideBorder(0)
        local susie, ralsei, kris = cutscene:getCharacter("susie"),cutscene:getCharacter("ralsei"),cutscene:getCharacter("kris")
        local function centerText(str)
            local text = DialogueText(str, 0, 16, 640, 480,
                                      { align = "center" })
            text.layer = WORLD_LAYERS["top"] + 100
            text.parallax_x = 0
            text.parallax_y = 0
            Game.world:addChild(text)

            text.advance_callback = function ()
                Game.world.timer:tween(1, text, { alpha = 0 }, "linear", function ()
                    text:remove()
                end)
            end

            cutscene:wait(function () return text:isRemoved() end)
        end
        for _, save in ipairs(Game.world.map:getEvents("savepoint")) do
            save.visible = false
        end
		Game.world.music:stop()
        cutscene:fadeOut(0)
        susie.x = 550
        kris.x = 630
        ralsei.x = 260
        kris.y = 400
        susie.y = 400
		local kris_x = kris.x
		local susie_x = susie.x
		local kris_y = kris.y
		local susie_y = susie.y
		local ralsei_y = ralsei.y
		local kris_layer = kris.layer
		local susie_layer = susie.layer
		local ralsei_layer = ralsei.layer
		local do_ripple = false
        centerText(
            "Hello.[wait:10]\n\n" ..
            "Just a fair warning before proceeding.[wait:10]\n" ..
            "The Dark, [wait:5]Second, [wait:5]and Third Sanctuaries are not recreations of\nDELTARUNE Chapter 4's maps. [wait:10]\n\n" ..
            "#th Sanctuary is meant to be enjoyed at your own pace.[wait:10]\nPlease, [wait:5]enjoy yourself.")
        cutscene:wait(1)
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
		cutscene:wait(2)
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
		local text = Text("Skip the title scene?", 0, 220, nil, nil, {
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

		Game.world.timer:tween(0.25, menu, {alpha = 1}, 'out-sine')
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
		cutscene:detachFollowers()
		if not skip_title then
			cutscene:wait(3)
			Assets.playSound("ch4_first_intro", MUSIC_VOLUME, 1)
			local remove = {}
			local sum = 85
			for i = 1,9 do
				local letter = Sprite("logo_letter_"..i)
				letter:setScale(2)
				letter:setParallax(0)
				letter:setOrigin(0, 1)
				letter.layer = 1000
				letter.alpha = 0
				Game.world:addChild(letter)
				Game.world.timer:tween(0.5, letter, {alpha = 1})
				letter.x = sum
				letter.y = SCREEN_HEIGHT/2
				--Assets.playSound("noise")
				cutscene:wait(1/10)
				sum = sum + (letter.width*2) + 12
				table.insert(remove, letter)
			end
			--ok look i know you might be mad at this code but lucid made it so much fucking harder than it had to be, okay? EDIT: ok jamm thank you for not making me do the terrible numbers. -mason
			for i = 1,9 do
				cutscene:wait(12/38-1/10)
			end
			local heart = Sprite("logo_heart")
			heart:setScale(2)
			heart:setParallax(0)
			heart:setOrigin(0.5, 0.5)
			heart.layer = 1000
			heart.noprop = true
			Game.world:addChild(heart)
			heart.x = 85 + 224
			heart.y = SCREEN_HEIGHT/2 - 34
			local grad = Sprite("logo_gradient")
			grad:setScale(2)
			grad:setParallax(0)
			grad:setOrigin(0.5, 0.5)
			grad:setColor(COLORS.white)
			grad.layer = 1000 + 1
			grad.noprop = true
			grad.alpha = 0
			Game.world:addChild(grad)
			grad.x = 85 + 224
			grad.y = SCREEN_HEIGHT/2 - 34
			table.insert(remove, grad)
			cutscene:wait(54/19) --(no longer) evil
			Game.world.timer:after(1.2, function()
				Game.world.timer:tween(1, grad, {alpha = 1}, "linear")
			end)
			cutscene:wait(1.2)
			local a = Text("#th Sanctuary")
			a.layer = 1000
			a:setOrigin(0, 0)
			a:setScale(2)
			local fake_fade = Rectangle(130, 240, 400, 200)
			fake_fade:setColor(COLORS.black)
			fake_fade:setOrigin(0, 0)
			fake_fade.alpha = 1
			fake_fade.layer = 99999999999
			a.x, a.y = 140, 244
			a:addFX(ProphecyScrollFXAlt(3), "prop")
			Game.stage:addChild(a)
			Game.stage:addChild(fake_fade)
			Game.world.timer:tween(2, fake_fade, {alpha = 0}, 'linear', function() fake_fade:remove() end)
					
			--Assets.playSound("bell_bounce_short")
			for _, sprite in ipairs(remove) do
				if not sprite.noprop then
					Game.world.timer:after(1/30, function()
						sprite:addFX(ProphecyScrollFX(nil, 2), "prop")
						sprite:addFX(AlphaFX(0.7, 1), "alpha")
					end)
				end
			end
			cutscene:wait(9.3)
			for _, trans in ipairs(Game.world.map:getEvents("transition")) do
				trans.collider.collidable = false
			end
			for _, trans in ipairs(Game.world.map:getEvents("ft_transition")) do
				trans.collider.collidable = false
			end
			cutscene:detachCamera()
			kris.layer = a.layer + 1
			susie.layer = a.layer + 1
			kris:setParallax(0)
			susie:setParallax(0)
			kris.x = SCREEN_WIDTH/2 + 40
			susie.x = SCREEN_WIDTH/2 - 40
			kris.y = -40
			susie.y = -40
			local fakehsv = HSVShiftFX()
			fakehsv.hue_start = 60;
			fakehsv.sat_start = 0.4;
			fakehsv.val_start = 1;
			fakehsv.hue_target = 80;
			fakehsv.sat_target = 0.4;
			fakehsv.val_target = 1;
			fakehsv.hue = fakehsv.hue_start;
			fakehsv.sat = fakehsv.sat_start;
			fakehsv.val = fakehsv.val_start;
			fakehsv.wave_time = 1;
			fakehsv.amount = 0;
			local highlight = ChurchHighlightFX(0, ColorUtils.hexToRGB("#42D0FFFF"), {thickness = -1})
			kris:addFX(fakehsv, "fakehsv")
			susie:addFX(fakehsv, "fakehsv")
			ralsei:addFX(fakehsv, "fakehsv")
			kris:addFX(highlight, "fakehighlight")
			susie:addFX(highlight, "fakehighlight")
			ralsei:addFX(highlight, "fakehighlight")
			kris:setAnimation("jump_fall")
			susie:setAnimation("fall_brace")
			local windows = IntroFallingWindows()
			windows.layer = 998
			windows:addFX(fakehsv, "fakehsv")
			Game.world:addChild(windows)
			Game.world.timer:lerpVar(kris, "y", kris.y, SCREEN_HEIGHT/2 - 40, 10)
			Game.world.timer:lerpVar(susie, "y", susie.y, SCREEN_HEIGHT/2 - 40, 10)
			cutscene:slideTo(ralsei, "ralpoint",0.01)
			cutscene:wait(10/30)
			Assets.playSound("break1", 0.95, 1)
			kris.sprite:stop()
			susie.sprite:stop()
			for _, sprite in ipairs(remove) do
				sprite:remove()
			end
			Assets.stopSound("ch4_first_intro")
			heart.layer = 1003
			for i = 1,94 do
				local letter = Sprite("logo_shatter/logo_piece_"..i)
				letter:setScale(2)
				letter:setParallax(0)
				letter:setOrigin(0.5, 0.5)
				letter.layer = a.layer + 2
				letter.physics.speed = 5
				letter.physics.friction = 0.5
				letter.physics.direction = math.rad(90)
				letter.physics.gravity_direction = math.rad(270)
				Game.world.timer:after(10/30, function()
					letter.physics.gravity = 0.25 + MathUtils.random(0.1)
					letter.physics.friction = 0
					letter.physics.direction = math.rad(90 + MathUtils.random(-3, 3))
					if i > 47 then
						letter.physics.speed = 2 + (((94 - i) / 47) * 7)
					else
						letter.physics.speed = 2 + ((i / 47) * 7)
					end
					letter.layer = 1000
				end)
				Game.world:addChild(letter)
				letter.x = 85 + 224
				letter.y = SCREEN_HEIGHT/2 - 34
				table.insert(remove, letter)
			end	
			a.physics.speed = 5
			a.physics.friction = 0.5
			a.physics.direction = math.rad(90)
			a.physics.gravity_direction = math.rad(270)
			heart.physics.speed = 5
			heart.physics.friction = 0.5
			heart.physics.direction = math.rad(90)
			heart.physics.gravity_direction = math.rad(270)
			Game.world.timer:lerpVar(kris, "y", kris.y, kris.y + 15, 10, 2, "out")
			Game.world.timer:lerpVar(susie, "y", susie.y, susie.y + 15, 10, 2, "out")
			cutscene:wait(10/30)
			local heartburst = HeartBurst(heart.x - 224 + 106*2, heart.y - 34 + 20*2, COLORS.red)
			heartburst:setParallax(0)
			heartburst.layer = 1003
			Game.world:addChild(heartburst)
			heart:remove()
			cutscene.windvol = 0
			cutscene.windpitch = 0.01
			cutscene.dronevol = 0
			cutscene.dronepitch = 0.01
			local windsfx = Assets.playSound("strongwind_loop", 0, 1)
			windsfx:setLooping(true)
			windsfx:play()
			local dronesfx = Assets.playSound("dtrans_drone", 0, 1)
			dronesfx:setLooping(true)
			dronesfx:play()
			cutscene:during(function()
				windsfx:setVolume(cutscene.windvol)
				windsfx:setPitch(cutscene.windpitch)
				dronesfx:setVolume(cutscene.dronevol)
				dronesfx:setPitch(cutscene.dronepitch)
			end)
			kris:setAnimation("jump_fall")
			susie:setAnimation("jump_fall")
			Game.world.timer:tween(15/30, cutscene, {windvol = 0.5, windpitch = 1}, "linear")
			Game.world.timer:after(2/30, function() Assets.playSound("glassbreak", 0.4, 0.6) end)
			Assets.playSound("punchmed", 0.95, 0.7)
			Assets.playSound("ch4_first_intro_breaking", 0.5, 0.5)
			Assets.playSound("ch4_first_intro_breaking", 0.5, 0.44)
			a.physics.direction = math.rad(90 + MathUtils.random(-3, 3))
			a.physics.speed = -2
			a.physics.friction = 0
			a.physics.gravity = 0.25 + MathUtils.random(0.1)
			a.graphics.spin = math.rad(Utils.randomSign()/5)
			local shards_remove = {}
			for i = 1,15 do
				local groundshard = ProphecyGroundShard((SCREEN_WIDTH/2-199)+(i*399)/15+MathUtils.random(-30, 30), SCREEN_HEIGHT/2-34+MathUtils.random(60))
				groundshard:setParallax(0)
				groundshard.layer = 1000
				groundshard.ytarg = 10000
				Game.world:addChild(groundshard)
				table.insert(shards_remove, groundshard)
			end
			Game.world.timer:lerpVar(kris, "y", kris.y, kris.y + 50, 90, 3, "out")
			Game.world.timer:lerpVar(susie, "y", susie.y, susie.y + 50, 90, 3, "out")
			cutscene:wait(20/30)
			windows.window_timer = 1
			cutscene:wait(70/30)
			Game.world.timer:tween(15/30, windows, {darken = 1}, "in-cubic")
			Game.world.timer:tween(15/30, highlight, {alpha = 1.05}, "in-cubic")
			Game.world.timer:tween(15/30, cutscene, {dronevol = 0.4, dronepitch = 0.8}, "linear")
			local prophecies = IntroGigaProphecies()
			prophecies.layer = 997
			prophecies:addFX(fakehsv, "fakehsv")
			Game.world:addChild(prophecies)
			cutscene:wait(2)
			Game.world.timer:tween(10/30, cutscene, {dronevol = 0.6, dronepitch = 1}, "linear")
			a:remove()
			for _, sprite in ipairs(remove) do
				sprite:remove()
			end
			for _, shard in ipairs(shards_remove) do
				shard:remove()
			end
			local panel_container = Object(SCREEN_WIDTH/2 + 150/2, 500)
			panel_container:setParallax(0)
			panel_container.layer = 1002
			panel_container:addFX(fakehsv, "fakehsv")
			Game.world:addChild(panel_container)
			local panel = ProphecyPanel("backgrounds/IMAGE_DEPTH_EXTEND_MONO_SEAMLESS", "backgrounds/IMAGE_DEPTH_EXTEND_SEAMLESS", "initial2", "THE LEGEND OF THIS WORLD.\n<DELTARUNE.>", 150, 90)
			panel:setOrigin(0.5, 0.5)
			panel.sprite_offset_x = 49
			panel.sprite_offset_y = 61
			panel.text_offset_x = -160
			panel.text_offset_y = -16
			panel.no_back = true
			panel.fade_edges = true
			panel.ignore_onscreen_rules = true
			panel_container:addChild(panel)
			Game.world.timer:during(10/30, function()
				panel.panel_alpha = MathUtils.lerp(panel.panel_alpha, 1.2, DTMULT*0.1)
			end)
			Game.world.timer:tween(10/30, panel_container, {y = 250}, "linear")
			cutscene:wait(10/30)
			cutscene.windvol = 0
			cutscene.dronevol = 0
			windows.delta = 0.05
			prophecies.delta = 0.05
			panel.panel_alpha = -99
			Assets.playSound("break1", 0.95, 1)
			kris:setSprite("fall_hurt_1")
			susie:setAnimation("fall_brace")
			local broken_container = Object(panel_container.x - 150*2 + 49/2, panel_container.y - 90*2 + 34/2)
			broken_container:setParallax(0)
			broken_container.layer = 1002
			broken_container.draw_children_below = 0
			Game.world:addChild(broken_container)
			local sprites = Assets.getFrames("world/events/prophecy/shatter/prophecy_shatter_fall")
			for i, texture in ipairs(sprites) do
				local s = Sprite(texture)
				s:setScale(2)
				broken_container:addChild(s)
				s.alpha = 0.8
				s.physics.speed = 7
				s.physics.friction = 0.75
				s.physics.direction = math.rad(90 + MathUtils.random(-3, 3))
				s.physics.speed_x, s.physics.speed_y = s:getSpeedXY()
				if i == #sprites - 2 or i == #sprites - 4 then
					s.physics.speed_x = 0.5
				end
				if i == #sprites - 1 or i == #sprites - 3 then
					s.physics.speed_x = -0.5
				end
				s.physics.speed, s.physics.direction = s:getSpeedDir()
				s.physics.gravity_direction = math.rad(270)
				Game.world.timer:after(10/30, function()
					s.physics.gravity = 0.25 + MathUtils.random(0.1)
					s.physics.friction = 0
					s.physics.speed = 2 + (((#sprites - i) / #sprites) * 15)
					if i > (#sprites - 5) or i % 2 == 0 then
						s.layer = -1
					end
				end)
				s:addFX(fakehsv, "fakehsv")
			end
			Game.world.timer:after(10/30, function()
				for i = 1,30 do
					local groundshard = ProphecyGroundShard((panel_container.x - 150/2 - 199) + ((i * 398) / 30) + MathUtils.random(-30, 30), panel_container.y - 90/2 + MathUtils.random(120))
					groundshard.layer = 1000
					groundshard:setParallax(0)
					groundshard.ytarg = 10000
					Game.world.timer:after(280/30, function()
						groundshard:remove()
					end)
					Game.world:addChild(groundshard)
				end
				panel_container:remove()
			end)
			Game.world.timer:lerpVar(kris, "y", kris.y, kris.y + 5, 10, 2, "out")
			Game.world.timer:lerpVar(susie, "y", susie.y, susie.y + 5, 10, 2, "out")
			cutscene:wait(10/30)
			broken_container.layer = 1000
			Game.world.timer:after(2/30, function() Assets.playSound("glassbreak", 0.4, 0.6) end)
			Assets.playSound("sparkle_glock", 0.5, 0.8)
			Assets.playSound("sparkle_glock", 0.5, 0.71)
			Assets.playSound("punchmed", 0.95, 0.7)
			windows.delta = 1
			prophecies.delta = 1
			cutscene.windvol = 0.5
			cutscene.dronevol = 0.4
			Game.world.timer:tween(60/30, cutscene, {windpitch = 1.25}, "linear")
			Game.world.timer:tween(120/30, cutscene, {dronepitch = 1.5}, "linear")
			susie:setAnimation("jump_fall")
			kris:setAnimation("fall_hurt")
			cutscene.fall_hurt_frame = 0
			Game.world.timer:lerpVar(cutscene, "fall_hurt_frame", 0, 16, 70, 3, "out")
			Game.world.timer:tween(3/30, highlight, {thickness = 1}, "linear")
			Game.world.timer:lerpVar(kris, "y", kris.y, kris.y - 100, 90, 3, "out")
			Game.world.timer:lerpVar(susie, "y", susie.y, susie.y + 20, 90, 3, "out")
			Game.world.timer:tween(120/30, fakehsv, {amount = 1}, "in-cubic")
			Game.world.timer:during(60/30, function()
				kris.sprite.frame = (math.floor(cutscene.fall_hurt_frame % 4) + 1)
			end)
			Game.world.timer:during(120/30, function()
				local highlight_color = ColorUtils.mergeColor(ColorUtils.hexToRGB("#42D0FFFF"), ColorUtils.hexToRGB("#96CD6EFF"), fakehsv.amount)
				highlight:setColor(highlight_color[1], highlight_color[2], highlight_color[3], 1)
			end)
			cutscene:wait(60/30)
			kris.sprite.frame = 1
			kris:setAnimation("fall_hurt_wind")
			cutscene:wait(10/30)
			kris.fall_hurt_frame = nil
			cutscene:wait(110/30)
			local arch = Sprite("effects/foreground_arch_blur", 0, 480)
			arch.layer = 1100
			arch:setParallax(0)
			arch:setScale(2)
			arch:setOriginExact(0, 120)
			arch:setColor(COLORS.black)
			Game.world:addChild(arch)
			Game.world.timer:tween(4/30, arch, {y = 0}, "linear")
			Game.world.timer:tween(32/30, cutscene, {windvol = 0, windpitch = 0.5, dronevol = 0, dronepitch = 0.5}, "linear")
			cutscene:wait(16/30)
			do_ripple = true
			windows:remove()
			prophecies:remove()
			broken_container:remove()
			windsfx:stop()
			dronesfx:stop()
			Assets.playSound("snd_closet_impact")
			kris:setParallax(1)
			susie:setParallax(1)
			kris:removeFX("fakehighlight")
			susie:removeFX("fakehighlight")
			ralsei:removeFX("fakehighlight")
			kris:removeFX("fakehsv")
			susie:removeFX("fakehsv")
			ralsei:removeFX("fakehsv")
			for _, sprite in ipairs(remove) do
				sprite:remove()
			end
			for _, trans in ipairs(Game.world.map:getEvents("transition")) do
				trans.collider.collidable = true
			end
			for _, trans in ipairs(Game.world.map:getEvents("ft_transition")) do
				trans.collider.collidable = true
			end
			arch:remove()
		end	
		kris.x = kris_x
		kris.y = kris_y
		susie.x = susie_x
		susie.y = susie_y
		kris.layer = kris_layer
		susie.layer = susie_layer
		ralsei.layer = ralsei_layer
        Game.world.camera.x = kris_x + (susie_x - kris_x)/2
		Game.world.camera.y = kris_y
        kris:setSprite("landed")
        susie:setSprite("landed")
		local ripple_fx
		if do_ripple then
			kris.layer = 1110
			susie.layer = 1110
			kris:shake(8)
			susie:shake(8)
			kris:setColor(COLORS.black)
			susie:setColor(COLORS.black)
			ripple_fx = RippleEffect()
			ripple_fx.layer = 1101
			Game.world:addChild(ripple_fx)
			ripple_fx:makeRipple(kris_x, kris_y, 100, COLORS.aqua, 220, 1, 18, 1101, 0, 1.05)
			ripple_fx:makeRipple(susie_x, susie_y, 100, COLORS.fuchsia, 220, 1, 18, 1101, 0, 1.05)
		end
        cutscene:wait(120/30)
		if do_ripple then
			kris.layer = kris_layer
			susie.layer = susie_layer
			ralsei.layer = ralsei_layer
			kris:setColor(COLORS.white)
			susie:setColor(COLORS.white)
			ripple_fx:remove()
		end
        Assets.playSound("him_quick")
        cutscene:fadeIn(1)
		Kristal.showBorder(1)
		cutscene:wait(1)
        susie:shake(4, 0, 1)
        Assets.playSound("wing")
        cutscene:wait(1)
        susie:shake(2, 0, 1)
        Assets.playSound("wing")
        susie:shake(1, 0, 1)
        Assets.playSound("wing")
        cutscene:wait(2)
        cutscene:setSpeaker(susie)
        cutscene:text("[facec:susie_bangs/down]* Ngh...[wait:10] what the hell...")
        cutscene:wait(1)
        kris.sprite:setFrame(2)
        susie.sprite:setFrame(2)
        ralsei.sprite:setFrame(2)
		cutscene:wait(3/30)
        kris.sprite:setFrame(3)
        susie.sprite:setFrame(3)
        ralsei.sprite:setFrame(3)
		cutscene:wait(2/30)
		kris:resetSprite()
		susie:resetSprite()
		ralsei:resetSprite()
        cutscene:wait(0.7)
        susie:setFacing("up")
        cutscene:wait(0.7)
        susie:setFacing("right")
        cutscene:wait(0.7)
        susie:setFacing("down")
        cutscene:wait(1.2)
        susie:setFacing("right")
        cutscene:wait(1)
        cutscene:setSpeaker(susie)
        cutscene:wait(1)
        cutscene:text("* ... Hey,[wait:5] where are we, [wait:5] anyways?[wait:5] It looks like the church again,[wait:5] but...", "annoyed_down")
        		Game.world.music:play()
        cutscene:wait(1) 
        susie:setFacing("up")
        cutscene:wait(1)
        cutscene:text("* Kris,[wait:5][func:turn0][wait:5] you're...[wait:10][func:turn] green?[wait:10] And I'm...[wait:10] uh...[wait:5][react:1]", "suspicious", {
            reactions = {
                {"(Uhh... hey, Kris!\nHelp me out here!)", "right", "bottom", "blush", "susie"},
            },
            functions = {
                turn0 = function(text)
                    kris:setFacing("left")
                end,
                turn = function (text)
                    susie:setFacing("right")
                end
            },
        })
        
        local choice = cutscene:choicer({"Blue", "Pink", "Susie"})
        if choice == 1 then
            cutscene:text("* And I'm blue...[wait:5] Got it.", "nervous_side")
            Game:setFlag("susiecolor", "blue")
		elseif choice == 2 then
            cutscene:text("* And I'm pink...[wait:5] Got it.", "nervous_side")
            Game:setFlag("susiecolor", "pink")
		else
			cutscene:text("* [face:nervous_side]And I'm Su-[face:teeth][speed:1.22]I didn't mean my name,[wait:5] dumbass![speed:1]", "nervous_side")
			Game:setFlag("susiecolor", "susie")
        end
        --uhh i'll commit up to this point dont touch this please :3
        susie:walkTo(susie.x - 40, susie.y, 1)
        cutscene:wait(1)
        susie:setSprite("away_hips")
        cutscene:wait(1)
        susie:setFacing("right")
        susie:resetSprite()
        susie:walkTo(susie.x + 60, susie.y, 1)
        cutscene:wait(1)
        cutscene:text("* Hey,[wait:5] wait a second...[wait:5] where's Ralsei?", "surprise_frown")
        cutscene:text("* Did the Knight-", "sad", {auto = true})
        cutscene:setSpeaker(ralsei)
        cutscene:text("[shake:0.51][speed:0.8]* N-[wait:5]No...[wait:5] this can't be...")
        susie:setSprite("shock_left")
        susie:setFacing("left")
        cutscene:setSpeaker(susie)
        cutscene:text("* R-[wait:5]Ralsei!?", "surprise_frown")
        ralsei:resetSprite()
        ralsei:setFacing("up")
        cutscene:attachCamera()
        Game.world.camera.keep_in_bounds = false
        cutscene:wait(cutscene:panTo(220, 360, 2, "out-cubic"))
        susie:resetSprite()
        cutscene:wait(1)
        cutscene:setSpeaker(ralsei)
        cutscene:text("[shake:0.51][speed:0.8]* You may want to come here...", "horror")
        cutscene:text("[shake:0.51][speed:0.8]* (This is bad... [wait:10]No,[wait:5] this is [shake:0.81]VERY[shake:0.31] bad...)", "horror")
        cutscene:wait(cutscene:panTo(kris.x + (susie.x - kris.x)/2, kris.y, 2, "out-cubic"))
        cutscene:attachCamera()
        cutscene:wait(2)
        susie:setFacing("right")
        cutscene:setSpeaker(susie)
        cutscene:text("* We should see how he's doing...", "nervous")
        cutscene:text("* Ralsei sounds...[wait:10] uh...[wait:10] spooked?[wait:10] Terrified?[wait:10] Whatever...", "nervous_side")
        cutscene:walkTo(susie, susie.x-100, susie.y, 1.5)
        cutscene:wait(cutscene:walkTo(kris, kris.x-40, kris.y, 1.7))
        kris:shake(4, 0, 1)
        cutscene:detachCamera()
        kris.flip_x = true --?
        kris.layer = susie.layer - 0.01
        Assets.playSound("wing")
        susie:setFacing("right")
        kris:shake(6, 0, 1)
        susie:setSprite("surprise_step")
        kris:setSprite("sit")
        cutscene:text("* Kris..![wait:10] You okay??", "surprise_frown")
        cutscene:text("* Yeesh,[wait:5] talk about a fall...[wait:10] (Even MY legs hurt a little.)", "dejected")
        susie:resetSprite()
        cutscene:wait(cutscene:walkTo(susie, kris.x-50, susie.y, 1))
        susie:setSprite("heal_kneel")
        cutscene:text("[facec:susie_bangs/down]* Here,[wait:5] hold still.[wait:5]\n* Let me...")
        Assets.playSound("wing")
        susie:setSprite("heal_kneel_arms")
        cutscene:wait(1/2)
        kris:flash()
        susie:flash()
        Game.world.timer:every(1/30, function()
            for i = 1, 2 do
                local x = kris.x + ((love.math.random() * kris.width) - (kris.width / 2)) * 2
                local y = kris.y - (love.math.random() * kris.height) * 2
                local sparkle = HealSparkle(x, y)
                sparkle:setLayer(WORLD_LAYERS["below_ui"])
                sparkle:setColor(COLORS.lime)
                Game.world:addChild(sparkle)
            end
        end, 4)
        Game.world.timer:every(1/30, function()
            for Kristal = 1, 2 do --                    <-- Evil moniey deletr
                local x = susie.x + ((love.math.random() * susie.width) - (susie.width / 2)) * 2
                local y = susie.y - (love.math.random() * susie.height) * 2
                local sparkle = HealSparkle(x, y)
                sparkle:setLayer(WORLD_LAYERS["below_ui"])
                sparkle:setColor(COLORS.lime)
                Game.world:addChild(sparkle)
            end
        end, 4)
        local dmg = DamageNumber("msg", "max",susie.x, susie.y,{COLORS.lime})
        dmg:setLayer(99999999999999999999999999)
        Game.world:addChild(dmg)
        Assets.playSound("power")
        cutscene:wait(1)
        susie:setSprite("heal_kneel")
        cutscene:wait(2)
        cutscene:text("* You,[wait:5] uh...[wait:10] Feel better?", "nervous")
        cutscene:text("* Good.[wait:10] Let's see what Ralsei's so spooked about.", "nervous_side")
        kris.flip_x = false
        Game.world.camera.keep_in_bounds = true
        cutscene:attachCamera()
        susie:resetSprite()
        kris:resetSprite()
        kris.layer = susie.layer
        cutscene:walkTo(susie, "suspoint",3)
        cutscene:wait(cutscene:walkTo(kris, "kpoint",3))
        kris:setFacing("up")
        susie:setFacing("up")
        cutscene:wait(1)
        cutscene:setSpeaker(ralsei)
        cutscene:text("[shake:0.51][speed:0.8]* T-This.. [wait:5]shouldn't be happening...", "concern_smile")
        cutscene:text("[shake:0.51][speed:0.8]* This isn't part of the prophecy...", "concern_smile")
        cutscene:text("[shake:0.51][speed:0.8]* Kris, [wait:5]Susie... [wait:10]We need to seal this fountain.[wait:5] Now...", "concern_smile")
        cutscene:text("[shake:0.51][speed:0.8]* It's been the same as I remember it until now because-", "concern_smile", {auto = true})
        cutscene:text("[shake:0.56][speed:1]* First was the King-", "concern_smile", {auto = true})
        cutscene:text("[shake:0.60][speed:1.1]* And then Queen and her chariot-", "concern_smile", {auto = true})
        cutscene:text("[shake:0.70][speed:1.2]* Then Tenna, [shake:0.85][wait:5]a-[wait:5]and the Knight-", "concern_smile", {auto = true})
        cutscene:text("[shake:0.95]* Just before this was the Titan-", "concern_smile", {auto = true})
        cutscene:text("[shake:1][speed:1.3]* And right now it should be-", "concern_smile", {auto = true})
        cutscene:setSpeaker(susie)
        cutscene:text("* Hang on a sec,[wait:5] it's not in the prophecy...", "suspicious")
        cutscene:text("* And it says the Knight didn't do it?", "suspicious")
        cutscene:text("* Heh.[wait:10] Suuuure.[wait:10] Guess that's just another opportunity to-", "closed_grin", {auto = true})
        cutscene:setSpeaker(ralsei)
        cutscene:text("* Susie,[wait:5] no![wait:5] Please,[wait:5] don't break it!", "concern")
        cutscene:text("* I'd... [wait:5]rather you not get hurt.", "pensive")
        cutscene:wait(1/2)
        susie:setFacing("right")
        cutscene:wait(1/2)
        cutscene:setSpeaker(susie)
        cutscene:text("* ...", "nervous_side")
        cutscene:text("* Fine.", "nervous_side")
        susie:setSprite("walk_back_arm/right")
        susie.sprite:play(1/5, true)
        cutscene:wait(cutscene:slideTo(susie, "suspoint2",3))
        susie:setSprite("walk_back_arm/right_1")
        cutscene:text("* What a load of junk. [wait:5][face:smile]Are we REALLY gonna fall for this?", "closed_grin")
        cutscene:text("* Let's go.", "smile")
        
        susie:resetSprite()
        cutscene:attachFollowers()
        for _, save in ipairs(Game.world.map:getEvents("savepoint")) do
            save.visible = true
        end
        kris:setFacing("down")
    end,
    lobby = function(cutscene)
        local man = cutscene:getCharacter("lobbyman")
        local susie, ralsei, kris = cutscene:getCharacter("susie"),cutscene:getCharacter("ralsei"),cutscene:getCharacter("kris")

        cutscene:setSpeaker(man)
        cutscene:text("* Hello. [wait:5]I am the Lobby Man.")
        local function choicebox()
            local choice = cutscene:choicer({"Where am I?", "What happened?", "Who are you?", "Bye"})
            if choice == 1 then
                cutscene:text("* You are in the Base Sanctum.")
                cutscene:text("* Here, [wait:5]you may explore and discover new sanctuaries.")
                choicebox()
            elseif choice == 2 then
                cutscene:text("* That is beyond my knowledge.")
                cutscene:text("* I can only assume that someone had opened too many fountains...?")
                cutscene:text("* This can probably support your coloring.")
                choicebox()
            elseif choice == 3 then
                cutscene:text("* I am the Lobby Man.")
                choicebox()
            elseif choice == 4 then
                cutscene:text("* bye")
                Assets.playSound("snd_mysterygo")
                Game.world.timer:tween(0.75, man, {alpha = 0, scale_x = 1, scale_y = 3}, 'out-circ')
                cutscene:wait(2)
                cutscene:setSpeaker(susie)
                cutscene:text("* ...", "annoyed_b")
                man:remove()
            end
        end

        choicebox()
    end,
    titan = function (cutscene)
        local sus = Game.world:spawnNPC('titan',1020,390)
        sus:setAnimation("full")
        sus.alpha = 0
        cutscene:wait(1)
        Game.world.timer:tween(2, sus, {alpha = 1})
        cutscene:wait(4)
        Game.world.timer:after(2, function()sus:remove()end)
        cutscene:startEncounter("titan", true, sus)
    end,
    prefall = function (cutscene)
        if Game:hasPartyMember("jamm") then
            local j = cutscene:getCharacter("jamm")
            cutscene:setSpeaker(j)
            cutscene:text("* Hey, [wait:5]you guys can go ahead.", "neutral")
            cutscene:text("* I think I dropped something.", "neutral")
            if j.x > 920 and j.y > 640 then
                cutscene:wait(cutscene:walkTo(j, "j-detour", 1))
            end
            Game.lock_movement = false
            cutscene:walkTo(j, "jammgoesbyebye", 2)
            j.following = false
        end
    end,
    fall = function (cutscene)
        local ral = cutscene:getCharacter("ralsei")
        local sus = cutscene:getCharacter("susie")
        local no = cutscene:getCharacter("noelle")
        local kris = cutscene:getCharacter("kris")
        local j = cutscene:getCharacter("jamm")
        cutscene:detachFollowers()
        cutscene:setSpeaker("susie")
        cutscene:text("* (Kris, [wait:5]look! [wait:10]It's Noelle!)", "blush")
        cutscene:wait(cutscene:walkTo(sus, "spoint"))
        cutscene:wait(1)
        no:shake(2,0)
        cutscene:slideTo(no, "npoint", 1, 'out-circ')
        no:setSprite("scare")
        no:play(1/15, true)
        Assets.playSound("noscared")
        sus:setSprite("point_left")
        cutscene:text("* Hey, [wait:5]Noelle!", "sincere_smile", {auto = true})
        Game.world.music:pause()
        Assets.playSound("snd_sussurprise")
        sus:setSprite("shock_left")
        sus:shake(4, 0, 1)
        cutscene:text("* Uh-", "shock")
        no:play(1/15, false)
        cutscene:wait(1)
        no:setSprite("shocked")
        cutscene:wait(0.25)
        Game.world.timer:tween(1, no, {y = no.y + 200, x = no.x - 50, rotation = math.rad(-45)}, 'in-circ')
        sus:resetSprite()
        cutscene:walkTo(sus, "spoint2")
                cutscene:walkTo(ral, "rpoint")
        cutscene:walkTo(kris, "kpoint")
        cutscene:fadeOut(1, {music = false})
        cutscene:text("* Wait, [wait:5]NOELLE!", "surprise_frown")
        cutscene:wait(1)
        Assets.playSound("snd_closet_fall")
        local img = Sprite("falling-n")
        img:setOrigin(0.5, 0.75)
        img:setParallax(0)
        img.layer = 1000
        img.x, img.y = SCREEN_WIDTH/2, SCREEN_HEIGHT-150
        Game.world:addChild(img)
        img:setScale(0.5)
        Game.world.timer:tween(4, img, {scale_x = 0, scale_y = 0}, "out-circ")
        cutscene:wait(4)
        img:remove()
        Assets.playSound("snd_closet_impact")
        cutscene:wait(3)
        cutscene:text("[voice:echo][speed:0.25][shake:0.52]* Noelle?! [wait:10]Are you okay?!")
        cutscene:text("[voice:echo][speed:0.25][shake:0.52]* Can you hear me?!")
        cutscene:wait(1)
        Game.world.music:play()
        cutscene:fadeIn(1, {music = false})
        sus:setSprite("shock_down_flip_1")
        cutscene:wait(1)
        cutscene:setSpeaker(sus)
        cutscene:text("* D-Did-", "surprise_frown")
        cutscene:text("* Did Noelle just die?!", "surprise_frown")
        cutscene:text("* DID I KILL NOELLE?!", "shock_nervous")
        cutscene:setSpeaker(ral)
        cutscene:text("* W-Well Susie, [wait:5]um...", "surprise_confused")
        cutscene:text("* I think she's... [wait:5]okay? [wait:10]It doesn't seem like falling here would...", "surprise_neutral_side")
        cutscene:wait(1/2)
        ral:setFacing("down")
        cutscene:text("* ...work normally.", "surprise_confused")
        cutscene:wait(1/2)
        sus:resetSprite()
        sus:setFacing("right")
        cutscene:wait(1/2)
        cutscene:setSpeaker(sus)
        cutscene:text("* Uh, [wait:5]Kris?", "nervous")
        cutscene:text("* You okay? [wait:10]You look freaked out...", "nervous")
        cutscene:text("* (Ralsei, [wait:5]are humans supposed to breathe like that?)", "suspicious")
        cutscene:setSpeaker(ral)
        cutscene:text("* (...)", "frown")
        if Game:hasPartyMember("jamm") then
            j.x, j.y = 760, 640
        end
        cutscene:attachFollowers()
        Game:setFlag("noellefall", true)
    end,
    jamm = function (cutscene)
        local j = cutscene:getCharacter("jamm")
        local ral = cutscene:getCharacter("ralsei")
        local sus = cutscene:getCharacter("susie")
        j:shake(2, 0, 0.5)
        Assets.playSound("wing")
        cutscene:wait(1)
        j:shake(2, 0, 0.5)
        Assets.playSound("wing")
        cutscene:wait(1)
        j:shake(2, 0, 0.5)
        Assets.playSound("wing")
        cutscene:wait(1)
        Assets.playSound("wing")
        j:setSprite("walk/down_1")
        cutscene:detachFollowers()
        cutscene:setSpeaker(sus)
        cutscene:text("* ", "shock")
        cutscene:text("* ", "shock_nervous")
        cutscene:text("* Ralsei, [wait:5]are you seeing th ", "shock_nervous", {auto = true})
        cutscene:setSpeaker(ral)
        cutscene:text("* Yes Susie, [wait:5]I'm seeing this.", "surprise_confused")
        cutscene:wait(0.5)
        j:resetSprite()
        j:setFacing("left")
        cutscene:wait(0.5)
        cutscene:setSpeaker(j)
        cutscene:text("* I have ears, [wait:5]you know.", "suspicious")
        cutscene:text("* Give me [wave]one[wave:0] good reason not to shoot you in the eye.", "suspicious")
        cutscene:setSpeaker(sus)
        cutscene:text("* ", "shock")
        cutscene:text("* ", "shock_nervous")
        cutscene:text("* Well", "shock", {auto = true})
        cutscene:text("* Um", "shock_nervous", {auto = true})
        cutscene:text("* I", "shock", {auto = true})
        cutscene:text("* Uhhhh", "shock_nervous", {auto = true})
        cutscene:text("* Well", "shock", {auto = true})
        cutscene:text("* Uhm", "shock_nervous", {auto = true})
        cutscene:text("* HMmmuhh", "shock", {auto = true})
        cutscene:text("* I", "shock", {auto = true})
        cutscene:text("* Um", "shock_nervous", {auto = true})
        cutscene:text("* Uh", "shock", {auto = true})
        cutscene:setSpeaker(ral)
        cutscene:text("* Mister, [wait:10]um...", "pleased")
        cutscene:setSpeaker(j)
        if Game:getFlag("fun") == 86 then
            cutscene:text("* Jamm. [wait:10]AcousticJamm.[wait:30][react:1]", "suspicious", {reactions = {
                {"I am the real AcousticJamm \nplay Deoxynn please please plea", "middle", "bottommid", "shades", "jamm"},
            }})
        else
            cutscene:text("* Jamm.", "suspicious")
        end
        cutscene:setSpeaker(ral)
        cutscene:text("* W-Well, [wait:5]Mister Jamm!...", "pleased")
        cutscene:text("* We're just trying to find our way out of this Dark World!", "pleased")
        cutscene:wait(1)
        cutscene:setSpeaker(j)
        cutscene:text("* [wait:30]..Uuh[wait:3]h[wait:3]h huh.", "suspicious")
        cutscene:text("* How funny. [wait:10]I'm also trying to find my way outta here.", "suspicious")
        if Game:getFlag("route") == 1 or Game:getFlag("route") == 2 then
            cutscene:text("* You guys don't look like murderers, [wait:5]either...", "look_left")
            cutscene:text("* Guess my best bet is coming with you.", "neutral")
        elseif Game:getFlag("route") == 3 then
            cutscene:text("* You guys look a little confused.", "look_left")
            cutscene:text("* Especially you, [wait:5]the one in front.", "look_left")
            cutscene:text("* Trust me, [wait:5]I also want to get out as quick as possible.", "neutral")
            cutscene:text("* My best bet is coming with you.", "neutral")
        end
        cutscene:wait(1/3)
        Game.world.music:pause()
        cutscene:setSpeaker(nil)
        Assets.playSound("joined")
        cutscene:text("* Jamm joined your party.")
        cutscene:wait(1)
        cutscene:setSpeaker(j)
        cutscene:text("* Oh, [wait:5]lemme do a meta thing real quick.", "neutral")
        cutscene:setSpeaker(ral)
        cutscene:text("* Wait, [wait:5]what are you doi", "surprise_confused", {auto = true})
                cutscene:setSpeaker(nil)
                Assets.playSound("cd_bagel/kris")
        cutscene:text("* Jamm increased the party limit.[wait:15][react:1][react:2]", {reactions = {
            {" ", "right", "bottommid", "shock", "susie"},
            {" ", "middle", "bottommid", "shock_smile","ralsei"}}})
        cutscene:wait(1/2)
        j:convertToFollower()
        cutscene:attachFollowers()
        Game:setFlag("jamm_join", true)
        Game:addPartyMember("jamm", #Game.party+1)
        Game.world.music:play()
    end
}
