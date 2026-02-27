local Dummy, super = Class(EnemyBattler)

function Dummy:init()
    super.init(self)

    self.name = "Dummy"
    self:setActor("dummy")

    self.max_health = 450
    self.health = 450
    self.attack = 4
    self.defense = 0
    self.money = 100
    self.spare_points = 0

    self.the_true_fight = false
    self.trigger_cause = ""
    
    self.dialogue_index = 1
    self.random_dialogue = {
        "[wave]Pitiful. \nPitiful! \nPITIFUL!!   ",
        "[wave]Feeble. \nFeeble! \nFEEBLE!!   ",
        "[wave]Futile. \nFutile! \nFUTILE!!   ",
        "[wave]Foolish. \nFoolish! \nFOOLISH!!   ",
    }

    self.siner_active = false
    self.siner = 0
    self.y_speed = 0.05
    self.x_speed = 0
    self.radius = self.y_speed * 400

    self.waves = {"basic", "aiming"}
    self.dialogue = {"..."}
    self.check = "AT 4 DF 0\n* Cotton heart and button eye\n* Looks just like a fluffy guy."

    self.text = {
        "* The dummy gives you a soft\nsmile.",
        "* The power of fluffy boys is\nin the air.",
        "* Smells like cardboard.",
    }

    self.low_health_text = "* The dummy looks like it's\nabout to fall over."

    self:registerAct("Smile", "Induce\nMERCY")
    self:registerAct("Tell Story", "Induce\nTIRED", {"ralsei"})

    Game.battle.timer:every(0.5, function()
        if self.siner_active then
            local afterimage = AfterImage(self, 0.5)
            afterimage.physics.speed_x = 2.5
            afterimage:setLayer(self.layer + 1)
            Game.battle:addChild(afterimage)
        end
    end)
end

function Dummy:getEnemyDialogue()
    if self.dialogue_override then
        local dialogue = self.dialogue_override
        self.dialogue_override = nil
        return dialogue
    end

    if self.the_true_fight then
        if self.dialogue_index <= #self.dialogue then
            local line = self.dialogue[self.dialogue_index]
            self.dialogue_index = self.dialogue_index + 1
            return line
        else
            return TableUtils.pick(self.random_dialogue)
        end
    end

    return TableUtils.pick(self.dialogue)
end

function Dummy:getEncounterText()
    if self.dialogue_index == 2 then
        return "[facec:ralsei/smile_b_battle][voice:ralsei]* (Hey, Kris!)[wait:5]\n* (It looks like the [color:blue]MAGICAL[color:reset] \nbullets are damaging them!)"
    elseif self.dialogue_index == 3 then
        return "[facec:ralsei/wink_battle][voice:ralsei]* (Let's try to make them shoot [color:blue]MAGICAL[color:reset] bullets at themself, [wait:5]\nokay, Kris?)"
    elseif self.dialogue_index == 4 then
        return "[facec:susie/smile][voice:susie]* (Or you can just use my \nRUDE BUSTER, because it's \ncooler.)"
    elseif self.dialogue_index == 5 then
        return "* You tell Mad Dummy that there is no such thing as \"barrier\" in this universe."
    elseif self.dialogue_index == 6 then
        return "* You are filled with the power of not knowing what you're talking about."
    end

    return super.getEncounterText(self)
end

function Dummy:onTurnEnd()
    self.y_speed = self.y_speed + 0.01
    self.x_speed = self.x_speed + 0.01
    self.radius = self.y_speed * 500
end

function Dummy:triggerTrueBattle(cause, noact)
    if self.the_true_fight then return end

    self.the_true_fight = true
    self.trigger_cause = cause or "smile"
    self.dialogue_index = 1

    self.old_x = self.x
    self.old_y = self.y

    if noact ~= true then
        Game.battle:setState("CUTSCENE")
        Game.battle:resetAttackers() 
        Game.battle.processing_action = false
    
        Game.battle.should_finish_action = false
        Game.battle.on_finish_keep_animation = nil
        Game.battle.on_finish_action = nil
        
        Game.battle:startActCutscene("dummy", "the_true_fight", self)
    end

    self.max_health = 900
    self.health = 900
    self.mercy = 0
    self.spare_points = 0

    self.name = "Mad Dummy"
    self.attack = 15
    self.defense = 100
    self.waves = {"mad_dummy/aiming", "mad_dummy/basic", "mad_dummy/wall"}
    self.wave_override = "mad_dummy/aiming"

    local first_line = {"[wave]YOU!!  ", "[wave]You think you   \ncan just stand   \nthere and smile?!", "[wave]Perhaps you   \nshould've   \nASKED for it   \nfirst! "}
    local middle_line_1 = {"[wave]And then   \nYOU show up.  ", "[wave]With your   \nfluffy   \nfriends!  ", "[wave]And your   \n\"storytelling\"!  "}
    local middle_line_2 = {"[wave]And the way   \nyou tell me   \nall this...!  ", "[wave]Horrible.   \nShocking!   \nMIND-BLOWING!!  "}

    if self.trigger_cause == "tell story" then
        first_line = {"[wave]YOU!!  ", "[wave]And your   \nfluffy friend   \nand his   \nBORING stories!!", "[wave]I've heard   \nbetter plots   \nfrom a   \nPOST-IT NOTE!!  "}
        middle_line_1 = {"[wave]And then   \nyou both   \nhave the   \nAUDACITY...  ", "[wave]To stand   \nthere and   \nlecture me?!  "}
    elseif self.trigger_cause == "susie action" then
        first_line = {"[wave]YOU! ! ", "[wave]And your   \npurple friend   \nand her   \nVIOLENT hands!!", "[wave]PUNCHING a   \ndummy?!   \nHow original!! "}
        middle_line_1 = {"[wave]She thinks   \nshe's so   \ntough!  ", "[wave]A real   \nshocker!   \nA real   \nKNOCKOUT!!  "}
    elseif self.trigger_cause == "ralsei action" then
        first_line = {"[wave]YOU!!  ", "[wave]Letting that   \nfluffy boy   \ndrag on   \nforever!!", "[wave]He's boring   \nme to   \nDEATH!! "}
        middle_line_1 = {"[wave]I'm a ghost,   \nand even I   \nwant to   \nbe free!! ", "[wave]Free from your   \n\"GOAT\" FRIEND'S   \nSPEECHES!"}
    elseif self.trigger_cause == "fight" then
        first_line = {"[wave]YOU!!  ", "[wave]Attacking a   \ndefenseless   \ntraining \"tool\"?!", "[wave]Ghosts have   \nfeelings too!  ", "[wave]Coward.   \nCoward!   \nCOWARD!! "}
        middle_line_2 = {"[wave]The way   \nyou swing   \nthat weapon...!  ", "[wave]DREADFUL!!   \nABHORRENT!!   \nSTUPID!!  "}
    end

    self.dialogue = {
        first_line,
        {"[wave]What?   \nWhat?!   \nWHAT?!?  ", "[wave]What magic attacks?[wait:5]   \nNo magic attacks   \ncan hurt me!  ", "[wave]These are all lies...!  "},
        {"[wave]You know what   \nwould've been   \nmillion times   \nbetter?", "[wave]If I'd spooked   \naway your SOUL   \nall by myself! "},
        {"[wave]That's right!   \nAll by myself!  ", "[wave]For I to cross   \nthe BARRIER and   \nbe free!  "},
        {"[wave]WHAT?!   \nWHAT DO YOU   \nMEAN   \"THERE'S   \nNO BARRIER\"?!? ", "[wave]Foolish.   \nFoolish!   \nFOOLISH!! "},
        {"[wave]I've spent   \neons in this   \nstupid room!  ", "[wave]Waiting for   \na fool like   \nYOU!!  ", "[wave]Waiting for   \na PURPOSE!  "},
        middle_line_1,
        middle_line_2,
        {"[wave]I don't need   \na SOUL to   \ndefeat you!  ", "[wave]I have   \nSPIRIT!  ", "[wave]Literally!   \nI'm a ghost!  "},
        {"[wave]Why won't   \nyou just   \nSTAY STILL?!  ", "[wave]Stop moving!   \nStop breathing!   \nSTOP EXISTING! "},
        {"[wave]Fine!   \nKeep acting!  ", "[wave]Keep smiling!  ", "[wave]It won't   \nsave you   \nanymore!  "}
    }

    self:setTired(false)
    self.tired_percentage = 0.25
    self.spare_points = 0
    self.disable_mercy = true
    self.check = {"AT 15 DF -60\n* Its cotton burns with fury.\n* It rejects your ACTions.", "... Unless they're [color:blue]MAGICAL.[color:reset]"}
    self.text = {"* The air crackles with rage.", "* The dummy trembles violently.", "* This is no longer pretend."}

    self:getAct("Smile").description = "Useless\naction"
    self:getAct("Tell Story").description = "Useless\naction"
end

function Dummy:getHealthDisplay()
    if self.the_true_fight then return "???" end
    return super.getHealthDisplay(self)
end

function Dummy:onDefeat(damage, battler)
    if not self.the_true_fight then
        self:triggerTrueBattle("fight")
        return false
    end
    return super.onDefeat(self, damage, battler)
end

function Dummy:onAct(battler, name)
    if self.the_true_fight then
        if name == "Check" then
            return {"* MAD DUMMY - AT 12 DF -60\n* Its cotton burns with fury.\n* It rejects your ACTions.", "* ... Unless they're [color:blue]MAGICAL.[color:reset]"}
        elseif name == "Smile" then
            return {
                "* You smiled.\n* Mad Dummy laughed at your pity."
            }
        elseif name == "Tell Story" then
            return {
                "* You and Ralsei tried telling a story.\n* Mad Dummy shouted over you."
            }
        elseif name == "Standard" then
            return {
                "* "..battler.chara:getName().." reached toward Mad Dummy.\n* It punched your hand away."
            }
        else
            return "* Mad Dummy ignores you completely."
        end
    end

    if not self.the_true_fight then
        if name == "Check" then
            return "* DUMMY - AT 4 DF 0\n* Cotton heart and button eye\n* Looks just like a fluffy guy."
        elseif name == "Smile" then
            self:triggerTrueBattle("smile")
        elseif name == "Tell Story" then
            self:triggerTrueBattle("tell story")
        elseif name == "Standard" then
            self:triggerTrueBattle(battler.chara.id .. " action")
        else
            self:triggerTrueBattle()
        end
    end
    return super.onAct(self, battler, name)
end

function Dummy:update()
    super.update(self)
    if Game.battle.state ~= "TRANSITION" and Game.battle.state ~= "INTRO" then
        if self.siner_active then
            self.siner = self.siner + DTMULT
            local y_offset = math.sin(self.siner * self.y_speed) * self.radius
            local x_offset = math.sin(self.siner * self.x_speed) * (self.radius/4)
            local lerp_x = Utils.lerp(self.x, self.old_x + x_offset, 0.1 * DTMULT)
            local lerp_y = Utils.lerp(self.y, self.old_y + y_offset, 0.1 * DTMULT)
            self:setPosition(lerp_x, lerp_y)
            if self.bubble then
                local spr = self.sprite or self
                local x, y = spr:getRelativePos(0, spr.height/2, Game.battle)
                self.bubble.x = x
                self.bubble.y = y
            end
        end
    end
end

return Dummy