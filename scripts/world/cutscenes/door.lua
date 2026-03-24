return {
    d1 = function(cutscene)
        local man = cutscene:getCharacter("lobbyman")
        local susie, ralsei, kris, jamm = cutscene:getCharacter("susie"),cutscene:getCharacter("ralsei"),cutscene:getCharacter("kris"),cutscene:getCharacter("jamm")
        cutscene:detachFollowers()
        cutscene:walkTo(susie, "spoint", 1.5)
        cutscene:walkTo(ralsei, "rpoint", 1.5)
        cutscene:walkTo(kris, "kpoint", 1.5)
        if Game:hasPartyMember("jamm") then
            cutscene:walkTo(jamm, "jpoint", 1.5)
        end
        cutscene:wait(1.5)
        susie:setFacing("up")
        kris:setFacing("up")
        ralsei:setFacing("up")
        if Game:hasPartyMember("jamm") then
            jamm:setFacing("up")
        end
        cutscene:wait(1)
        cutscene:setSpeaker(susie)
        cutscene:text("* Hmm...", "suspicious")
        cutscene:text("* What are our choices?", "suspicious")
        cutscene:text("* We either die, [wait:5]or not die...", "suspicious")
        cutscene:setSpeaker(ralsei)
        cutscene:text("* ", "shock_smile")
        cutscene:text("* Or maybe, [wait:5]we find a way out???", "shock_smile")
        cutscene:text("* Kris, [wait:5]what do you think?", "surprise_smile")
        local choice = cutscene:choicer({"We die", "Point and \nhearts come out", "Find a way out"})

        if choice == 1 then
            cutscene:setSpeaker(susie)
            cutscene:text("* Hell yeah. [wait:10]Let's go.", "smile")
        elseif choice == 2 then
            cutscene:setSpeaker(ralsei)
            cutscene:text("* [wait:30][react:1]", "shock_smile", {reactions = {
            {" ", "right", "bottommid", "annoyed_b", "susie"}}})
        elseif choice == 3 then
            cutscene:setSpeaker(ralsei)
            cutscene:text("* See, [wait:5]Susie?", "pleased")
            cutscene:text("* Kris is optimistic!", "pleased")
        end
        cutscene:walkTo(susie, "walkp2", 1.5)
        cutscene:walkTo(ralsei, "walkp3", 1.5)
        cutscene:walkTo(kris, "walkp", 1.5)
        if Game:hasPartyMember("jamm") then
            cutscene:walkTo(jamm, "walkp4", 1.5)
        end
        cutscene:wait(1)
        Game.world:mapTransition("2_2nd_sanctuary/second_sanctum_0_ripple")
    end
}
