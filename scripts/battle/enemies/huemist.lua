local Huemist, super = Class(EnemyBattler)

function Huemist:init()
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
        "huemist/dropletlines"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "<::>",
        ">++<",
        "|\\\\/|"
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "Composed of [color:ff00ff]Pink [color:white]and [color:ffff00]Gold[color:ffffff] minerals.\nThey simply rest their eyes."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* Huemist daydreams about an empty\nfield somewhere distant.",
        "* Huemist ripples like water.",
        "* The air feels clear and broad.",
        "* And then you fired again.",
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* Huemist is turning back into mist."

    -- Register act called "Smile"
    self:registerAct("Fizzy Drink", "25%\nMERCY")
    -- Register party act with Ralsei called "Tell Story"
    -- (second argument is description, usually empty)
    self:registerAct("Sour Drink", "35% & TIRE", {"susie"})
    self:registerAct("Sweet Drink", "50% &\nDelayed\nTIRED", {"ralsei"})
    self:registerAct("Lotta Drink", "35% & \nMove\nslower", {"jamm"})

    self.siner = 0
    self.overlay = Assets.getTexture("enemies/huemist/overlay")
end

function Huemist:onAct(battler, name)
    if name == "Fizzy Drink" then
        -- Give the enemy 100% mercy
        self:addMercy(25)
        -- Change this enemy's dialogue for 1 turn
        self.dialogue_override = "... ^^"
        -- Act text (since it's a list, multiple textboxes)
        return {
            "* You pour Huemist and yourself a glass of sparkling water.[wait:5]\n* Huemist appreciates the gesture!"
        }
    
    elseif name == "Sour Drink" then
        -- Loop through all enemies
        for _, enemy in ipairs(Game.battle.enemies) do
            -- Make the enemy tired
            enemy:setTired(true)
            self:addMercy(35)
        end
        return {
            "* You and Susie share sour drinks with the enemies.[wait:5]\n* The enemies shouldn't have drank that...",
            "* Everything slows down for this turn!"
        }
    
    elseif name == "Sweet Drink" then
        -- Loop through all enemies
        for _, enemy in ipairs(Game.battle.enemies) do
            self:addMercy(35)
        end
        return {
            "* You and Ralsei share sugary drinks with the enemies.[wait:5]\n* Everyone became hyper with sugar!",
            "* Everything speeds up for this turn!"
        }

    elseif name == "Lotta Drink" then
        -- Loop through all enemies
        for _, enemy in ipairs(Game.battle.enemies) do
            self:addMercy(50)
        end
        return {
            "* You and Jamm drink a lot of water with the enemies...",
            "* Movement speed down for this turn!"
        }

    elseif name == "Standard" then --X-Action
        -- Give the enemy 50% mercy
        self:addMercy(25)
        if battler.chara.id == "susie" then
            -- S-Action text
            return "* Susie throws a bottle of water into the air, and catches it with her mouth.[wait:5]\n* Huemist applaudes!"
        elseif battler.chara.id == "ralsei" then
            -- R-Action: start a cutscene (see scripts/battle/cutscenes/dummy.lua)
            return "* Ralsei drank water with huemist.[wait:5]\n* Huemist enjoyed it!"
        elseif battler.chara.id == "jamm" then
            -- J-Action: start a cutscene (see scripts/battle/cutscenes/dummy.lua)
            return "* Jamm and Huemist teach the others about the importance of hydration."
        else
            -- Text for any other character (like Noelle)
            return "* "..battler.chara:getName().." pours huemist a drink."
        end
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

function Huemist:update()
    super.update(self)
    self.siner = self.siner + DTMULT
    self.sprite.y = math.sin(self.siner/10)*5
    self.counter = self.counter + DTMULT
    if self.counter > 30 then
        self.counter = 0
        local a = Game.battle:addChild(VaporRipple(self.x, self.y-(self.height/2), ColorUtils.mergeColor(COLORS.fuchsia, COLORS.yellow, MathUtils.random(0, 1)), 10, 4, 0.0125, 6, 30), -200)
        a.alpha = 0.5
        a.layer = self.layer - 10
    end
end

function Huemist:draw()
    Draw.pushShader("checkerboard_mask", {
        ["pattern"] = self.overlay
        }
    )
    local shader = Assets.getShader("checkerboard_mask")
    shader:send("offset", {Kristal.getTime()/4, Kristal.getTime()/4})
    super.draw(self)
    Draw.popShader()
end

function Huemist:getEncounterText()
    if self.low_health_text and self.health <= (self.max_health * self.low_health_percentage) then
        return self.low_health_text
    elseif self.tired_text and self.tired then
        return self.tired_text
    elseif self.spareable_text and self:canSpare() then
        return self.spareable_text
    end
	if love.math.random(0, 100) < 3 then
		return "* Smells like [friend][Pink & Gold][friend:unfriend] lemonade vapor."
	else
		return super.getEncounterText(self)
	end
end

return Huemist