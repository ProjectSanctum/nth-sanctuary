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
end

function WaterfallParallax:drawCharacter(object)
    love.graphics.push()
    object:preDraw()
    object:draw()
    object:postDraw()
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

    for _, object in ipairs(Game.world.children) do
        if object:includes(Character) then
            love.graphics.setShader(Kristal.Shaders["AddColor"])

            Kristal.Shaders["AddColor"]:send("inputcolor", ColorUtils.hexToRGB("#0071D5"))
            Kristal.Shaders["AddColor"]:send("amount", 1)

            self:drawCharacter(object)

            love.graphics.setShader()
        end
    end

    Draw.popCanvas()

    Draw.setColor(1, 1, 1, 1)
    Draw.draw(canvas)
    Draw.setColor(1, 1, 1, 1)
end

return WaterfallParallax