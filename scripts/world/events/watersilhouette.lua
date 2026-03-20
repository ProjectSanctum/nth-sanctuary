local WaterSilhouette, super = Class(Event)

function WaterSilhouette:init(data)
    super.init(self, data)

    self.solid = false
	self.shader = Kristal.Shaders["AddColor"]
end

function WaterSilhouette:drawCharacter(object)
    love.graphics.push()
    object:preDraw()
    object:draw()
    object:postDraw()
    love.graphics.pop()
end

function WaterSilhouette:draw()
    super.draw(self)

    local canvas = Draw.pushCanvas(self.width, self.height)
    love.graphics.clear()

    love.graphics.translate(-self.x, -self.y)

    love.graphics.setShader(self.shader)

    self.shader:send("inputcolor", ColorUtils.hexToRGB("#0071D5"))
    self.shader:send("amount", 1)

	if Game.world.map and Game.world.map.silhouette_tiles then
		Game.world.map.silhouette_tiles.visible = true
		Game.world.map.silhouette_tiles:draw()
		Game.world.map.silhouette_tiles.visible = false       
	end
    for _, object in ipairs(Game.world.children) do
		local alpha = object.alpha
		if object:getFX("climb_fade") then
			alpha = alpha * object:getFX("climb_fade").alpha
		end
		Draw.setColor(1, 1, 1, alpha)
        if (object:includes(Character) and alpha > 0) or object.draw_water_silhouette then
            self:drawCharacter(object)
        end
		Draw.setColor(1, 1, 1, 1)
    end
	love.graphics.setShader()

    Draw.popCanvas()

    Draw.setColor(1, 1, 1, 1)
    Draw.draw(canvas)
    Draw.setColor(1, 1, 1, 1)
end

return WaterSilhouette