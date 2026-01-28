local WaterSilhouette, super = Class(Event)

function WaterSilhouette:init(data)
    super.init(self, data)

    self.solid = false
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

return WaterSilhouette