local Dummy, super = Class(EnemyBattler)

function Dummy:init()
    super.init(self)

    -- Enemy name
    self.name = "3D Spinning Cube"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("3d-2")

    -- Enemy health
    self.max_health = 100
    self.health = 100
    -- Enemy attack (determines bullet damage)
    self.attack = 1
    -- Enemy defense (usually 0)
    self.defense = -100
    -- Enemy reward
    self.money = 100

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 20

    -- List of possible wave ids, randomly picked each turn
    self.waves = {

    }

    self.tired_percentage = -math.huge

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        {
            "This is so cool guys",
            "I'm spinning!!!!"
        },
        "SPIN",
        "I'm gonna fucking kill you",
        "I AM NOT A CROSSWALK."
    }
    self.dialogue_offset = {30, 0}
    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT [image:infinite, -5, 0, 2,2] DF [image:infinite,-5,0,2,2] \n* Again? [wait:10]Really?"

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* The 3D cube cubes, cubically.",
        "* Too many excess vertices?\n* Go to hell!",
        "* cube",
        "* The 3D Spinning Cube mumbles something about AI generated french fries. [wait:10]It doesn't make any sense.",
        "* Not placeholder text, [wait:5]I swear.",
        "* The third dimension is a lie.",
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* damn he dyin"

    -- Register act called "Smile"
    self:registerAct("Smile")
    -- Register party act with Ralsei called "Tell Story"
    -- (second argument is description, usually empty)
    self:registerAct("Tell Story", "", {"ralsei"})
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

function Dummy:getAttackDamage(damage, battler, points)
    return 1
end

return Dummy