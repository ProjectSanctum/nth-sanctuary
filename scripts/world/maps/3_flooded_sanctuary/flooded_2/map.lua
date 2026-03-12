---@class Map.dark_place : Map
local map, super = Class(Map, "hellentrance")

function map:init(world, data)
    super.init(self, world, data)
    self.hell_border_alpha = 0
    self.debug = true
    self.lava_alpha = 0.5 + (math.sin((Kristal.getTime() * 30) / 12) * 0.3)
    self.lava_grad_scale = (math.sin((Kristal.getTime() * 30) / 12) * 0.5)
end

function map:onEnter()
    self.fade_top_px = -4
    self.fade_bottom_px = -4
    if self.fakefader then
        Game.world.timer:tween(0.35, self.fakefader, {alpha = 0})
    end
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
    self.lava_alpha = (math.sin((Kristal.getTime() * 30) / 12) * 0.2)
    self.lava_grad_scale = (math.sin((Kristal.getTime() * 30) / 12) * 0.5)
end

function map:draw()
    super.draw(self)
    --[[local alpha = Game:getFlag("floodedChurchBorderLastAlpha", 0)
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
    end]]
end

return map
