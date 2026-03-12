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

    dialog = function (cutscene) 
        cutscene:fadeOut(0, {music = false})
        local susie, ralsei, jamm = cutscene:getCharacter("susie"),cutscene:getCharacter("ralsei"),cutscene:getCharacter("jamm")
        Game.world.music:play("bell_ambience")
        cutscene:wait(2)
        cutscene:setSpeaker(susie)
        cutscene:text("* Kris what is that", "shock")
        cutscene:text("* Are we boned", "shock_nervous")
        cutscene:setSpeaker(ralsei)
        cutscene:text("* Well, [wait:5]Susie.... [wait:10][face:dismissive]Uhhh", "surprise_neutral_side", {auto = true})
        cutscene:setSpeaker(susie)
        cutscene:text("* Hey, [wait:5]YOU!", "teeth")
        cutscene:text("* What are you, [wait:5]some sorta demon?", "teeth_b")
        cutscene:wait(1)
        cutscene:setSpeaker()
        cutscene:text("* ...")
        cutscene:text("* [voice:retro]First of all, [wait:5]I have a name.\n[wait:10]* It's Retro.")
        cutscene:text("* [voice:retro]Secondly, [wait:5]I'm going to be asking the questio-", {auto = true})
        cutscene:setSpeaker(jamm)
        cutscene:text("* Enough with the formalities.", "determined")
        cutscene:text("* Move. [wait:5]We're trying to leave this plac", "determined", {auto = true})
        cutscene:setSpeaker()
        cutscene:text("* [voice:retro]I'm not done talking.")
        cutscene:text("* [voice:retro]I would've let you go if you let me [voice:retro2][color:99ff99]FINISH TALKING.")
        cutscene:text("* [voice:retro]At least have some decency to know who or what I am.")
        cutscene:setSpeaker(susie)
        cutscene:text("* Yeah, [wait:5]Uh. [wait:10]Nah dude.", "annoyed")
        cutscene:text("* We're like, [wait:5]tired of being here.", "annoyed")
        cutscene:text("* And you're starting to piss me off.", "annoyed")
        cutscene:text("* So move. [wait:5]Before I kick your ass.", "annoyed")
        cutscene:wait(1)
                cutscene:setSpeaker()
        cutscene:text("* [voice:retro]That's not how this'll play out.")
        cutscene:text("* [voice:retro]I am the embodiment of [color:yellow]Wrath[color:white], [wait:5]and you're just gonna walk up like it's nothing?")
        cutscene:text("* [voice:retro]Either I'm deaf, [wait:5]or you're on a suicide mission, [wait:5]coming here.[wait:5][react:1]", {reactions = {
            {"(That's 4 new bodies for you, Nightflaid.)", "middle", "bottom"}
        }})
                cutscene:setSpeaker(susie)
        cutscene:text("* Quit being so high and mighty, 'Retro'. [wait:5]If that's even your name.", "annoyed")
        cutscene:text("* Cocky people PISS ME OFF. [wait:10]We're leaving.", "annoyed")
                cutscene:setSpeaker()
        cutscene:text("* [voice:retro]Then that makes two of us. [wait:10]Unlike you,")
        Game.world.music:stop()
        cutscene:text("[voice:retro2][color:99ff99][shake]* I'M ALREADY PISSED OFF!!!")

                cutscene:setSpeaker(ralsei)
                cutscene:text("* H-He's coming...!", "concern")
                Assets.playSound("weaponpull_fast")
    end,

    jammslingshot = function (cutscene)
        local h = Game:getFlag("slingCon")

        if h == 1 then
            cutscene:text("* Where is it?", "jamm")
        end
    end
}