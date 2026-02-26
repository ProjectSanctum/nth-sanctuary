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
    
    self.siner_active = false
    self.siner = 0
    self.y_speed = 0.05
    self.x_speed = 0
    self.radius = self.y_speed * 400

    self.waves = {
        "basic",
        "aiming",
        "movingarena"
    }

    self.dialogue = {
        "..."
    }

    self.check = "AT 4 DF 0\n* Cotton heart and button eye\n* Looks just like a fluffy guy."

    self.text = {
        "* The dummy gives you a soft\nsmile.",
        "* The power of fluffy boys is\nin the air.",
        "* Smells like cardboard.",
    }

    self.low_health_text = "* The dummy looks like it's\nabout to fall over."

    self:registerAct("Smile")
    self:registerAct("Tell Story", "", {"ralsei"})

    Game.battle.timer:every(0.5, function()
        if self.siner_active then
            local afterimage = AfterImage(self, 0.5)
            afterimage.physics.speed_x = 2.5
            afterimage:setLayer(self.layer + 1)
            Game.battle:addChild(afterimage)
        end
    end)
end

function Dummy:triggerTrueBattle(noact)
    if self.the_true_fight then return end

    self.the_true_fight = true

    if noact ~= true then
        Game.battle:setState("CUTSCENE")
        Game.battle:startActCutscene("dummy", "the_true_fight", self)
    end

    self.health = self.max_health
    self.mercy = 0
    self.spare_points = 0

    self.name = "Mad Dummy"
    self.attack = 12
    self.defense = math.huge

    self:setTired(false)
    self.tired_percentage = 0.1
    self.spare_points = 0
    self.disable_mercy = true

    self.check = {"AT 12 DF 60\n* Its cotton burns with fury.\n* It rejects your ACTions.", "... Unless they're [color:blue]MAGICAL.[color:reset]"}

    self.text = {
        "* The air crackles with rage.",
        "* The dummy trembles violently.",
        "* This is no longer pretend."
    }
end

function Dummy:getHealthDisplay()
    if self.the_true_fight then
        return "???"
    end
    return super.getHealthDisplay(self)
end

function Dummy:onDefeat(damage, battler)
    if not self.the_true_fight then
        self:triggerTrueBattle()
        return false
    end
    return super.onDefeat(self, damage, battler)
end

function Dummy:onAct(battler, name)
    if self.the_true_fight then
        if name == "Smile" then
            return {
                "* You smiled.\n* Mad Dummy laughed at your pity."
            }
        elseif name == "Tell Story" then
            return {
                "* You and Ralsei tried telling a story.\n* Mad Dummy shouted over you."
            }
        elseif name == "Standard" then
            return {
                "* "..battler.chara:getName().." reached toward Mad Dummy.\n* It slapped your hand away."
            }
        elseif name == "Check" then
            return {"* MAD DUMMY - AT 12 DF 60\n* Its cotton burns with fury.\n* It rejects your ACTions.", "* ... Unless they're [color:blue]MAGICAL.[color:reset]"}
        else
            return "* Mad Dummy ignores you completely."
        end
    end

    if not self.the_true_fight then
        if name == "Check" then
            return "* DUMMY - AT 4 DF 0\n* Cotton heart and button eye\n* Looks just like a fluffy guy."
        else
            Game.battle:startActCutscene("dummy", "the_true_fight", self)
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
            local x_offset = math.sin(self.siner * self.x_speed) * self.radius
            self.sprite:setPosition(x_offset, y_offset)
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