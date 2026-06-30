local VaporReflect, super = Class(Event, "vaporreflect")

function VaporReflect:init(data)
    super.init(self, data)

    local properties = data.properties or {}

	self.tile_layers = TiledUtils.parsePropertyList("tiles", properties)
	self.tile_canvas = nil
	self.shader = Assets.newShader("vaporreflect")
end

function VaporReflect:drawMirror()
    local to_draw = {}
    local to_draw_events = {}
	love.graphics.push()
	love.graphics.translate(-self.x, -self.y)
    for _, obj in ipairs(Game.world.children) do
        if obj:includes(Event) then
            table.insert(to_draw_events, obj)
        end
        if obj:includes(Character) then
            table.insert(to_draw, obj)
        end
    end
    for _, obj in ipairs(to_draw_events) do
        if self.reflect then
            self:drawEvent(obj)
        end
    end
    for _, obj in ipairs(to_draw) do
        self:drawCharacter(obj)
    end
	love.graphics.pop()
	--[[if self.tile_canvas then
		Draw.draw(self.tile_canvas)
	end]]
end

function VaporReflect:drawCharacter(chara)
    love.graphics.push()
	Draw.pushShader(self.shader)
	self.shader:send("shadowheight", 160)
    chara:preDraw()
	local refl_off = 0
	if chara.reflection_offset then
		refl_off = chara.reflection_offset
	end
	self.shader:send("pos_y", ((chara.y - self.y) + 8) - chara.height + 15)
    love.graphics.translate(0, chara.height*2 + refl_off)
	love.graphics.scale(-1, 1)
	love.graphics.rotate(-math.rad(180))
    chara:draw()
    chara:postDraw()
	Draw.popShader()
    love.graphics.pop()
end

function VaporReflect:drawEvent(event)
    if event.sprite and event.reflection then
        love.graphics.push()
		Draw.pushShader(self.shader)
		self.shader:send("shadowheight", 160)
        event:preDraw()
		local refl_off = 0
		if event.reflection_offset then
			refl_off = event.reflection_offset
		end
		self.shader:send("pos_y", ((event.y - self.y) + 8) - event.height + 15)
		love.graphics.translate(0, event.height*2 + refl_off)
		love.graphics.scale(-1, 1)
		love.graphics.rotate(-math.rad(180))
        event:draw()
        event:postDraw()
		Draw.popShader()
        love.graphics.pop()
    end
end

function VaporReflect:draw()
    super.draw(self)

    local canvas = Draw.pushCanvas(self.width, self.height)
    love.graphics.clear()
    self:drawMirror()
    Draw.popCanvas()

    love.graphics.stencil(function()
		Draw.pushShader("Mask")
		if self.collider then
			self.collider:drawFill()
		else
			love.graphics.rectangle("fill", 0,0,self:getSize())
		end
		Draw.popShader()
	end, "replace", 1)
    love.graphics.setStencilTest("greater", 0)
	love.graphics.setBlendMode("add")
    Draw.setColor(Game.world.map.fx.color or COLORS.white, self.alpha)
    Draw.drawCanvas(canvas, 0, 0)
    Draw.setColor(1, 1, 1, 1)
	love.graphics.setBlendMode("alpha")
    love.graphics.setStencilTest()
end

return VaporReflect