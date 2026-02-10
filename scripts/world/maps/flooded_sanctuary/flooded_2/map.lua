local flooded_2, super = Class(Map)

function flooded_2:init(world, data)
    super.init(self, world, data)
    self.hell_border_alpha = 0
end

function flooded_2:onEnter()
    self.height_offset = 0
    self.fade_top_tiles = 1
    self.fade_bottom_tiles = -1
    local top_px = self.fade_top_tiles * 40
    local bottom_px = self.fade_bottom_tiles * 40
    local cam = Game.world.camera.y - SCREEN_HEIGHT/2 + (self.height_offset * 40)
    self.hell_border_alpha = MathUtils.clamp((cam - top_px) / (bottom_px - top_px), 0, 1)
end

function flooded_2:update()
    super.update(self)
    local top_px = self.fade_top_tiles * 40
    local bottom_px = self.fade_bottom_tiles * 40
    local cam = Game.world.camera.y - SCREEN_HEIGHT/2 + (self.height_offset * 40)
    self.hell_border_alpha = MathUtils.clamp((cam - top_px) / (bottom_px - top_px), 0, 1)
end

function flooded_2:draw()
    super.draw(self)

    local alpha = Game:getFlag("floodedChurchBorderLastAlpha", 0)

    if Game.world.player then
        local px = Game.world.player.x
        local py = Game.world.player.y - 40

        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print("alpha: " .. string.format("%.3f", alpha), px, py)
        love.graphics.setColor(1, 1, 1, 1)
    end
end

return flooded_2
