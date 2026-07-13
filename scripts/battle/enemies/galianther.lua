local Galianther, super = Class(EnemyBattler)

function Galianther:init()
    super.init(self)

    self.name = "Galianther"
    self:setActor("galianther")

    self.max_health = 1000
    self.health = 1000
    self.attack = 14
    self.defense = 4
    self.money = 170
    self.spare_points = 10

    self.waves = {
        "galianther/circlearena2",
        "galianther/galiantheraim"
        --we need original waves for them
    }

    self.dialogue = {
        "Aggrieve  Abstain  Accede  Abscond  Abjure",
        "Halo, come with me!                 ",
        "Do you oppose authority?            ",
        "Rebuild our land      Rebuild our land",
    }
    self.dialogue_mercy = {
        "Live to protect!      Live to protect!",
        "While I spin        There's still hope"
    }

    self.check = "A radical blade with\na forked handle."

    self.text = {
        "* Galianther molts and revolts.",
        "* Galianther watches distrustfully.",
        "* Galianther draws flowers with its\nblade.",
        "* Galianther rotates aggressively."
    }

    self.spareable_text = "* Galianther flutters trustfully."
    self.low_health_text = "* Galianther sheds feathers heavily."
    self.tired_text = "* Galianther's eye flutters shut."

    self.low_health_percentage = 1/3

    self:registerAct("Spin", "Spin\n50%\nmercy")
    self:registerAct("SpinS", "60%\nMercy\nto all", {"susie"})
    self:registerAct("Whirl", "SPARE\nall!", {"susie", "ralsei"}, 64)

    self.transition_ended = false
end

function Galianther:onAdd(parent)
    super.onAdd(self, parent)
    self:setAnimation("blank")
end

function Galianther:update()
    super.update(self)

    if not self.transition_ended and Game.battle.state ~= 'TRANSITION' and Game.battle.state ~= 'INTRO' then
        self.transition_ended = true
        self:setAnimation("idle")
    end
end

function Galianther:spawnSpeechBubble(text)
    self:shiftOrigin(0.5, 0.5)
    local bubble = GaliantherSpeechBubble(text, self)
    self.bubble = bubble
    self:onBubbleSpawn(bubble)
    Game.battle:addChild(bubble)
    return bubble
end

function Galianther:isXActionShort(battler)
    return true
end

function Galianther:onAct(battler, name)
    if name == "Spin" then
        self:addMercy(50)
        for _, enemy in ipairs(Game.battle:getActiveEnemies()) do
            if enemy ~= self then enemy:addMercy(10) end
        end
        Assets.stopAndPlaySound("pirouette", 0.7, 1.1)
        battler:setAnimation('pirouette')
        return "* You spun masterfully!"
    elseif name == "SpinS" then
        for _, enemy in ipairs(Game.battle:getActiveEnemies()) do
            enemy:addMercy(60)
        end
        Assets.stopAndPlaySound("pirouette", 0.7, 1.1)
        battler:setAnimation('pirouette')
        Game.battle:getPartyBattler('susie'):setAnimation('pirouette')
        return "* You and Susie spun masterfully!"
    elseif name == "Whirl" then
        Assets.stopAndPlaySound("pirouette", 0.7, 1.1)
        Game.battle:getPartyBattler('kris'):setAnimation('pirouette')
        Game.battle:getPartyBattler('susie'):setAnimation('pirouette')
        Game.battle:getPartyBattler('ralsei'):setAnimation('pirouette')
        Game.battle:startActCutscene("wingladewhirl")
        return
    elseif name == "Standard" then
        return self:onShortAct(battler, name)
    end

    return super.onAct(self, battler, name)
end

function Galianther:onShortAct(battler, name)
    if name == "Standard" then
        Assets.stopAndPlaySound("pirouette", 0.7, 1.1)
        battler:setAnimation('pirouette')
        if battler.chara.id == "ralsei" then
            self:addMercy(50)
            for _, enemy in ipairs(Game.battle:getActiveEnemies()) do
                if enemy ~= self then enemy:addMercy(10) end
            end
            return "* Ralsei rotates like a gyro!"
        elseif battler.chara.id == "susie" then
            self:addMercy(40)
            return "* Susie wobbles like a top!"
        else
            self:addMercy(40)
            return "* "..battler.chara:getName().." wobbles like a top!"
        end
    end

    return super.onShortAct(self, battler, name)
end

function Galianther:onHurt(...)
    self:setAnimation("blank")
    super.onHurt(self, ...)
end

function Galianther:onHurtEnd()
    if self:canSpare() then self:onSpareable()
    else self:setAnimation("idle") end
    super.onHurtEnd(self)
end

function Galianther:onSpared()
    self:setAnimation("blank")
end

function Galianther:getEnemyDialogue()
    if self.dialogue_override then
        local dialogue = self.dialogue_override
        self.dialogue_override = nil
        return dialogue
    end

    if self.mercy >= 100 then
        return TableUtils.pick(self.dialogue_mercy)
    end

    return TableUtils.pick(self.dialogue)
end

function Galianther:getEncounterText()
    local has_spareable_text = self.spareable_text and self:canSpare()

    local priority_spareable_text = Game:getConfig("prioritySpareableText")
    if priority_spareable_text and has_spareable_text then
        return self.spareable_text
    end

    if self.low_health_text and self.health <= (self.max_health * self.low_health_percentage) then
        return self.low_health_text

    elseif self.tired_text and self.tired then
        return self.tired_text

    elseif has_spareable_text then
        return self.spareable_text
    end

    if MathUtils.randomInt(100) < 3 then
        return "* Smells like old down pillow."
    end

    return TableUtils.pick(self.text)
end

return Galianther