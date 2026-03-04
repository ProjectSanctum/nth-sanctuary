---@class ProphecyScrollFX: FXBase
local ProphecyShaderFX, super = Class(ShaderFX)

function ProphecyShaderFX:init(opacity, color, priority)
    super.init(self, "prophecy", {}, nil, priority)

    self.texture_1 = Assets.getTexture("backgrounds/IMAGE_DEPTH_EXTEND_MONO_SEAMLESS_POW2")
    self.texture_2 = Assets.getTexture("backgrounds/perlin_noise_looping")
    self.shader:send("sampler_1", self.texture_1)
    self.shader:send("sampler_2", self.texture_2)
	self.opacity = opacity or 1
	self.col = color or {0.2588, 0.8157, 1}
end

function ProphecyShaderFX:draw(texture)
    --Draw.drawCanvas(texture)
    self.shader:send("time", Kristal.getTime() * 15)
    self.shader:send("opacity", self.opacity)
    self.shader:sendColor("col", self.col)
    super.draw(self, texture)
end

return ProphecyShaderFX