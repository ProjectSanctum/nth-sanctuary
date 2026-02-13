---@class Draw
local Draw = HookSystem.hookScript(Draw)

function Draw.drawMenuRectangle(x, y, w, h)
    -- Make sure the line is a single pixel wide
    love.graphics.setLineWidth(1)
    love.graphics.setLineStyle("rough")
    if Game.world.map.menustyle == "DEVICE" then
        love.graphics.rectangle("line", x, y, w, h)
        return
    end
    -- Draw the rectangles
    love.graphics.rectangle("line", x, y, w + 1, h + 1)
    -- Use consistent increments to create proper overlapping borders
    love.graphics.rectangle("line", x - 1, y - 1, w + 3, h + 3)
    love.graphics.rectangle("line", x - 2, y - 2, w + 5, h + 5)
    love.graphics.rectangle("line", x - 3, y - 3, w + 7, h + 7)
end

return Draw
