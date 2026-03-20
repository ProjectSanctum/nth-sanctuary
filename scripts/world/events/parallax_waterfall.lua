local WaterfallParallax, super = Class(Event, "parallax_waterfall")

function WaterfallParallax:init(data)
    super.init(self, data)
    local properties = data and data.properties or {}
	self.parallax_x = properties["parallax_x"] or 1
	self.parallax_y = properties["parallax_y"] or 1
	self:setSprite("world/events/parallax_waterfall/waterfall")
	self.sprite:play(0.125)
	self.sprite.wrap_texture_y = true
    self.solid = false
	self.width = 80
	self:setOrigin(0.5, 0)
	self.shader = Kristal.Shaders["AddColor"]
end

function WaterfallParallax:drawCharacter(object)
    love.graphics.push()
    object:fullDraw()
    love.graphics.pop()
end

function WaterfallParallax:draw()
    super.draw(self)

    local canvas = Draw.pushCanvas(80, (self.world.map.height * self.world.map.tile_height) * self.parallax_y)
    love.graphics.clear()

    love.graphics.translate(-self.x + 40, -self.y)
	local px, py = self.parent.camera:getParallax(
        self.parallax_x or 1,
        self.parallax_y or 1,
        self.parallax_origin_x,
        self.parallax_origin_y
    )
    love.graphics.translate(-px, -py)

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

return WaterfallParallax