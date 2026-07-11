local VaporFloorShine, super = Class(Event)

function VaporFloorShine:init(data)
    super.init(self, data)
	
	self:setParallax(0.75)
	self.base_texture = Assets.getTexture("world/events/vaporfloorshine")
end

function VaporFloorShine:draw()
	love.graphics.stencil(function()
		local last_shader = love.graphics.getShader()
		love.graphics.setShader(Kristal.Shaders["Mask"])
		for _, vaporfloor in ipairs(self.world:getEvents("vaporreflect")) do
			love.graphics.push()
			love.graphics.replaceTransform(vaporfloor:getFullTransform())
			if vaporfloor.collider then
				vaporfloor.collider:drawFill()
			else
				love.graphics.rectangle("fill", 0,0,vaporfloor:getSize())
			end
			love.graphics.pop()
		end
		love.graphics.setShader(last_shader)
	end, "replace", 1)
	love.graphics.setStencilTest("greater", 0)
	love.graphics.setBlendMode("add")
    Draw.setColor(Game.world.map.fx.color or COLORS.white, 0.15)
	Draw.drawWrapped(self.base_texture, true, true, 0, 0, 0, 2, 2, 0, 0, -1, 0)
	love.graphics.setBlendMode("alpha")
	love.graphics.setStencilTest()
    super.draw(self)
end

return VaporFloorShine