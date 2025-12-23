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
        susie.x = susie.x - 70
        ralsei.x = ralsei.x + 70
		local kris_y = kris.y
		local susie_y = susie.y
		local ralsei_y = ralsei.y
        centerText(
            "Hello.[wait:10]\n\n" ..
            "Just a fair warning before proceeding.[wait:10]\n" ..
            "The Dark, [wait:5]Second, [wait:5]and Third Sanctuaries are not recreations of\nDELTARUNE Chapter 4's maps. [wait:5]\n\nI do not want to get sued.[wait:10]\n\n" ..
            "#th Sanctuary is meant to be enjoyed at your own pace.[wait:10]\nPlease, [wait:5]enjoy yourself.")
        cutscene:wait(1)
        local remove = {}
        local sum = 85
        for i = 1,9 do
            local letter = Sprite("logo_letter_"..i)
            letter:setScale(2)
            letter:setParallax(0)
            letter:setOrigin(0, 1)
            letter.layer = 1000
            Game.world:addChild(letter)
            letter.x = sum
            letter.y = SCREEN_HEIGHT/2
            Assets.playSound("noise")
            cutscene:wait(1/15)
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
        Game.world:addChild(grad)
        grad.x = 85 + 224
        grad.y = SCREEN_HEIGHT/2 - 34
        table.insert(remove, grad)
        cutscene:wait(1)
        local a = Text("#th Sanctuary")
        a.layer = 1000
        a:setOrigin(0, 0)
        a:setScale(2)
        a.x, a.y = 140, 244
		a:addFX(ProphecyScrollFXAlt(3), "prop")
        Game.stage:addChild(a)
        Assets.playSound("bell_bounce_short")
        for _, sprite in ipairs(remove) do
			if not sprite.noprop then
				sprite:addFX(ProphecyScrollFX(nil, 2), "prop")
				sprite:addFX(AlphaFX(0.7, 1), "alpha")
			end
        end
        cutscene:wait(2)
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
		cutscene:slideTo(ralsei, ralsei.x, ralsei_y, 14/30)
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
        cutscene:wait(1)
        Assets.playSound("him_quick")
        cutscene:fadeIn(1)
        Game.world.timer:tween(1, a, {alpha = 0})
		Kristal.showBorder(1)
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
		cutscene:wait(1/30)
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
        cutscene:wait(0.5)
        cutscene:setSpeaker(susie)
        Assets.playSound("whip_hard")
        susie:setSprite("exasperated_right")
        susie:shake(3,nil, nil)
        cutscene:wait(1)
        for _, shard in ipairs(shards_remove) do
            shard:remove()
        end
		a:remove()
		Game.world.music:play()
        cutscene:text("* God [wait:5]DAMN IT Kris, [wait:10]where are we this time?!", "teeth_b")
        susie:resetSprite()
        susie:walkTo(susie.x - 40, susie.y, 1)
        cutscene:wait(1)
        susie:setSprite("away_hips")
        cutscene:wait(0.5)
        cutscene:setSpeaker(ralsei)
        cutscene:text("* It...[wait:5] Feels like the church...", "roaring")
        susie:resetSprite()
        cutscene:walkTo(susie, "suspoint",2)
        cutscene:text("* But at the same time, [wait:5]not really.", "roaring")
        cutscene:wait(2)
        susie:setFacing("up")
        cutscene:setSpeaker(susie)
        cutscene:text("* Uh... [wait:5]Guys?", "nervous")
        cutscene:text("* You, [wait:5]uh. [wait:10]Might wanna check this out.", "nervous_side")
        cutscene:walkTo(ralsei, "ralpoint",3)
        cutscene:wait(cutscene:walkTo(kris, "kpoint",3))
        kris:setFacing("up")
        ralsei:setFacing("up")
        cutscene:wait(1)
        cutscene:setSpeaker(ralsei)
        cutscene:text("* Wh... [wait:5]What is this...?", "concern")
        cutscene:text("[shake:0.51][speed:0.62]* This isn't... [wait:10]Part of the prophecy...", "concern_smile")
        cutscene:wait(1)
        cutscene:setSpeaker(susie)
        cutscene:text("* It's not in the prophecy... [wait:10]and says the Knight didn't do it?", "suspicious")
        cutscene:text("* Heh.[wait:10]", "closed_grin", {auto = true})
        cutscene:setSpeaker(ralsei)
        cutscene:text("* Don't break it!", "concern")
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
    fall = function (cutscene)
        local ral = cutscene:getCharacter("ralsei")
        local sus = cutscene:getCharacter("susie")
        local no = cutscene:getCharacter("noelle")
        local kris = cutscene:getCharacter("kris")
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
        cutscene:text("* You guys don't look like murderers, [wait:5]either...", "look_left")
        cutscene:text("* Guess my best bet is coming with you.", "neutral")
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
