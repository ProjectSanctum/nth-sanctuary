local Dummy, super = Class(EnemyBattler)

function Dummy:init()
    super.init(self)

    -- Enemy name
    self.name = "Huemist"
        self.counter = 0
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("huemist")

    -- Enemy health
    self.max_health = 550
    self.health = 550
    -- Enemy attack (determines bullet damage)
    self.attack = 4
    -- Enemy defense (usually 0)
    self.defense = 0
    -- Enemy reward
    self.money = 100

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 20

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "basic",
        "aiming",
        "movingarena"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
        -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "<::>",
        ">++<",
        "|\\/|"
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "Composed of [color:ff00ff]Pink [color:white]and [color:ffff00]Gold[color:ffffff] minerals.\nThey simply rest their eyes."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* Huemist daydreams about an empty\nfield somewhere distant.",
        "* The air feels clear and broad.",
        "* Smells like [friend][shake:0][Polygons][friend:unfriend].",
        "* And then you fired again.",
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* Huemist looks very worn."

    -- Register act called "Smile"
    self:registerAct("Smile")
    -- Register party act with Ralsei called "Tell Story"
    -- (second argument is description, usually empty)
    self:registerAct("Tell Story", "", {"ralsei"})

    self.siner = 0
    self.overlay = Assets.getTexture("enemies/huemist/overlay")
end

function Dummy:onAct(battler, name)
    if name == "Smile" then
        -- Give the enemy 100% mercy
        self:addMercy(100)
        -- Change this enemy's dialogue for 1 turn
        self.dialogue_override = "... ^^"
        -- Act text (since it's a list, multiple textboxes)
        return {
            "* You smile.[wait:5]\n* The dummy smiles back.",
            "* It seems the dummy just wanted\nto see you happy."
        }

    elseif name == "Tell Story" then
        -- Loop through all enemies
        for _, enemy in ipairs(Game.battle.enemies) do
            -- Make the enemy tired
            enemy:setTired(true)
        end
        return "* You and Ralsei told the dummy\na bedtime story.\n* The enemies became [color:blue]TIRED[color:reset]..."

    elseif name == "Standard" then --X-Action
        -- Give the enemy 50% mercy
        self:addMercy(50)
        if battler.chara.id == "ralsei" then
            -- R-Action text
            return "* Ralsei bowed politely.\n* The dummy spiritually bowed\nin return."
        elseif battler.chara.id == "susie" then
            -- S-Action: start a cutscene (see scripts/battle/cutscenes/dummy.lua)
            Game.battle:startActCutscene("dummy", "susie_punch")
            return
        else
            -- Text for any other character (like Noelle)
            return "* "..battler.chara:getName().." straightened the\ndummy's hat."
        end
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

function Dummy:update()
    super.update(self)
    self.siner = self.siner + DTMULT
    self.sprite.y = math.sin(self.siner/10)*5
    self.counter = self.counter + DTMULT
    if self.counter > 30 then
        self.counter = 0
        local a = Game.battle:addChild(VaporRipple(self.x, self.y-(self.height/2),  self.spawncolor, 10, 4, 0.0125, 6, 30), -200)
        a.alpha = 0.5
        a.layer = self.layer - 10
    end
end

function Dummy:draw()
    Draw.pushShader("checkerboard_mask", {
        ["pattern"] = self.overlay
        }
    )
    local shader = Assets.getShader("checkerboard_mask")
    shader:send("offset", {Kristal.getTime()/4, Kristal.getTime()/4})
    super.draw(self)
    Draw.popShader()
end
return Dummy