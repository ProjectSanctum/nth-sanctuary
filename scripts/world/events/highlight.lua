local Highlight, super = Class(Event, "highlight")

function Highlight:init(data)
    super.init(self, data)

    self.solid = false

    self.shader = love.graphics.newShader([[
        vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
           if (Texel(texture, texture_coords).a == 0.0) {
              // a discarded pixel wont be applied as the stencil.
              discard;
           }
           return vec4(1.0);
        }
    ]])
end

function Highlight:drawCharacter(object)
    love.graphics.push()
    object:preDraw()
    object:draw()
    object:postDraw()
    love.graphics.pop()
end

function Highlight:drawMask(object)
    love.graphics.setShader(self.shader)
    self:drawCharacter(object)
    love.graphics.setShader()
end

function Highlight:draw()
    super.draw(self)

    local canvas = Draw.pushCanvas(self.width, self.height)
    love.graphics.clear()

    love.graphics.translate(-self.x, -self.y)

    for _, object in ipairs(Game.world.children) do
        if object:includes(Character) then
            love.graphics.stencil((function ()
				love.graphics.translate(0, 2)
				self:drawMask(object)
				love.graphics.translate(0, -2)
			end), "replace", 1)
            love.graphics.setStencilTest("less", 1)

            love.graphics.setShader(Kristal.Shaders["AddColor"])
			
			local col = COLORS["gray"]
			if Game:getPartyMember(object.party) then
				col = Game:getPartyMember(object.party).highlight_color or COLORS["gray"]
			end
            Kristal.Shaders["AddColor"]:sendColor("inputcolor", col)
            Kristal.Shaders["AddColor"]:send("amount", 1)

            self:drawCharacter(object)

            love.graphics.setShader()

            love.graphics.setStencilTest()
        end
    end

    Draw.popCanvas()

    Draw.draw(canvas)
end

return Highlight