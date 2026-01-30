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
		local kris_y = kris.y
		local susie_y = susie.y
		local ralsei_y = ralsei.y
        centerText(
            "Hello.[wait:10]\n\n" ..
            "Just a fair warning before proceeding.[wait:10]\n" ..
            "The Dark, [wait:5]Second, [wait:5]and Third Sanctuaries are not recreations of\nDELTARUNE Chapter 4's maps. [wait:10]\n\n" ..
            "#th Sanctuary is meant to be enjoyed at your own pace.[wait:10]\nPlease, [wait:5]enjoy yourself.")
        cutscene:wait(1)
        cutscene:text("* Which route do you desire?")
        local ch = cutscene:choicer({"Pacifist", "Violent", "Weird"})
        
        Game:setFlag("route", ch)
        if ch == 1 or ch == 2 then
            Assets.playSound("ui_spooky_action")
        elseif ch == 3 then
            Assets.playSound("ominous")
        end
        cutscene:wait(3)
        Assets.playSound("ch4_first_intro", 1, 1)
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
		local heart = Sprite("logo_heart")
        heart:setScale(2)
		heart:setParallax(0)
		heart:setOrigin(0.5, 0.5)
		heart.layer = 1000 + 1
		heart.noprop = true
        Game.world:addChild(heart)
        heart.x = 85 + 224
        heart.y = SCREEN_HEIGHT/2 - 34
        table.insert(remove, heart)
		local grad = Sprite("logo_gradient")
        grad:setScale(2)
        grad:setParallax(0)
        grad:setOrigin(0.5, 0.5)
        grad.layer = 1000 + 1
        grad.noprop = true
        grad.alpha = 0
        Game.world:addChild(grad)
        grad.x = 85 + 224
        grad.y = SCREEN_HEIGHT/2 - 34
        table.insert(remove, grad)
        cutscene:wait(4.5) --(no longer) evil
        Game.world.timer:tween(1, grad, {alpha = 1}, "linear")
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
				sprite:addFX(ProphecyScrollFX(nil, 2), "prop")
				sprite:addFX(AlphaFX(0.7, 1), "alpha")
			end
        end
        cutscene:wait(9.3)
        cutscene:detachFollowers()
		local kris_layer = kris.layer
		local susie_layer = susie.layer
		local ralsei_layer = ralsei.layer
        for _, trans in ipairs(Game.world.map:getEvents("transition")) do
            trans.collider.collidable = false
        end
        for _, trans in ipairs(Game.world.map:getEvents("ft_transition")) do
            trans.collider.collidable = false
        end
		kris.layer = a.layer + 1
		susie.layer = a.layer + 1
		ralsei.layer = a.layer + 1
		kris.y = Game.world.camera.y - SCREEN_HEIGHT - 40
		susie.y = Game.world.camera.y - SCREEN_HEIGHT - 40
		ralsei.y = Game.world.camera.y - SCREEN_HEIGHT - 40	
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
		kris:addFX(fakehsv, "fakehsv")
		susie:addFX(fakehsv, "fakehsv")
		ralsei:addFX(fakehsv, "fakehsv")
        kris:setSprite("ball")
        susie:setSprite("ball")
        ralsei:setSprite("ball")
		cutscene:slideTo(kris, kris.x, kris_y, 14/30)
		cutscene:slideTo(susie, susie.x, susie_y, 14/30)
		cutscene:slideTo(ralsei, "ralpoint",0.01)
		cutscene:wait(10/30)
		Assets.playSound("dtrans_flip")
        kris:setSprite("landed")
        susie:setSprite("landed")
        ralsei:setSprite("landed")
		kris:shake(2)
		susie:shake(2)
		ralsei:shake(2)
		local snd = ComplexSoundUpdater(0,0,-1)
        Game.world:addChild(snd)
        snd.complexsnd:add(1, "break1", 1, 0.95, 0, -1, 0)
        snd.complexsnd:add(2, "glassbreak", 0.6, 0.4, 2, -1, 0)
        snd.complexsnd:add(3, "punchmed", 0.7, 0.95, 0, -1, 0)
        snd.complexsnd:play()
        Assets.stopSound("ch4_first_intro")
		Assets.playSound("ch4_first_intro_breaking", 0.5, 0.5)
		Assets.playSound("ch4_first_intro_breaking", 0.5, 0.44)
        for _, sprite in ipairs(remove) do
            sprite:remove()
        end
        for i = 1,94 do
            local letter = Sprite("logo_shatter/logo_piece_"..i)
            letter:setScale(2)
            letter:setParallax(0)
            letter:setOrigin(0.5, 0.5)
			letter.physics.direction = math.rad(MathUtils.random(360))
			letter.physics.gravity = 0.4 + MathUtils.random(0.12)
			letter.physics.friction = 0
			letter.physics.speed = 4
            letter.layer = 1000
            Game.world:addChild(letter)
            letter.x = 85 + 224
            letter.y = SCREEN_HEIGHT/2 - 34
            table.insert(remove, letter)
        end
		a.physics.gravity = 0.5
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
        cutscene:wait(3)
        Assets.playSound("him_quick")
        cutscene:fadeIn(1)
        Game.world.timer:tween(1, a, {alpha = 0})
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
		kris.layer = kris_layer
		susie.layer = susie_layer
		ralsei.layer = ralsei_layer
		kris:resetSprite()
		susie:resetSprite()
		ralsei:resetSprite()
		kris:removeFX("fakehsv")
		susie:removeFX("fakehsv")
		ralsei:removeFX("fakehsv")
        for _, trans in ipairs(Game.world.map:getEvents("transition")) do
            trans.collider.collidable = true
        end
        for _, trans in ipairs(Game.world.map:getEvents("ft_transition")) do
            trans.collider.collidable = true
        end
        a:remove()
        for _, sprite in ipairs(remove) do
            sprite:remove()
        end
		snd:remove()
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
        for _, shard in ipairs(shards_remove) do
            shard:remove()
        end
		a:remove()
        cutscene:text("* ... Hey,[wait:5] where are we, [wait:5] anyways?[wait:5] It looks like the church again,[wait:5] but...", "annoyed_down")
        		Game.world.music:play()
        cutscene:wait(1) 
        susie:setFacing("up")
        cutscene:wait(1)
        cutscene:text("* Kris,[wait:5] you're...[wait:10][func:turn] green?[wait:10] And I'm...", "suspicious", {
            functions = {
                turn = function (text)
                    kris:setFacing("left")
                    susie:setFacing("right")
                end
            }
        })
        local choice = cutscene:choicer({"Blue", "Pink"})
        if choice == 1 then
            cutscene:text("* And I'm blue...[wait:5] Got it.", "nervous_side")
            Game:setFlag("susiecolor", "blue")
        else
            cutscene:text("* And I'm pink...[wait:5] Got it.", "nervous_side")
            Game:setFlag("susiecolor", "pink")
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
        cutscene:text("[shake:0.31][speed:0.8]* N-[wait:5]No...[wait:5] this can't be...")
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
        cutscene:text("[shake:0.31][speed:0.8]* You may want to come here...", "horror")
        cutscene:text("[shake:0.31][speed:0.8]* (This is bad... [wait:10]No,[wait:5] this is [shake:0.81]VERY[shake:0.31] bad...)", "horror")
        cutscene:wait(cutscene:panTo(Game.world.player.x, 360, 2, "out-cubic"))
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
        cutscene:wait(cutscene:walkTo(susie, kris.x-70, susie.y, 1))
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
        cutscene:text("[shake:0.31][speed:0.8]* T-This.. [wait:5]shouldn't be happening...", "concern_smile")
        cutscene:text("[shake:0.31][speed:0.8]* This isn't part of the prophecy...", "concern_smile")
        cutscene:text("[shake:0.31][speed:0.8]* Kris, [wait:5]Susie... [wait:10]We need to seal this fountain.[wait:5] Now...", "concern_smile")
        cutscene:text("[shake:0.31][speed:0.8]* It's been the same as I remember it until now because-", "concern_smile", {auto = true})
        cutscene:text("[shake:0.31][speed:1]* First was the King-", "concern_smile", {auto = true})
        cutscene:text("[shake:0.31][speed:1.1]* And then Queen and her chariot-", "concern_smile", {auto = true})
        cutscene:text("[shake:0.31][speed:1.2]* Then Tenna, [wait:5]a-[wait:5]and the Knight-", "concern_smile", {auto = true})
        cutscene:text("[shake:0.31]* Just before this was the Titan-", "concern_smile", {auto = true})
        cutscene:text("[shake:0.31][speed:1.3]* And right now it should be-", "concern_smile", {auto = true})
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
