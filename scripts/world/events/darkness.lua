local Darkness, super = Class(Event)

Kristal.Shaders["InvertColor"] = love.graphics.newShader[[
    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
    {
        vec4 pixel = Texel(texture, texture_coords); // get pixel color
        pixel.rgb = vec3(1.0) - pixel.rgb; // invert RGB
        return pixel * color; // multiply by input color (usually white)
    }
]]

function Darkness:init(data)
    super.init(self, data)
    local properties = data and data.properties or {}
    -- parallax set to 0 so it's always aligned with the camera
	self:setPosition(0, 0)
    self:setParallax(0, 0)
    -- don't allow debug selecting
    self.debug_select = false

    self.alpha = data.properties["alpha"] or 1
    self.overlap = true
	self.highlightalpha = 1
	self.draw_highlight = properties["highlight"] ~= false
end

function Darkness:drawCharacter(object)
    love.graphics.push()
    object:preDraw()
    object:draw()
    object:postDraw()
    love.graphics.pop()
end

function Darkness:drawLightsA()
    for _,light in ipairs(Game.stage:getObjects(TileObject)) do
		if light.light_area then
			light:drawLightA()
		end
    end
end

function Darkness:drawLightsB()
    for _,light in ipairs(Game.stage:getObjects(TileObject)) do
		if light.light_area then
			light:drawLightB()
		end
    end
end

function Darkness:draw()
    local dark_canvas = Draw.pushCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)
    love.graphics.setColor(1-self.alpha, 1-self.alpha, 1-self.alpha)
    love.graphics.rectangle("fill",0,0,SCREEN_WIDTH,SCREEN_HEIGHT)
    if self.overlap then
        love.graphics.setBlendMode("add")
    else
        love.graphics.setBlendMode("lighten", "premultiplied")
    end
    self:drawLightsB()
    self:drawLightsA()
    love.graphics.setBlendMode("alpha")
    Draw.popCanvas(true)
	
    love.graphics.setBlendMode("multiply", "premultiplied")
    love.graphics.setColor(1,1,1)
    love.graphics.draw(dark_canvas)
    love.graphics.setBlendMode("alpha")
    local base_highlight_canvas = Draw.pushCanvas(SCREEN_WIDTH,SCREEN_HEIGHT)
    love.graphics.clear()

    love.graphics.translate(-Game.world.camera.x+SCREEN_WIDTH/2, -Game.world.camera.y+SCREEN_HEIGHT/2)

    for _, object in ipairs(Game.world.children) do
        if object:includes(Character) and not object.no_highlight then
            love.graphics.stencil((function ()
				love.graphics.translate(0, 2)
				love.graphics.setShader(Kristal.Shaders["Mask"])
				self:drawCharacter(object)
				love.graphics.setShader()
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
	Draw.popCanvas(true)
    local fade_highlight_canvas = Draw.pushCanvas(SCREEN_WIDTH,SCREEN_HEIGHT)
    love.graphics.clear()
    love.graphics.setColor(0,0,0,1)
    love.graphics.rectangle("fill",0,0,SCREEN_WIDTH,SCREEN_HEIGHT)
    if self.overlap then
        love.graphics.setBlendMode("add")
    else
        love.graphics.setBlendMode("lighten", "premultiplied")
    end
    love.graphics.setColor(1,1,1)
    self:drawLightsB()
    self:drawLightsA()
    love.graphics.setBlendMode("alpha")
	Draw.popCanvas(true)
    local highlight_canvas = Draw.pushCanvas(SCREEN_WIDTH,SCREEN_HEIGHT)
    love.graphics.clear()
	local glowalpha = 1
	for _,roomglow in ipairs(Game.world.map:getEvents("roomglow")) do
		if roomglow then
			glowalpha = 1-roomglow.actind
		end
	end
	Draw.setColor(1,1,1,glowalpha)
    Draw.drawCanvas(base_highlight_canvas)
	love.graphics.setBlendMode("multiply", "premultiplied")
	local last_shader = love.graphics.getShader()
	love.graphics.setShader(Kristal.Shaders["InvertColor"])
    love.graphics.setColor(1,1,1,1)
	Draw.drawCanvas(fade_highlight_canvas, 0, 0, 0)
    love.graphics.setShader(last_shader)
	love.graphics.setBlendMode("alpha")
	Draw.popCanvas(true)
	love.graphics.stencil((function ()
		love.graphics.setShader(Kristal.Shaders["Mask"])
		self:drawLightsB()
		love.graphics.setShader()
	end), "replace", 1)
    love.graphics.setStencilTest("less", 1)
	Draw.setColor(1,1,1,self.alpha)
    Draw.draw(highlight_canvas)
    love.graphics.setStencilTest()
end

function Darkness:drawMask()
	for _,light in ipairs(Game.stage:getObjects(TileObject)) do
		if light.light_area then
			light:drawLightB()
		end
	end
end

return Darkness