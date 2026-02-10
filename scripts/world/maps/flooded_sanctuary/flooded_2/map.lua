---@class Map.dark_place : Map
local map, super = Class(Map, "hellentrance")

function map:init(world, data)
    super.init(self, world, data)
    self.hell_border_alpha = 0
end

function map:onEnter()
    -- how far above/below center the fade reaches full values
    self.fade_top_px = 0     -- alpha = 1 when Kris is 200px ABOVE center
    self.fade_bottom_px = -7 -- alpha = 0 when Kris is 200px BELOW center
end

function map:update()
    super.update(self)

    if Game.world.player then
        local kris_y = Game.world.player.y
        local room_center = (self.height * self.tile_height) / 2

        local dist = kris_y - room_center

        self.hell_border_alpha = MathUtils.clamp(
            (dist - (self.fade_bottom_px*-40)) / ((self.fade_top_px*40) - (self.fade_bottom_px*-40)),
            0, 1
        )
    end
end

function map:draw()
    super.draw(self)

    local alpha = Game:getFlag("floodedChurchBorderLastAlpha", 0)

    if Game.world.player then
        local px = Game.world.player.x
        local py = Game.world.player.y - 40

        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print(string.format("%.3f", alpha), px, py)
        love.graphics.setColor(1, 1, 1, 1)
    end
end

return map
