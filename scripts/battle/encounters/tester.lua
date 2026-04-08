local Dummy, super = Class(Encounter)

function Dummy:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = [==[
* Tutorial constricts you...
* ([color:yellow]TP[color:reset] Gain reduced outside of [color:green]using tension items like a cheater[color:reset])
]==]

    -- Battle music ("battle" is rude buster)
    self.music = "ch4_battle"
    -- Enables the purple grid battle background
    self.background = true

    self.reduced_tp = true

    -- Add the dummy enemy to the encounter
    self:addEnemy("tester")

    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
    self.bg = RedBG()
end


function Dummy:onTurnStart()
    for _, box in ipairs(Game.battle.battle_ui.action_boxes) do
        if not box.lock then
            box.lock = Sprite("ui/lock_button")
            box.lock:setOrigin(0.5, 0.5)
            box:addChild(box.lock)
        end
        for _, button in ipairs(box.buttons) do
            button.disabled = false
        end
        local button = TableUtils.pick(box.buttons)
        button.disabled = true
        box.lock.x, box.lock.y = button.x, button.y + 3
    end
end

function Dummy:createBackground()
    return Game.battle:addChild(self.bg)
end

function Dummy:drawBackground(fade)
    Draw.setColor(0, 0, 0, fade)
    love.graphics.rectangle("fill", 0, 0, 640, 480)
    self.bg:drawBackground(fade)
end
return Dummy

