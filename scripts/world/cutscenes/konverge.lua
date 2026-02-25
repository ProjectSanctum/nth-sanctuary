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

    cruel = function (cutscene, event)
        for _, child in ipairs(event.children) do
            if child:includes(TileObject) then
                child:remove()
            end
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
            cutscene:wait(2)
            sp:setAnimation("dark")
            cutscene:text("* Oh. [wait:10]Ok.")
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
    end
}
