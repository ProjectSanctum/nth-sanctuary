local LeechSpawn, super = Class(Encounter)

function LeechSpawn:init()
    super.init(self)

    self.text = "*          constricts you...\n* [color:yellow]TP[color:reset] Gain reduced outside of [color:green]???[shake:0] [color:reset]"

    self.music = "titan_spawn2"
    self.background = true

    self.titan_spawn_1 = self:addEnemy("leech_spawn", 500, 130)
    self.titan_spawn_2 = self:addEnemy("leech_spawn", 500, 290)
	
    self.reduced_tension = true
	self.light_radius = 48
	self.difficulty = 1
	self.unleash_threshold = 50
    self.offset = 0
end

function LeechSpawn:drawBackground(fade)
    Draw.setColor(0, 0, 0, fade)
    love.graphics.rectangle("fill", 0, 0, 640, 480)

    love.graphics.setLineWidth(2)

    Draw.setColor(130/255, 0, 0, fade-0.65)

    for i=0, 50 do
        love.graphics.line(500*math.sin(math.rad(45))+(i*50)-200+self.offset/2, 500*math.cos(math.rad(45))+240, 500*math.sin(math.rad(225))+(i*50)-200+self.offset/2, 500*math.cos(math.rad(225))+240)
    end

    for i=0, 100 do
        love.graphics.line(500*math.sin(math.rad(135))+(i*50)-200, 500*math.cos(math.rad(135))+240, 500*math.sin(math.rad(315))+(i*50)-200, 500*math.cos(math.rad(315))+240)
    end

    Draw.setColor(130/255, 0, 0, fade-0.35)

    for i=0, 50 do
        love.graphics.line(500*math.sin(math.rad(45))+(i*50)-200, 500*math.cos(math.rad(45))+240, 500*math.sin(math.rad(225))+(i*50)-200, 500*math.cos(math.rad(225))+240)
    end

    for i=0, 100 do
        love.graphics.line(500*math.sin(math.rad(135))+(i*50)-200-self.offset, 500*math.cos(math.rad(135))+240, 500*math.sin(math.rad(315))+(i*50)-200, 500*math.cos(math.rad(315))+240-self.offset)
    end

    if self.offset > 99 then
        self.offset = 0
    else
        self.offset = self.offset + DTMULT*1.5
    end
end

function LeechSpawn:onTurnEnd()
    super.onTurnEnd(self)
	self.light_radius = 48
    self.difficulty = self.difficulty + 1
end

return LeechSpawn