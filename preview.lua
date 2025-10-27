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
local flag = flags[#flags]

-- whether to fade out the default background
preview.hide_background = false
function preview:init(mod, button)
    self.mod_id = mod.id
    self.base_path = mod.path.."/preview"
    local function p(f) return self.base_path .. "/" .. f end
    if flag then
        print("Progression: "..flag)
        --print(self.music)
        mod.preview_music_path = p("prev2.mp3")
    end
    -- code here gets called when the mods are loaded
    self.siner = 0
    self.rune = love.graphics.newImage(p("rune.png"))
    self.window = love.graphics.newImage(p("huge_window.png"))
    self.gang = love.graphics.newImage(p("gang.png"))
    self.checker = love.graphics.newImage(p("checker.png"))
    self.checker:setWrap("repeat", "repeat")
    self.w, self.h = self.checker:getWidth(), self.checker:getHeight()
    self.prophecy = love.graphics.newImage(mod.path.."/libraries/chapter4lib/assets/sprites/backgrounds/IMAGE_DEPTH_EXTEND_MONO_SEAMLESS_BRIGHTER.png")
    self.perlin = love.graphics.newImage(mod.path.."/libraries/chapter4lib/assets/sprites/backgrounds/perlin_noise_looping.png")
    self.scroll = 20
    self.off = 0
    self.quad = love.graphics.newQuad(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, self.w, self.h)
    self.surf_textured = -1;
    self.tile_object = 364;
    self.base_texture = 88;
    self.scroll_texture = 991;
    self.fade_time_seconds = 4;
    self.fade_from = 0;
    self.fade_to = 1;
    self.scroll_speed = 0;
    self.tick = 0;
    self.intro_mode = false;

    button:setFavoritedColor(ColorUtils.hexToRGB("#42D0FFFF"))
end

function preview:update()
    -- code here gets called every frame, before any draws
    -- to only update while the mod is selected, check self.selected (or self.fade)
    self.siner = self.siner + DTMULT
    self.off =  self.off-self.scroll*(DTMULT/30)
end

function preview:draw()
    if self.fade <= 0 then return end
    love.graphics.setColor(0, 0, 0, self.fade)
    love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    love.graphics.setColor(1,1,1)
    if flag == 0 or not flag then
		self.scroll_speed = self.fade
		local surf = Draw.pushCanvas(640, 480);
		local amt = math.sin((self.tick / 15) * (2 * math.pi)) * (self.scroll_speed * 6)
		love.graphics.setColor(0, 0, 0, 1)
		love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
		love.graphics.setColor(1,1,1)
		self:drawPart(rune, 0.5, 1.0, 1, -amt, -amt)
		self:drawPart(rune, 0.5, 1.0, 1, amt, amt)
		love.graphics.setColor(0, 0, 0, 0.4)
		love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
		self:drawPart(rune, 0.5, 1.0, 1, 0, 0)
		Draw.popCanvas(true)
		love.graphics.setColor(1,1,1,self.fade)
		Draw.draw(surf)
		Draw.setColor(1,1,1,1)
		self.tick = self.tick + (((1/15) * self.scroll_speed) * DTMULT);
    elseif flag > 0 then
        local rune = self.window
        local runeox, runeoy = rune:getWidth()/2, rune:getHeight()/2
        local gang = self.gang
        local gangox, gangoy = gang:getWidth()/2, gang:getHeight()/2
        local offset = 127
        self.quad:setViewport(-self.off, self.off, SCREEN_WIDTH, SCREEN_HEIGHT, self.w, self.h)
        love.graphics.setColor(0.25, 0.25, 0.25)
        love.graphics.draw(self.checker, self.quad, 0,0,0)
        love.graphics.setColor(1,1,1)
        for i = 1, 4 do
            love.graphics.draw(rune, 0+offset*i-1, SCREEN_HEIGHT/2,0, 0.5, 0.5, runeox, runeoy)
        end
        love.graphics.draw(gang, SCREEN_WIDTH/2, SCREEN_HEIGHT/2+180,0, 2, 2, gangox, gangoy)
    end
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

function preview:drawPart(texture, min, max, alpha, xx, yy)
	local _xx, _yy = xx or 0, yy or 0
    local _cx, _cy = 0, 0

	local last_color = love.graphics.getColor()
    local surf_textured = Draw.pushCanvas(640, 480);
    love.graphics.clear(COLORS.white, 0);
    love.graphics.setColorMask(true, true, true, false);
    local pnl_tex = self.perlin
    local pnl_canvas = Draw.pushCanvas(pnl_tex:getDimensions())
    draw_sprite_tiled_ext(pnl_tex, 0, 0, 0, 1, 1, oldHexToRgb("#42D0FF", alpha))
    Draw.popCanvas(true)
    local x, y = -((_cx * 2) + (self.tick * 15)) * 0.5, -((_cy * 2) + (self.tick * 15)) * 0.5
    draw_sprite_tiled_ext(self.prophecy, 0, x, y, 2, 2, oldHexToRgb("#42D0FF", 1));
    local orig_bm, orig_am = love.graphics.getBlendMode()
    love.graphics.setBlendMode("add", "premultiplied");
    draw_sprite_tiled_ext(pnl_canvas, 0, x, y, 2, 2, oldHexToRgb("#42D0FF", alpha));
    love.graphics.setBlendMode(orig_bm, orig_am);
    Draw.popCanvas()


    love.graphics.stencil(function()
        local last_shader = love.graphics.getShader()
        local shader = Kristal.Shaders["Mask"]
        love.graphics.setShader(shader)
        local rune = self.rune
        local runeox, runeoy = rune:getWidth()/2, rune:getHeight()/2
        love.graphics.draw(rune, SCREEN_WIDTH/2+_xx, SCREEN_HEIGHT/2+math.sin(self.siner/30)*10+_yy, 0, 2, 2, runeox, runeoy)
        love.graphics.setShader(last_shader)
    end, "replace", 1)
    love.graphics.setStencilTest("greater", 0)
	Draw.setColor(last_color)
    Draw.drawCanvas(surf_textured);
    love.graphics.setStencilTest()
end


function preview:drawOverlay()
    -- code here gets drawn above the menu every frame
    -- so u can make cool effects
    -- if u want
end

return preview