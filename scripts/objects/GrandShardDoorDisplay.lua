local GrandShardDoorDisplay, super = Class(Object)

function GrandShardDoorDisplay:init(finished)
    super.init(self)
	self:setOrigin(0.5,1)
    self.debug_select = true

	self.height = 40

	self.finished = finished or false

	local text = "WITH ALL    COLLECTED,\nTHE DOOR SHALL OPEN..."
	if self.finished then
		text = "AND NOW...\nGRAND SANCTUARY IS WAITING...!"
	end
    self.text = ProphecyText(text, 0, 0)
    self.text.debug_select = false
    self:addChild(self.text)
	local text_width = (self.text.font:getWidth(self.text.sprite_string[1])/2)+(self.text.font:getWidth(self.text.sprite_string[2])/2)
	local kern_compensate = (StringUtils.len(self.text.sprite_string[1]))+(StringUtils.len(self.text.sprite_string[2]))
	self.width = ((text_width+kern_compensate)*2)
	
    self.bg_surface = nil
    self.siner = 0

    -- the scrolling DEPTHS images used by the panels.
    self.shard_icon = Assets.getTexture("ui/shard_door_icon")
    self.tiletex = Assets.getTexture("backgrounds/IMAGE_DEPTH_EXTEND_SEAMLESS")
    self.gradient20 = Assets.getTexture("backgrounds/gradient20")
    self.fill = Assets.getTexture("bubbles/fill")
    self.golden = ColorUtils.hexToRGB("#ffc90eff")
	
	self.panel_alpha = 0
end

local function draw_sprite_tiled_ext(tex, _, x, y, sx, sy, color, alpha)
    local r,g,b,a = love.graphics.getColor()
    if color then
        Draw.setColor(color, alpha)
    end
    Draw.drawWrapped(tex, true, true, x, y, 0, sx, sy)
    love.graphics.setColor(r,g,b,a)
end

local function draw_set_alpha(a)
    local r,g,b = love.graphics.getColor()
    love.graphics.setColor(r,g,b,a)
end

function GrandShardDoorDisplay:draw()
	self.siner = self.siner + DTMULT
    local xsin = 0
    local ysin = math.cos(self.siner / 12) * 4

    super.draw(self)
	local barheight = 60
	Draw.setColor(0,0,0,0.9)
	Draw.draw(self.gradient20, -SCREEN_WIDTH/2, ysin, 0, 64, 1, 0, 20)
	Draw.draw(self.fill, -SCREEN_WIDTH/2, ysin, 0, SCREEN_WIDTH*2, barheight, 0, 0)
	Draw.draw(self.gradient20, -SCREEN_WIDTH/2, ysin + barheight, 0, 64, -1, 0, 20)
	Draw.setColor(1,1,1,1)
    local display_canvas = Draw.pushCanvas(320, 240)
	if Ch4Lib.accurate_blending then
		local text_canvas = Draw.pushCanvas(320, 240)
		love.graphics.push()
		local last_shader = love.graphics.getShader()
        love.graphics.clear(COLORS.black, 0)
		Draw.setColor(1,1,1,1)
		Draw.rectangle("fill", 0, 0, 320, 240)
		love.graphics.setColorMask(false, false, false, true)
		Ch4Lib.setBlendState("add", "add", "oneminusdstalpha", "oneminusdstalpha", "zero", "zero")
        love.graphics.setShader(Kristal.Shaders["Mask"])
		Draw.setColor(1,1,1,1)
		if not self.finished then
			Draw.draw(self.shard_icon, 150, 2, 0, 1, 1)
		end
		for i, str in ipairs(self.text.sprite_string) do
			local text_xoff = math.floor(160 - (self.text.font:getWidth(str) / 2)) - (StringUtils.len(str) / 2)
			text_xoff = math.floor(text_xoff)
			local y_off = (16 / #self.text.sprite_string) - 8
			love.graphics.setFont(self.text.font)
			Draw.setColor(1,1,1,1)
			self.text:drawTextKernLegend(text_xoff, y_off + ((i-1) * 16), str, 1)
		end
		love.graphics.setShader(last_shader)
		love.graphics.setColorMask(true, true, true, true)
		Ch4Lib.setBlendState("add", "add", "srcalpha", "srcalpha", "oneminussrcalpha", "oneminussrcalpha")
		Draw.popCanvas()
		love.graphics.push()
		Ch4Lib.setBlendState("add", "add", "srcalpha", "srcalpha", "oneminussrcalpha", "oneminussrcalpha")
		love.graphics.pop()
		Draw.setColor(self.golden)
		Draw.rectangle("fill", 0, 0, 320, 240)
		draw_sprite_tiled_ext(self.tiletex, 0, math.ceil(self.siner / 2), math.ceil(self.siner / 2), 1, 1, COLORS["white"], 0.6)
		Draw.setColor(1, 1, 1, 1)
		love.graphics.setBlendMode("alpha", "premultiplied")
		Ch4Lib.setBlendState("add", "add", "zero", "zero", "oneminussrccolor", "oneminussrccolor")
		Draw.setColor(0,0,0,1)
		Draw.draw(text_canvas, 0, 0, 0, 1, 1)
		love.graphics.pop()
	else
		love.graphics.stencil(function()
			local last_shader = love.graphics.getShader()
			love.graphics.setShader(Kristal.Shaders["Mask"])
			if not self.finished then
				Draw.draw(self.shard_icon, 150, 2, 0, 1, 1)
			end
			Draw.drawCanvas(self.text.canvas, 0, -8, 0, 1, 1)
			love.graphics.setShader(last_shader)
		end, "replace", 1)
		love.graphics.setStencilTest("greater", 0)
		Draw.setColor(self.golden)
		Draw.rectangle("fill", 0, 0, 320, 240)
		draw_sprite_tiled_ext(self.tiletex, 0, math.ceil(self.siner / 2), math.ceil(self.siner / 2), 1, 1, COLORS["white"], 0.6)
		Draw.setColor(1, 1, 1, 1)
		love.graphics.setStencilTest()
	end
	Draw.popCanvas()
    love.graphics.setBlendMode("add")
	if Ch4Lib.accurate_blending then
		Draw.setColor(1,1,1)
	else
		Draw.setColor(0.7,0.7,0.7)
	end
	Draw.draw(display_canvas, -160+xsin, ysin, 0, 2, 2)
	Draw.draw(display_canvas, -160+xsin, ysin, 0, 2, 2)
    love.graphics.setBlendMode("alpha")
end

return GrandShardDoorDisplay