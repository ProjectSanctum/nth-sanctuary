---@class LightningFlashFX: FXBase
local LightningFlashFX, super = Class(ShadowFX)

function LightningFlashFX:init(alpha, scale, priority)
    super.init(self, alpha, {1,1,1}, scale, priority)
    self.cutout_shader = Kristal.Shaders["Mask"]
end

function LightningFlashFX:draw(texture)
    local alpha = self:getAlpha()

	if not Game.world:getEvent("hometowndaynight") then
		local last_shader = love.graphics.getShader()
		local ox, oy, ow, oh = self:getObjectBounds()
		local sx, sy = self.parent:getFullScale()

		Draw.setColor(0, 0, 0, alpha)
		Draw.draw(texture, ox, oy+oh + (self.shadow_offset * sy), 0, 1, -self:getScale(), ox, oy+oh)
		local canvas
		if alpha < 1 then
			canvas = Draw.pushCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)
		end

		if alpha > 0 then
			local shader = Kristal.Shaders["AddColor"]
			love.graphics.setShader(shader)
			shader:send("inputcolor", {1, 1, 1})
			shader:send("amount", alpha)
			Draw.drawCanvas(texture)
			love.graphics.setShader(last_shader)
		elseif not canvas then
			Draw.drawCanvas(texture)
		end

		Draw.setColor(0, 0, 0)
		love.graphics.stencil((function()
			love.graphics.setShader(self.cutout_shader)
			Draw.drawCanvas(texture, 0, 0)
			love.graphics.setShader()
		end), "replace", 1)
		love.graphics.setStencilTest("greater", 0)

		local shader = Kristal.Shaders["AddColor"]
		love.graphics.setShader(shader)
		shader:send("inputcolor", {0, 0, 0})
		shader:send("amount", alpha)
		Draw.drawCanvas(texture, 0, sy * 2)
		love.graphics.setShader(last_shader)

		love.graphics.setStencilTest()
		if canvas then
			Draw.popCanvas()

			Draw.setColor(1, 1, 1)
			Draw.drawCanvas(texture)

			Draw.setColor(1, 1, 1, alpha)
			Draw.draw(canvas)
		end
	else
		local last_shader = love.graphics.getShader()
		local ox, oy, ow, oh = self:getObjectBounds()
		local sx, sy = self.parent:getFullScale()

		local canvas
		if alpha < 1 then
			canvas = Draw.pushCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)
		end

		if alpha > 0 then
			local shader = Kristal.Shaders["AddColor"]
			love.graphics.setShader(shader)
			shader:send("inputcolor", {1, 1, 1})
			shader:send("amount", alpha)
			Draw.drawCanvas(texture)
			love.graphics.setShader(last_shader)
		elseif not canvas then
			Draw.drawCanvas(texture)
		end
		love.graphics.setShader(last_shader)

		if canvas then
			Draw.popCanvas()

			Draw.setColor(1, 1, 1)
			Draw.drawCanvas(texture)

			Draw.setColor(1, 1, 1, alpha)
			Draw.draw(canvas)
		end
	end
end

return LightningFlashFX