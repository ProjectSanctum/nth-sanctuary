---@class Map.dark_place : Map
local map, super = Class(Map, "between")

function map:init(world, data)
    super.init(self, world, data)
    self.hell_border_alpha_alt = nil
    self.debug = false
end

function map:onEnter()
	self.fade_left_tiles = 4
    self.fade_right_tiles = 6
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
        local px = Game.world.player.x - 22
        local py = Game.world.player.y - 100
        if not self.font then
            local ok, f = pcall(Assets.getFont, "8bitoperator_jve", 32)
            if ok and f then
                self.font = f
            else
                local ok2, f2 = pcall(Assets.getFont, "sans", 20)
                if ok2 and f2 then
                    self.font = f2
                end
            end
        end

        if self.font and self.debug then
            local prev_font = love.graphics.getFont()
            love.graphics.setFont(self.font)
            love.graphics.setColor(1, 1, 0, 1)
            love.graphics.print(string.format("%.2f", alpha), px, py)
            love.graphics.setFont(prev_font)
        end
    end
end

return map
