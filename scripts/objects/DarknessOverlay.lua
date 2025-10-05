local Darkness, super = Class(Object)

function Darkness:init(alpha)
    super:init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    -- above everything, including ui, by default
    -- if you want it to be below ui, set its layer
    self.layer = 1000

    -- parallax set to 0 so it's always aligned with the camera
    self:setParallax(0, 0)
    -- don't allow debug selecting
    self.debug_select = false

    self.alpha = alpha or 1
    self.overlap = true
	self.highlightalpha = 1
	self.draw_highlight = false
end

function Darkness:draw()
    local canvas = Draw.pushCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)
    love.graphics.setColor(1-self.alpha, 1-self.alpha, 1-self.alpha)
    love.graphics.rectangle("fill",0,0,SCREEN_WIDTH,SCREEN_HEIGHT)
    if self.overlap then
        love.graphics.setBlendMode("add")
    else
        love.graphics.setBlendMode("lighten", "premultiplied")
    end
    for _,light in ipairs(Game.stage:getObjects(TileObject)) do
		if light.light_area then
			light:drawLightB()
		end
    end
    love.graphics.setBlendMode("alpha")
    Draw.popCanvas(true)
	
	local mask_canvas = Draw.pushCanvas(SCREEN_WIDTH, SCREEN_HEIGHT, { keep_transform = true })
    love.graphics.clear()
    for _, obj in ipairs(Game.world.children) do
        if obj:includes(Character) and self.draw_highlight then
            self:drawCharacter(obj)
        end
    end
    Draw.popCanvas(true)
	
    love.graphics.setBlendMode("multiply", "premultiplied")
    love.graphics.setColor(1,1,1)
    love.graphics.draw(canvas)
    love.graphics.setBlendMode("alpha")
    love.graphics.stencil(function()
        local last_shader = love.graphics.getShader()
        love.graphics.setShader(Kristal.Shaders["Mask"])
		for _,light in ipairs(Game.stage:getObjects(TileObject)) do
			if light.light_area then
				light:drawLightB()
			end
		end
        love.graphics.setShader(last_shader)
    end, "replace", 1)
	love.graphics.setStencilTest("less", 1)
    Draw.draw(mask_canvas, 0, 0, 0, 1, 1)
    love.graphics.setStencilTest()
end

function Darkness:drawCharacter(chara)
    love.graphics.push()
	local x, y = Game.world.camera.x-SCREEN_WIDTH/2, Game.world.camera.y-SCREEN_HEIGHT/2
	love.graphics.translate(-x, -y)
	local basecol = COLORS["gray"]
	if Game:getPartyMember(chara.party) then
		basecol = Game:getPartyMember(chara.party).highlight_color or COLORS["gray"]
	end
	local color = Utils.mergeColor(COLORS["black"], basecol, self.highlightalpha)
    local shader = Kristal.Shaders["AddColor"]
    love.graphics.stencil((function()
        love.graphics.setShader(Kristal.Shaders["Mask"])
		love.graphics.translate(0, 2)
		chara:fullDraw()
        love.graphics.setShader()
    end), "replace", 1)
    love.graphics.setStencilTest("less", 1)
    love.graphics.setShader(shader)
    shader:send("inputcolor", color)
    shader:send("amount", self.alpha)
	love.graphics.translate(0, -2)
	chara:fullDraw()
	love.graphics.setStencilTest()
    love.graphics.setShader()
	
    love.graphics.pop()
end

return Darkness