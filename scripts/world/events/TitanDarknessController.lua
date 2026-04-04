local TitanDarknessController, super = Class(Event)

function TitanDarknessController:init(data)
    super.init(self, data)
    self:setPosition(0, 0)
    self:setLayer(WORLD_LAYERS["above_events"])
    self.timer = 0
    self.spawn_speed = 0
    self.spawn_timer = self.spawn_speed
    self.fumes = {}
    self:addFX(PixelateFX(2))
    for i = 1, 8 do
        table.insert(self.fumes, {MathUtils.random(0, SCREEN_WIDTH*2), SCREEN_HEIGHT+90, MathUtils.random(20, 40), self.timer + MathUtils.random(-30, 30)})
    end
end
function TitanDarknessController:update()
    super.update(self)
    self:setLayer(WORLD_LAYERS["above_events"])
    self.timer = self.timer + DTMULT
    self.spawn_timer = self.spawn_timer - DTMULT
    if self.spawn_timer < 0 then
        self.spawn_timer = self.spawn_timer + self.spawn_speed
        table.insert(self.fumes, {MathUtils.random(0, SCREEN_WIDTH*2), SCREEN_HEIGHT+120, MathUtils.random(20, 40), self.timer})
    end

    local to_remove = {}
    for index, fume in ipairs(self.fumes) do
        local x, y, radius = self:getFumeInformation(index)
        if y < -(radius + 30) or radius < 0 then table.insert(to_remove, fume) end
    end

    for _, fume in ipairs(to_remove) do
        TableUtils.removeValue(self.fumes, fume)
    end
end

function TitanDarknessController:getFumeInformation(index)
    local x, y, radius, time = TableUtils.unpack(self.fumes[index])
    time = self.timer - time
    x = x + math.sin(time / 4) * 4
    y = y - time * 1.9
    radius = radius - time * 0.2
    return x, y, radius, time
end

function TitanDarknessController:draw()
    super.draw(self)

    Draw.setColor(1, 1, 1)
    for index, _ in ipairs(self.fumes) do
        local x, y, radius = self:getFumeInformation(index)
        love.graphics.setLineWidth(4)
        love.graphics.circle("line", x, y, radius)
    end

    Draw.setColor(COLORS.black)
    for index, _ in ipairs(self.fumes) do
        local x, y, radius = self:getFumeInformation(index)
        love.graphics.circle("fill", x, y, radius - 2)
    end
end

return TitanDarknessController