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
    self:addEnemy("huemist")

    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
end

return Dummy