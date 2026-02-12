---@class FileSelectBackground : FileSelectBackground
---@field data SaveData?
local FileSelectBackground, super = Class("FileSelectBackground")

function FileSelectBackground:init()
    super.init(self, 0,0, 100,100)
    self.siner = 0
    self.tick = 0
    self.background_alpha = 1
    self.rune = Assets.getTexture("fileselect/rune")
    self.window = Assets.getTexture("fileselect/huge_window")
    self.gang = Assets.getTexture("fileselect/gang")
    self.checker = Assets.getTexture("fileselect/checker")
    self.prophecy = Assets.getTexture("backgrounds/IMAGE_DEPTH_EXTEND_MONO_SEAMLESS_BRIGHTER")
    self.perlin = Assets.getTexture("backgrounds/perlin_noise_looping")
    self.scroll = 20
    self.off = 0
	local preview = {}
	local flags = {}
	for i=1,3 do
		local path = "saves/nth_sanctum/file_"..i..".json"
		if love.filesystem.getInfo(path) then
			local data = JSON.decode(love.filesystem.read(path))
			table.insert(flags, data.flags["prog"])
		end
	end
	table.sort(flags)
	self.flag = flags[#flags]
end

function FileSelectBackground:onStateChange(old,new, ...)
    if new == "FILESELECT" or new == "FILEPREVIEW" then
        self.visible = true
        if new == "FILESELECT" then
            self.data = nil
        end
    elseif new == "FILESTART" then
        self.visible = false
    end
    if new == "FILEPREVIEW" then
        self.data = ... or self.data
    end
end

function FileSelectBackground:draw()
    super.draw(self)
    if self.flag == 0 or not self.flag then
		self:drawIncomplete()
	else
		self.drawCompleted()
	end
end

function FileSelectBackground:drawIncomplete()
    local bg_canvas = Draw.pushCanvas(640, 480)
    love.graphics.clear(0, 0, 0, 1)
    love.graphics.translate(0,0)
	self.scroll_speed = 1
	local amt = math.sin((self.tick / 15) * (2 * math.pi)) * (self.scroll_speed * 6)
	love.graphics.setColor(0, 0, 0, 1)
	love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
	love.graphics.setColor(1,1,1)
	self:drawPart(self.rune, -amt, -amt)
	self:drawPart(self.rune, amt, amt)
	love.graphics.setColor(0, 0, 0, 0.6)
	love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
	self:drawPart(self.rune, 0, 0)
	Draw.popCanvas(true)

    Draw.setColor(1, 1, 1, 1)
	Draw.draw(bg_canvas)
	self.tick = self.tick + (((1/15) * self.scroll_speed) * DTMULT);
end

function FileSelectBackground:drawCompleted()
    local bg_canvas = Draw.pushCanvas(640, 480)
    love.graphics.clear(0, 0, 0, 1)
    local offset = 127
    love.graphics.setColor(0.25, 0.25, 0.25)
    Draw.drawWrapped(self.checker, true, true, -self.off, self.off)
    love.graphics.setColor(1,1,1)
    for i = 1, 4 do
        Draw.draw(self.window, 0+offset*i-1, SCREEN_HEIGHT/2,0, 0.5, 0.5, self.window:getWidth()/2, self.window:getHeight()/2)
    end
    Draw.draw(self.gang, SCREEN_WIDTH/2, SCREEN_HEIGHT/2+180,0, 2, 2, self.gang:getWidth()/2, self.gang:getHeight()/2)
	Draw.popCanvas(true)

    Draw.setColor(1, 1, 1, 1)
	Draw.draw(bg_canvas)
    self.off = self.off - self.scroll*(DTMULT/30)
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

local function oldHexToRgb(hex, value)
    local color = ColorUtils.hexToRGB(hex)
    return {
        color[1],
        color[2],
        color[3],
        color[4] * (value or 1),
    }
end

local function scr_wave(arg0, arg1, speed_seconds, phase)
    local a4 = (arg1 - arg0) * 0.5;
    return arg0 + a4 + (math.sin((((Kristal.getTime()) + (speed_seconds * phase)) / speed_seconds) * (2 * math.pi)) * a4);
end

function FileSelectBackground:drawPart(texture, xx, yy)
	local _xx, _yy = xx or 0, yy or 0
    local _cx, _cy = 0, 0
    
	local last_color = love.graphics.getColor()
	
    local surf_textured = Draw.pushCanvas(640, 480);
    love.graphics.clear(COLORS.white, 0);
    local pnl_tex = self.perlin
    local pnl_canvas = Draw.pushCanvas(pnl_tex:getDimensions())
    draw_sprite_tiled_ext(pnl_tex, 0, 0, 0, 1, 1, oldHexToRgb("#42D0FF", scr_wave(0, 0.4, 4, 0)))
    Draw.popCanvas(true)
    love.graphics.setColorMask(true, true, true, false);
    local x, y = -((_cx * 2) + (self.tick * 15)) * 0.5, -((_cy * 2) + (self.tick * 15)) * 0.5
    draw_sprite_tiled_ext(self.prophecy, 0, x, y, 2, 2, oldHexToRgb("#42D0FF", 1));
    local orig_bm, orig_am = love.graphics.getBlendMode()
    love.graphics.setBlendMode("add", "premultiplied");
    draw_sprite_tiled_ext(pnl_canvas, 0, x, y, 2, 2, COLORS.white);
    love.graphics.setBlendMode(orig_bm, orig_am);
    love.graphics.setColorMask(true, true, true, true);
    Draw.popCanvas()

    love.graphics.stencil(function()
        local last_shader = love.graphics.getShader()
        local shader = Kristal.Shaders["Mask"]
        love.graphics.setShader(shader)
        local rune = self.rune
        local runeox, runeoy = rune:getWidth()/2, rune:getHeight()/2
        love.graphics.draw(rune, SCREEN_WIDTH/2+_xx, SCREEN_HEIGHT/2+30+math.sin(self.siner/30)*10+_yy, 0, 2, 2, runeox, runeoy)
        love.graphics.setShader(last_shader)
    end, "replace", 1)
    love.graphics.setStencilTest("greater", 0)
	Draw.setColor(1,1,1,0.7)
    Draw.drawCanvas(surf_textured);
	Draw.setColor(1,1,1,1)
    love.graphics.setStencilTest()
end

return FileSelectBackground