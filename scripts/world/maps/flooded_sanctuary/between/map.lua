---@class Map.dark_place : Map
local map, super = Class(Map, "between")

function map:init(world, data)
    super.init(self, world, data)
	self.hell_border_alpha_alt = nil
end

function map:onEnter()
	self.fade_left_tiles = 4
    self.fade_right_tiles = 6
	local border = Game.border
end

function map:update()
	super.update(self)

	local kris = Game.world.player
    if kris then
        local room_center = (self.width * self.tile_width) / 2
        local dist = kris.x - room_center
        local left_px = self.fade_left_tiles * -40
        local right_px = self.fade_right_tiles * 40
        self.hell_border_alpha_alt = MathUtils.clamp(
            1 - (dist - right_px) / (left_px - right_px),
            0, 1
        )
    end
end

function map:draw()
    super.draw(self)

    local alpha = Game:getFlag("floodedChurchBorderLastAlphaAlt", 0)

    if Game.world.player then
        local px = Game.world.player.x + 20
        local py = Game.world.player.y - 40
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print(string.format("%.3f", alpha), px, py)
        love.graphics.setColor(1, 1, 1, 1)
    end
end



return map