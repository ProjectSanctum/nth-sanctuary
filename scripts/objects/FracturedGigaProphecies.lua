local FracturedGigaProphecies, super = Class(Object)

function FracturedGigaProphecies:init()
    super.init(self)
	self:setPosition(0)
	self:setParallax(0)
	
    self.blueswirly_tex = Assets.getTexture("backgrounds/IMAGE_DEPTH_EXTEND_MONO_SEAMLESS_BRIGHTER")
    self.blueswirly_blur_tex = Assets.getTexture("backgrounds/IMAGE_DEPTH_EXTEND_SEAMLESS")
	self.perlin_tex = Assets.getTexture("backgrounds/perlin_noise_looping")
	self.fill_tex = Assets.getTexture("bubbles/fill")
	self.shatter_frames = Assets.getFrames("intro_prophecies/shatter")
	self.stars = {}
	self.prophecies = {}
	self.prophecy_color = ColorUtils.hexToRGB("#42D0FF")
	self.star_timer = 24
	self.prophecy_timer = 24
	self.con = 0
	self.delta = 1
end

local function returnAlphaColor(color, value)
    local color = color
    return {
        color[1],
        color[2],
        color[3],
        color[4] * (value or 1),
    }
end

function FracturedGigaProphecies:onAdd(parent)
    super.onAdd(self, parent)
	for j = 0, 8 do
		for i = 0, 10 do
			table.insert(self.stars, {
				x = i * 30 + MathUtils.randomInt(-12, 12),
				y = j * 30 + MathUtils.random(-12, 12),
			})
		end
	end
	for j = 0, 4 do	
		for i = 0, 4 do	
			if ((j % 2) == 0 and (i % 2) == 1) or ((j % 2) == 1 and (i % 2) == 0) then
				table.insert(self.prophecies, {
					texture = Assets.getTexture("world/events/prophecy/fractured_prophecies/set_"..MathUtils.randomInt(1, 10)),
					x = 50 + i * 256 + MathUtils.random(-42, 42),
					y = 50 + j * 256 + MathUtils.random(-42, 42),
					layer = 0,
					scale = 1,
					alpha = 1,
					local_off = MathUtils.random(10)
				})
			end
		end
	end
	for j = 0, 6 do	
		for i = 0, 6 do
			table.insert(self.prophecies, {
				texture = Assets.getTexture("world/events/prophecy/fractured_prophecies/set_"..MathUtils.randomInt(1, 10)),
				x = 50 + i * 170 + MathUtils.random(-52, 52),
				y = 50 + j * 170 + MathUtils.random(-52, 52),
				layer = 1,
				scale = 0.5,
				alpha = 0.9,
				local_off = MathUtils.random(10)
			})
		end
	end
	for j = 0, 10 do	
		for i = 0, 10 do
			table.insert(self.prophecies, {
				texture = Assets.getTexture("world/events/prophecy/fractured_prophecies/set_"..MathUtils.randomInt(1, 10)),
				x = 50 + i * 96 + MathUtils.random(-42, 42),
				y = 50 + j * 96 + MathUtils.random(-42, 42),
				layer = 2,
				scale = 0.25,
				alpha = 0.85,
				local_off = MathUtils.random(10)
			})
		end
	end
end

function FracturedGigaProphecies:update()
	super.update(self)
end

function FracturedGigaProphecies:draw()
    super.draw(self)
	
	local cx = Game.world.camera.x - SCREEN_WIDTH/2
	local cy = Game.world.camera.y - SCREEN_HEIGHT/2
	local t = Kristal.getTime()
	local canvas_starfield = Draw.pushCanvas(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
	love.graphics.clear()
    love.graphics.stencil(function()
        local last_shader = love.graphics.getShader()
        local shader = Kristal.Shaders["Mask"]
        love.graphics.setShader(shader)
		for _, star in ipairs(self.stars) do
			if star then
				Draw.draw(self.fill_tex, star.x, star.y)
			end
		end
        love.graphics.setShader(last_shader)
    end, "replace", 1)
    love.graphics.setStencilTest("greater", 0)
    Draw.drawWrapped(self.blueswirly_tex, true, true, 0, 0, 0, 1, 1)
    love.graphics.setStencilTest()
	Draw.popCanvas(true)
	local canvas_prophecy = Draw.pushCanvas(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
	love.graphics.clear()
    love.graphics.stencil(function()
        local last_shader = love.graphics.getShader()
        local shader = Kristal.Shaders["Mask"]
        love.graphics.setShader(shader)
		for _, prophecy in ipairs(self.prophecies) do
			if prophecy and prophecy.x > (cx - 280) and prophecy.x < (cx + 640 + 200) and prophecy.y > (cy - 200) and prophecy.y < (cy + 480 + 200) then
				local tt = (t * 1.25) + prophecy.local_off
				local xx = prophecy.x - cx
				local yy = (prophecy.y - cy) + (math.sin(tt * math.pi) * 5)
				Draw.draw(prophecy.texture, math.floor(xx) * 0.5, math.floor(yy) * 0.5, 0, prophecy.scale, prophecy.scale)
			end
		end
        love.graphics.setShader(last_shader)
    end, "replace", 1)
    love.graphics.setStencilTest("greater", 0)
    Draw.setColor(returnAlphaColor(self.prophecy_color, 1))
    Draw.drawWrapped(self.blueswirly_tex, true, true, (t * 15) * 0.5, (t * 15) * 0.5, 0, 1, 1)
	love.graphics.setBlendMode("add", "alphamultiply")
    Draw.setColor(returnAlphaColor(self.prophecy_color, Ch4Lib.scr_wave(0, 0.4, 4, 0)))
    Draw.drawWrapped(self.perlin_tex, true, true, (t * 15) * 0.5, (t * 15) * 0.5, 0, 1, 1)
	love.graphics.setBlendMode("alpha", "alphamultiply")
	love.graphics.setStencilTest()
	for i = 0, 3 do
		love.graphics.stencil(function()
			local last_shader = love.graphics.getShader()
			local shader = Kristal.Shaders["Mask"]
			love.graphics.setShader(shader)
			for _, prophecy in ipairs(self.prophecies) do
				if prophecy and prophecy.layer ~= i and prophecy.x > (cx - 280) and prophecy.x < (cx + 640 + 200) and prophecy.y > (cy - 200) and prophecy.y < (cy + 480 + 200) then
					local tt = (t * 1.25) + prophecy.local_off
					local xx = prophecy.x - cx
					local yy = (prophecy.y - cy) + (math.sin(tt * math.pi) * 5)
					Draw.draw(prophecy.texture, math.floor(xx) * 0.5, math.floor(yy) * 0.5, 0, prophecy.scale, prophecy.scale)
				end
			end
			love.graphics.setShader(last_shader)
		end, "replace", 1)
		love.graphics.setStencilTest("less", 1)
		for _, prophecy in ipairs(self.prophecies) do
			if prophecy and prophecy.layer == i and prophecy.x > (cx - 280) and prophecy.x < (cx + 640 + 200) and prophecy.y > (cy - 200) and prophecy.y < (cy + 480 + 200) then
				local tt = (t * 1.25) + prophecy.local_off
				local xx = prophecy.x - cx
				local yy = (prophecy.y - cy) + (math.sin(tt * math.pi) * 5)
				Draw.setColor(0, 0, 0, prophecy.layer * 0.15)
				Draw.draw(prophecy.texture, math.floor(xx) * 0.5, math.floor(yy) * 0.5, 0, prophecy.scale, prophecy.scale)
			end
		end
		love.graphics.setStencilTest()
	end
	Draw.popCanvas(true)
	
	Draw.setColor(self:getDrawColor())
	Draw.drawCanvas(canvas_starfield, 0, 0, 0, 2, 2)
	Draw.drawCanvas(canvas_prophecy, 0, 0, 0, 2, 2)
end

return FracturedGigaProphecies