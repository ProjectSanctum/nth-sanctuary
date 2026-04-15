return {
    boid = function (cutscene)
        local boid = cutscene:getCharacter("boid")
        if Kristal.PluginLoader and next(Kristal.PluginLoader.plugin_scripts) ~= nil then
            cutscene:text("* Hi.[wait:5] I'm so sorry for what I've done.")
            if Game:getFlag("fun") == 66 then
                Assets.playSound("snd_mysterygo")
                boid:remove()
                Game:setFlag("hyperboid_dies_real_2027", true)
            end
        else
            cutscene:text([[
* Hey.[wait:5] I'm supposed to say[wait:5] "I need some generic NPC dialogue," but that's not really my thing."
]])
        end
    end,
    clean = function(cutscene)
        local h = Game.inventory:hasItem("rake")
        local a = Game:getFlag("cleanup") if a then return end
        if h then
            cutscene:text("* (The glass shards that fell off this tree look like leaves.)")
            cutscene:text("* (...[wait:5]Well, [wait:5]you happen to have a rake.)")
            cutscene:text("* (Do janitor things?)")
            local ch = cutscene:choicer({"Yes", "No"})
            if ch == 1 then goto clean else
                cutscene:text("* (And they shall remain.)")
                return
            end
            ::clean::
            cutscene:fadeOut(1)
            for i = 1, 4 do
                cutscene:wait(20/30)
                Assets.playSound("leaf_dodge")
            end
            local glass = Game.world.map:getEvent(11)
            cutscene:text("* (You used the rake to clean up the glass shards.)")
            cutscene:text("* (...Well, [wait:5]you did your best, [wait:5]but there is no trash bin.)")
            cutscene:text("* (Reluctantly,[wait:5] you sweep them off the side of the platform.)")
            cutscene:wait(1)
            glass:remove()
            cutscene:fadeIn(1)
            cutscene:text("* (But, [wait:5]one leaf looked to remain. [wait:10]One you forgot.)")
            cutscene:text("* (Unlike the others, [wait:5]this one is black in color.)")
            cutscene:text("* (It twinges with a strange energy...)")
            cutscene:text("* (You pick it up, [wait:5]and realize it's a [color:9999ff]Dark Shard.[color:white].)")
            Assets.playSound("shard_get")
			cutscene:text("* (You obtained a [color:9999ff]Dark Shard.[color:white])")
			Mod:setDarkShard(Mod.DarkShardID.LeafRoomShard, true)
            Game:setFlag("cleanup", true)
        else
            cutscene:text("* (The glass shards that fell off this tree look like leaves.)")
        end
    end,
    sans = function(cutscene)
        local sans = cutscene:getCharacter("sans")
        local flag = Game:getFlag("got_rake")
        cutscene:setSpeaker(sans)
        if not flag then
            cutscene:text("* heya.", "neutral")
            cutscene:text("* someone gotta babysit these kids.", "look_left")
            cutscene:text("* actually, [wait:5]want a rake? [wait:10][face:wink]don't need it anymore.", "neutral")
            local ch = cutscene:choicer({"Yes", "No"})
            if ch == 1 then
                cutscene:text("* here. [wait:5]have fun.", "neutral")
                Game.inventory:addItem("sound_stone")
                cutscene:setSpeaker()
                Assets.playSound("item")
                cutscene:text("* You got a Rake.")
                Game:setFlag("got_rake", true)
                Game.inventory:addItem("rake")
            else
                cutscene:text("* well, [wait:5]if you're sure...", "neutral")
                cutscene:text("* just don't come back when you're raked from whatever you're doing.", "joking")
            end
        else
            cutscene:text("* heya.", "neutral")
            cutscene:text("* someone gotta babysit these kids.", "look_left")
            cutscene:text("* enjoying the rake? [wait:10][face:wink]it really isn't one to be leafed alone.", "neutral")
        end
        
        
    end,
    sans2 = function(cutscene)
        local sans = cutscene:getCharacter("sans")
        local flag = Game:getFlag("got_rake")
        cutscene:setSpeaker(sans)
        if not flag then
            cutscene:text("* heya.", "neutral")
            cutscene:text("* someone gotta babysit these kids.", "look_left")
        else
            cutscene:text("* heya.", "neutral")
            cutscene:text("* someone gotta babysit these kids.", "look_left")
            cutscene:text("* actually, [wait:5]want a rake? [wait:10][face:wink]don't need it anymore.", "neutral")
            cutscene:text("* ...i gave it to you already? [wait:10][face:joking]i can't beleaf this.", "neutral")
        end
        
        
    end,

    untroll = function (cutscene)
        local get = Game:getFlag("untroll_moss")
        if not get then
            Game.world.music.volume = 0
            Assets.playSound("moss_fanfare",1, 1.25)
            cutscene:text("* You found the [color:green]Moss!")
            Game.inventory:addItem("moss")
            Game.world.timer:tween(1, Game.world.music, {volume = 1})
            Game:setFlag("untroll_moss", true)
            Game:setFlag("trolled", false)
            Game:setFlag("#citadel_room2#6:opened", false)
        elseif get == true then
            cutscene:text("* (You already got the moss.)")
            Game:setFlag("#citadel_room2#6:opened", false)
            Game:setFlag("trolled", false)
        end
    end,

    mason = function (cutscene)
        local intMason = Game:getFlag("intMason", 0)
        local belch = Game:getFlag("belch", false)
        local belch2 = Game:getFlag("belch2", false)
        local belch3 = Game:getFlag("belch3", false)
        local mason = cutscene:getCharacter("mason")
        if not belch then
            if intMason >= 1 then
                cutscene:text("> i am still mason.[wait:5] im in a very [gold]golden[gold:ungold] mood right now.", { indent_string = "> " }, mason)
                cutscene:text("> let me just tell you again to please do not mention the [color:red]belch.plorgius[color:reset].", { indent_string = "> " }, mason)
                local ch = cutscene:choicer({"Mention", "Do Not"})
                if ch == 2 then
                    cutscene:text("> most people would've mentioned it by now.[wait:5] thank you for not.", { indent_string = "> " }, mason)
                    cutscene:text("> here's your terrific prize:[wait:10]\n> [rainbow]New Future![rainbow:unrainbow]", { indent_string = "> " }, mason)
                else
                    mason:setSprite("fell")
                    Assets.playSound("noise")
                    Assets.playSound("bump")
                    cutscene:wait(0.5)
                    cutscene:text("> owww...[wait:5] the horrors of the [color:red]belch.plorgius[color:reset]...", { indent_string = "> " }, mason)
                    Game:setFlag("belch", true)
                end
            else
                cutscene:text("> i am mason.[wait:5] im in a very [gold]golden[gold:ungold] mood right now.", { indent_string = "> " }, mason)
                cutscene:text("> but please do not mention the [color:red]belch.plorgius[color:reset].", { indent_string = "> " }, mason)
                cutscene:text("> things you can mention include:[wait:5] [color:#ffb467]funnyfeline[color:reset],[wait:5] deltarune,[wait:5] undertale,[wait:5] [color:#0085fa]tts bot[color:reset],[wait:5] etc.", { indent_string = "> " }, mason)
                cutscene:text("> [rainbow]New Future![rainbow:unrainbow]", { indent_string = "> " }, mason)
            end
        elseif not belch2 then
            cutscene:text("> why would you do this to me.", { indent_string = "> " }, mason)
            cutscene:text("> please dont mention it again.", { indent_string = "> " }, mason)
            local ch = cutscene:choicer({"Mention", "Do Not"})
            if ch == 2 then
                cutscene:text("> ... thank you.", { indent_string = "> " }, mason)
            else
                Game:setFlag("belch2", true)
                Game:saveQuick()
                Game:gameOver(Game.world.player.x, Game.world.player.y)
            end
        elseif not belch3 then
            cutscene:text("> man WHAT did I tell you about not mentioning it.", { indent_string = "> " }, mason)
            local ch = cutscene:choicer({"Mention", "Do Not"})
            if ch == 2 then
                cutscene:text("> ... are you really thinking about saying it again?", { indent_string = "> " }, mason)
            else
                Game:setFlag("belch3", true)
                Game:saveQuick()
                Game:gameOver(Game.world.player.x, Game.world.player.y)
            end
        else
            cutscene:text("> so did you hear about the belch.plorgius from that man in hell?", { indent_string = "> " }, mason)
            cutscene:text("> good.", { indent_string = "> " }, mason)
            local ch = cutscene:choicer({"Mention", "Do Not"})
            if ch == 2 then
                cutscene:text("> ... are you really thinking about saying it again?", { indent_string = "> " }, mason)
            else
                Game:saveQuick()
                Game:gameOver(Game.world.player.x, Game.world.player.y)
            end
        end
        Game:setFlag("intMason", intMason + 1)
    end,

	ddelta = function(cutscene)
        local ddelta = cutscene:getCharacter("ddelta")
		cutscene:text("[image:ui/ddelta_asterisk]ddelta here, i helped\n code this lil game!", "aha", ddelta)
		cutscene:text("[image:ui/ddelta_asterisk]ask me anything will ya", "neutral", ddelta)
        local ch = cutscene:choicer({"Can you\nturn into\na prism", "Ask about\nlore", "Nah"}, {offset_y_1 = -32})
		if ch == 1 then
			if Game:getFlag("ddeltaPrismed", false) then
				cutscene:text("[image:ui/ddelta_asterisk]nah,[wait:5] not doing it twice", "lookdown", ddelta)
			else
				cutscene:text("[image:ui/ddelta_asterisk]hey,[wait:5] i only did that\n ONCE as a joke.", "neutral", ddelta)
				cutscene:text("[image:ui/ddelta_asterisk]i don't do it all the\n time yknow", "lookdown", ddelta)
				cutscene:text("[image:ui/ddelta_asterisk](and technically me\n turning into a prism\n isn't even canon...)", "helpme", ddelta)
				local ch = cutscene:choicer({"Do it anyway", "Okay"})
				if ch == 1 then
					cutscene:text("[image:ui/ddelta_asterisk]alright, fiiiine, i'll do\n it", "helpme", ddelta)
					Game.world.music:pause()
					local dd_y = ddelta.y
					Assets.playSound("3dprism_appear")
					local wave_mag = 0
					local function getFXWaveMag()
						return wave_mag
					end
					ddelta:addFX(ShaderFX("wave_interlace", {
						["wave_sine"] = function () return Kristal.getTime() * 100 end,
						["wave_mag"] = function () return getFXWaveMag() end,
						["wave_height"] = 2,
						["texsize"] = { SCREEN_WIDTH, SCREEN_HEIGHT }
					}), "funky_mode")
					Game.world.timer:during(15/30, function()
						ddelta.y = MathUtils.lerp(ddelta.y, dd_y - 40, 0.125)
						wave_mag = MathUtils.lerp(wave_mag, 120, 0.125)
					end)
					cutscene:wait(15/30)
					wave_mag = 60
					prism_sprite = Sprite("enemies/3d/idle", ddelta.x, dd_y)
					prism_sprite:setLayer(ddelta.layer)
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
					ddelta.visible = false
					Game.world.timer:during(15/30, function()
						wave_mag = MathUtils.lerp(wave_mag, 0, 0.25)
					end)
					cutscene:wait(15/30)
					wave_mag = 0
					cutscene:wait(2)
					prism_sprite:remove()
					ddelta.y = dd_y
					ddelta.visible = true
					Assets.stopSound("3dprism_appear")
					Game.world.music:resume()
					cutscene:text("[image:ui/ddelta_asterisk]there ya go!", "lookup", ddelta)
					cutscene:text("[image:ui/ddelta_asterisk]i'm not doing that again\n by the way", "helpme", ddelta)
					Game:setFlag("ddeltaPrismed", true)
				end
			end
		elseif ch == 2 then
			cutscene:text("[image:ui/ddelta_asterisk]funny story i actually\n don't know the lore much\n either", "neutral", ddelta)
			cutscene:text("[image:ui/ddelta_asterisk]i do the coding,[wait:5] not the\n story", "lookup", ddelta)
			cutscene:text("[image:ui/ddelta_asterisk]ya got the wrong guy for\n this one,[wait:5] sorry", "lookdown", ddelta)
		end
	end,
    mangle = function (cutscene, event)
        cutscene:text("* (Join it for a bite?)")
        local bite = cutscene:choicer({"Yes", "No No No\nNo No No\nNo No No"})
        if bite == 1 then
            Game.world.music:fade(0,1)
            cutscene:wait(1.5)
            
            cutscene:playSound("noise")

            local rect = Rectangle(0, 0, 960, 480)
            rect:setColor(0, 0, 0)
            rect.parallax_x = 0
            rect.parallax_y = 0
            rect.layer = WORLD_LAYERS["ui"] + 1
    
            Game.world:addChild(rect)
            Game:setBorder("none", 0)
            cutscene:wait(3)

            local m_anim = Sprite("misc/mangle_jumpscare/mangle_jumpscare")
            Assets.playSound("fnaf_scream")
            m_anim:play(1 / 19, false)
            m_anim.layer = WORLD_LAYERS["ui"] + 3
            m_anim.x = m_anim.x - 50
            m_anim.y = m_anim.y - 2
            m_anim.parallax_x = 0
            m_anim.parallax_y = 0
            m_anim:setScale(0.7)
            Game.world:addChild(m_anim)
    
            cutscene:wait(1.5)

            rect:setColor(1, 0, 0)
            m_anim:remove()
            Assets.stopSound("fnaf_scream")
            Game:saveQuick()
            Game:gameOver(Game.world.player.x, Game.world.player.y)
        end
    end,
    cruel = function (cutscene, event)
        for _, child in ipairs(event.children) do
            if child:includes(TileObject) then
                child:remove()
            end
        end
        if Game:getFlag("cruelled") then
            cutscene:text("* (Never again.)")
            if Game:getFlag("cruelled") == 1 then
                cutscene:text("* (...Actually, [wait:5]the [color:red]Jellycruel[color:white] left something behind.)")
                cutscene:text("* (It was an axe.)")
                Assets.playSound("item")
                Game.inventory:addItem("cruelaxe")
                cutscene:text("* (You obtained the [color:red]CruelAxe[color:white].)")
                Game:setFlag("cruelled", 2)
            end
            return
        end
        event:setSprite("world/objects/treasure_chest_2")
        event:setScale(2, 1)
        Assets.playSound("locker")
        cutscene:text("* (You looked inside the chest...)")
        local cr = cutscene:spawnNPC("jellycruel", 160, 380)
        cr:setScale(0, 4)
        cr.alpha = 0
        Game.world.timer:tween(1, cr, {scale_x = 1, scale_y = 1, alpha = 1}, 'out-expo')
        cr.layer = 1000
        cutscene:wait(0.8)
        cutscene:text("* (Inside, [wait:5]was a [color:red]Jellycruel!")
        local src = Assets.playSound("tensionhorn")
        src:setPitch(0.7)
        cutscene:wait(10/30)
        local src = Assets.playSound("tensionhorn")
        src:setPitch(0.8)
        cutscene:wait(12/30)
        cutscene:startEncounter("jellycruel")
        Game:setFlag("cruelled", 1)
        cr:remove()
        event:setSprite("world/objects/treasure_chest_1")
    end,
    scammed = function (cutscene)
        local sp = cutscene:getCharacter("spamton")
        local function emote(who, anim, sound, shakex, shakey, fric)
            who:setAnimation(anim)
            cutscene:shakeCharacter(who, shakex or 4, shakey or 0, fric or 1)
            if sound then
                Assets.playSound(sound)
            end
        end
        cutscene:setSpeaker(sp)
        if Game:getFlag("scammed") then
            cutscene:text("* No Refunds[wait:10][font:main, 16]TM")
            return true
        end
        cutscene:text("* KRIS!!! [wait:10]MY FAVORITE [[Esteemed Customer]]")
        cutscene:text("* MAY I INTEREST YOU IN A [[Distinct Healing Item]]?")
        emote(sp, "grab", "wing")
        cutscene:text("* A [[Deal]] SO GOOD, [wait:10][func:em][[Even I don't want it!]]", {
            functions = {
                em = function()
                    emote(sp, "armsup_laugh", "wing")
                end
            }
        })
        cutscene:text("* ONLY FOR THE PRICE OF 500 KROMER.")
        emote(sp, "grab", "wing")
        cutscene:text("* WHADDYA SAY, [wait:5][friend][shake:0][Friend][friend:unfriend]?")
        local ch = cutscene:choicer({"Deal", "No Deal"})
        if ch == 2 then
            Game.world.music:pause()
            cutscene:wait(2)
            sp:setAnimation("dark")
            cutscene:text("* Oh. [wait:10]Ok.")
            Game.world.music:resume()
        elseif ch == 1 then
            if Game.money < 500 then
                cutscene:text("* WHAT??!?! [wait:10]YOU DON'T HAVE ENOUGH [[Wacky Stacks]]?!?")
                cutscene:text("* [[Outrageous]], [wait:10]YOU HEAR ME?")
                if cutscene:getCharacter("jamm") then
                    cutscene:text("* SORRY [friend][[Friend]][friend:unfriend], [wait:5][[I don't give credit!]][react:1]",{
                        reactions = {
                            {"Do you take \nMonopoly Money?", "right", "bottommid", "troll", "jamm"}
                        }
                    })
                else
                    cutscene:text("* SORRY [friend][[Friend]][friend:unfriend], [wait:5][[I don't give credit!]]")
                end
                cutscene:text("* COME BACK [[When you're a little, [wait:5]mmmm, [wait:5]RICHER!]]")
                goto endcut
            end
            Game.money = Game.money - 500
            sp:setSprite("laugh_left")
            sp.sprite:play(1/15)
            cutscene:slideTo(sp, sp.x+20, sp.y, 0.5, 'out-expo')
            cutscene:text("* THANK YOU [[Little Sponge]] FOR THE [[Bits!]]")
            cutscene:text("* ENJOY THIS [[Toxic Gift]] THAT YOU WILL")
            sp.sprite:stop()
            sp.sprite:setFrame(2)
            cutscene:wait(1)
            sp:setAnimation("dark")
            cutscene:text("* [Hyperlink Blocked].")
            sp:setSprite("glitch_laugh/glitch_laugh")
            sp.sprite:play(0.1)
            cutscene:text("* EAHAHAHAHAH!")
            sp.sprite:stop()
            sp.sprite:setFrame(20)
            cutscene:wait(1)
            cutscene:slideTo(sp, sp.x-20, sp.y, 0.5, 'out-expo')
            emote(sp, "arms", "wing")
            cutscene:text("* No Refunds[wait:10][font:main, 16]TM")
            cutscene:setSpeaker()
            Assets.playSound("item")
            cutscene:text("* (You got the S.POISON.)")
            Game.inventory:tryGiveItem("s_poison", true)
            Game:setFlag("scammed", true)
        end
        ::endcut::
        sp:resetSprite()
    end,
    ---@param cutscene WorldCutscene
    ---@param event NPC
    starwalker = function (cutscene, event)
        cutscene:text("* These design choices              [color:yellow]suck")
        cutscene:text("* I'm the original [shake:4][image:ui/funnytext_star][func:funny_text][shake:0]                               walker...", nil, nil, {
            functions = {
                funny_text = function ()
                    for _, sprite in ipairs(cutscene.textbox.text.children) do
                        if sprite:includes(Sprite) and sprite.texture_path == 'ui/funnytext_star' then
                            sprite:setScale(1.3)
                            sprite:setScaleOrigin(.5)
                            sprite.timer = Timer()
                            sprite:addChild(sprite.timer)
                            Assets.playSound("mercyadd")
                            sprite.timer:approach(10/30, 1.5, 1, function (value)
                                sprite:setScale(value)
                            end, "out-elastic")
                            sprite.timer:every(1/30, function ()
                                sprite.x = sprite.init_x + MathUtils.random(1, 3)
                                sprite.y = sprite.init_y + MathUtils.random(1, 3)
                            end)
                        end
                    end
                end
            }
        })
    end,
    bunny = function (cutscene, event)
        cutscene:text("* (A bunny.)")
        if event.interact_count > 1 and Game:hasPartyMember("noelle") then
            local n = cutscene:getCharacter("noelle")
            cutscene:setSpeaker(n)
            cutscene:text("* Aww, [wait:5]a bunny!", "smile_closed")
            cutscene:text("* I love you, [wait:5]bunny!", "smile_closed_b")
            local a = Game.world.camera
            Game.world.timer:tween(1, a, {zoom_x = 2, zoom_y = 2}, 'out-cubic')
            cutscene:wait(2)
            local g = Textbox(56,344, 529, 103, 100, 100)
            Game.stage:addChild(g)
            g:setText("[font:main,72][style:none][color:red][noskip][speed:0.4]GO F#%@ YOURSELF!")
            Assets.playSound("go_fuck")
            cutscene:wait( function ()
                return g.text:isTyping()==false
            end)
            g:remove()
            a.zoom_x, a.zoom_y = 1, 1
            event:explode()
            cutscene:text("* ", "what")
            cutscene:text("* why did it do that-", "what_smile")
            
            --cutscene:text("[font:main,72][style:none][color:red]GO F#%@ YOURSELF!")
        end
    end
}
