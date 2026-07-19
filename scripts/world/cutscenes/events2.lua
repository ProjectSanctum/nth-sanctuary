return {
    nothing_important = function(cutscene)
        local a = Game.world.music
        cutscene:fadeOut(2, {music = true})
        local susie, ralsei, kris = cutscene:getCharacter("susie"),cutscene:getCharacter("ralsei"),cutscene:getCharacter("kris")
        Game.world.music:play("canta")
        cutscene:wait(2)
        cutscene:setSpeaker(ralsei)
        cutscene:text({
            "* [speed:0.5][shake:0.52]I can't do this anymore, [wait:5]Kris...",
            "* [speed:0.5][shake:0.52]It's so hard to keep going",
            "* [speed:0.5][shake:0.52]I",
            "* [speed:0.5][shake:0.52]I want to go home.",
            "* [speed:0.5][shake:0.52]How much longer, [wait:5]Kris? [wait:5]Susie?",
            "* [speed:0.5][shake:0.52]It just won't stop",
            "* [speed:0.5][shake:0.52]There are too many Dark Worlds",
            "* [speed:0.5][shake:0.52]I can't",
            "* [speed:0.5][shake:0.52]I can't keep it together anymore",
            "* [speed:0.5][shake:0.52]I know, [wait:5]it's okay to cry.[wait:10] It's okay to not always be happy.",
            "* [speed:0.5][shake:0.52]But",
            "* [speed:0.5][shake:0.52]I just want to go"
        })
        cutscene:setSpeaker(susie)
        cutscene:wait(45/30)
        cutscene:text({"* ...",
            "* Ralsei.",
            "* We already came this far.",
            "* I want to leave, [wait:5]too.",
            "* And, [wait:5]y'know?",
            "* I'll keep going until I can't anymore.[wait:10] Until I drop.",
            "* Even if the Knight didn't... [wait:10]Do this...",
            "* We're gonna stop it anyways.",
            "* Just... [wait:10]Deal with it.",
            "* We can stop it. [wait:10]We WILL stop it.",
            "* ...Even if it's a bit too much.",
        })
        cutscene:setSpeaker(ralsei)
        cutscene:wait(45/30)
        cutscene:text({"* [speed:0.5][shake:0.52]Thank you, [wait:5]Susie...",
            "* [speed:0.5][shake:0.52]I think",
            "* [speed:0.5][shake:0.52]I think I can keep going",
            "* [speed:0.5][shake:0.52]Thank you, [wait:5]both of you...",
            "* [speed:0.5][shake:0.52]Let's keep going.",
        })
        cutscene:setSpeaker()
        cutscene:text("* (Ralsei's will changed...)[wait:10]\n* (Check his [color:yellow]SPELLs[color:white].)")
    end,

    jammslingshot = function (cutscene)
        local h = Game:getFlag("slingCon")

        if h == 1 then
            cutscene:setSpeaker("jamm")
            cutscene:text("* Where is it...", "suspicious")
        end
    end,
    vapor = function (cutscene)
        local guy = cutscene:getCharacter("vaporman")
        cutscene:text("[friend]* Heeeeeey, [wait:5]travellers. [wait:10]I am the [wave]Vapor Guy.")
        cutscene:text("[friend]* Take a load off. [wait:10]See my shop, [wait:5]get yous a PartyBrew, and a [wave]Vaporizer.")
        local choice = cutscene:choicer({
            "See the shop",
            "Do not"
        })

        if choice == 2 then
            cutscene:text("[friend]* Aww, [wait:5]come on now. [wait:10]I have a lot of great stuff for yous.")
        else
            cutscene:text("[friend][wave]* Vaporific. [wait:10][wave:0]Come on right.")
            Game:setFlag("seevaporshop", "true")
            cutscene:wait(cutscene:slideTo(guy, 1320, guy.y, 1, "inBack"))
            Game.world.player:setFacing("down")
        end
    end,
    cupadd = function (cutscene)

        local function addCup()
            local cup
            for i=1, 8 do
                if not Game:hasPartyMember("cuptain_party"..i) then
                    cup = i
                break
                end
            end
            if cup then
                Game:addPartyMember("cuptain_party"..cup)
                Game.world:spawnFollower("cuptain_party")
            else
                cutscene:text("* Hey now, [wait:5]8 might be my limit.")
            end
        end

        local flag = Game:getFlag("interested_in_cups")
        if not flag then
            Game:setFlag("interested_in_cups", true)
            cutscene:text("* Hey! [wait:10]Delta Warriors!")
            cutscene:text("* Y'need any support? [wait:5]We got your back!")
            cutscene:text("* With your [color:yellow]expanded party[color:white], [wait:5]you can [color:yellow]RECRUIT [color:white]us into your party!")
            cutscene:text("* Give it a try!")
            local ch = cutscene:choicer({"Yes", "No"})
            if ch == 1 then
                addCup()
                Assets.playSound("item")
                cutscene:wait(1)
                Game.world.music:pause()
                local a = cutscene:playSound("fanfare")
                cutscene:text("[voice:none][noskip][speed:0.1]* (Cuptain joined the party!)")
                cutscene:wait(a)
                Game.world.music:play()
                cutscene:text("* Let's get 'em, [wait:5]boss!")
            else
                cutscene:text("* Awww, [wait:5]please?")
            end
        else
            cutscene:text("* (Recruit a Cuptain?)")
            local ch = cutscene:choicer({"Yes", "No"})
            if ch == 1 then
                addCup()
                Assets.playSound("item")
                cutscene:text("* (Cup added.)")
            end
        end
    end,
    noelletest = function (cutscene)
        cutscene:text("* (Start the cutscene?)")
        local ch = cutscene:choicer({"Yes", "No"})
        if ch == 2 then
            return 
        end
        local n = cutscene:getCharacter("noelle")
        local man = cutscene:getCharacter("lobby_man")
        if not n then
            cutscene:text("[color:red]Add Noelle to your party!")
            return
        end
        if not man then
            cutscene:text("[color:red]Add Lobby Man to your party!")
            return
        end
        cutscene:detachFollowers()
        cutscene:wait(cutscene:walkTo(n, 300, 280))
        man.x,man.y = 320, -20
        n:setFacing("down")
        Game.world.music:fade(0, 2)
        cutscene:walkTo(man, 320, 200,5)
        cutscene:wait(1)
        cutscene:text("* So... [wait:10]Are you ready?", "neutral", man)
        cutscene:text("* Ready to make your last step?", "neutral", man)
        cutscene:wait(function () return math.ceil(man.y) >= 200 end)
        cutscene:text("[speed:0.5]* Last step to being a strong, [wait:5]independant person?", "neutral", man)
        cutscene:wait(1)
        cutscene:text("* ...", "sad_side", n)
        cutscene:text("* ...", "upset_down_b", n)
        cutscene:text("* I...", "upset_down", n)
        cutscene:text("* ...[wait:10]I am.", "upset_down", n)
        cutscene:text("* Just tell me what to do...", "upset_down", n)
        man:setSprite("shaded")
        cutscene:text("[speed:0.5]* If you tell me to... [wait:10]I can do it...", "upset_down", n)
        cutscene:walkTo(man, 320, 250)
        cutscene:text("[speed:0.4][noskip]* Perfect.[wait:10] So mote it be.[wait:30]", "neutral", man, {auto = true})
        cutscene:text("[speed:0.4][noskip]* Just stand perfectly still...[wait:30]", "neutral", man, {auto = true})
        cutscene:wait(0.5)
        man:setSprite("shaded_down")
        
    end
        

    
}