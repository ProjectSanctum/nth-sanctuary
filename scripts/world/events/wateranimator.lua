local WaterAnimator, super = Class(Event, "wateranimator")

function WaterAnimator:init(data)
    super.init(self, data)
    local properties = data and data.properties or {}
	self.water_color = TiledUtils.parseColorProperty(properties["color"]) or COLORS.white
    self.base_texture = Assets.getFrames("world/events/watertile")
    self.siner = 0
end

function WaterAnimator:draw()
	love.graphics.push()
	self.siner = self.siner + DTMULT
    local surf_textured = Draw.pushCanvas(SCREEN_WIDTH, SCREEN_HEIGHT, {keep_transform = true})
    love.graphics.clear(0, 0, 0, 0)
    love.graphics.setColorMask(true, true, true, false)
	Draw.drawWrapped(self.base_texture[(math.floor(self.siner / 6) % 4) + 1], true, true, 0, 0)
    love.graphics.setColorMask(true, true, true, true)
    love.graphics.setColorMask(false, false, false, true)
    for index, value in ipairs(self.stage:getObjects(Registry.getLegacyEvent("tile_oscillate"))) do
		if value.type == "water" then
			love.graphics.push()
			love.graphics.replaceTransform(value:getFullTransform())
			love.graphics.rectangle("fill", 0, 0, value.width, value.height)
			love.graphics.pop()
		end
    end
    love.graphics.setColorMask(true, true, true, true)
    Draw.popCanvas()
    love.graphics.origin()
	Draw.setColor(self.water_color)
    Draw.draw(surf_textured, 0, 0)
	Draw.setColor(1,1,1,1)
	love.graphics.pop()
end

return WaterAnimator
