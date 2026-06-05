local ThreeDActorPrism, super = Class(ActorSprite)
local Assets3D = modRequire("libraries.ak3d.utils.assets")
local Stage3D = modRequire("libraries.ak3d.src.game.world.Stage3D")

function ThreeDActorPrism:init(actor)
    super.init(self, actor)
	
	self.stage = Stage3D()
	Game.battle:addChild(self.stage)
    self.model = Assets3D.newModel("prism", "models/prism", {20,20,20}, {0,0,0})
	self.model:setShader("p3d", {
		["matcaps"] = Assets.getTexture("models/p3d_matcaps"),
		["material"] = 0,
		["lighting"] = 0,
		["eyePosition"] = {160,-320,120},
	})
    self.model:setScale(80,60,80)
	self.debug_lighting = {x = 160, y = -320, z = 120}
	self.debug_lighting_last = {x = 160, y = -320, z = 120}
    self.stage:add(self.model)
	self.timer = 0
	self.canvas = love.graphics.newCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)
	self.hurted = false
	self.slow_down = false
	self.slow_timer = 0
end						

function ThreeDActorPrism:onRemove(parent)
    super.onRemove(self, parent)
	
	self.canvas:release()
	self.canvas = nil
end

function ThreeDActorPrism:update()
    super.update(self)
	if DEBUG_RENDER then
		if Input.keyDown("w") then
			self.debug_lighting.y = self.debug_lighting.y - DTMULT
		end
		if Input.keyDown("a") then
			self.debug_lighting.x = self.debug_lighting.x - DTMULT
		end
		if Input.keyDown("s") then
			self.debug_lighting.y = self.debug_lighting.y + DTMULT
		end
		if Input.keyDown("d") then
			self.debug_lighting.x = self.debug_lighting.x + DTMULT
		end
		if Input.keyDown("q") then
			self.debug_lighting.z = self.debug_lighting.z - DTMULT
		end
		if Input.keyDown("e") then
			self.debug_lighting.z = self.debug_lighting.z + DTMULT
		end
		if self.debug_lighting.x ~= self.debug_lighting_last.x or self.debug_lighting.y ~= self.debug_lighting_last.y or self.debug_lighting.z ~= self.debug_lighting_last.z then
			self.model.shadervars["eyePosition"] = {self.debug_lighting.x,self.debug_lighting.y,self.debug_lighting.z}
		end
		self.debug_lighting_last.x = self.debug_lighting.x
		self.debug_lighting_last.y = self.debug_lighting.y
		self.debug_lighting_last.z = self.debug_lighting.z
	end
	if self.slow_down then
		self.slow_timer = MathUtils.approach(self.slow_timer, 60, DTMULT)
	end
	if self.full_sprite == self:getPath("hurt") then
		if not self.hurted then
			self.model.mesh:setTexture(Assets.getTexture("models/prism_hurt"))
			self.model.shadervars["eyePosition"] = {160,-320,MathUtils.lerp(125, 120, self.slow_timer/60)}
			self.hurted = true
		end
		self.timer = self.timer + Game.battle.encounter.rage_anim_speed * DTMULT
		local rot = MathUtils.lerp(math.sin(self.timer / 4) * 45, 0, self.slow_timer/60)
		self.model:setRotation(math.rad(90), math.rad(MathUtils.lerp(5, 0, self.slow_timer/60)), math.rad(rot))
		self.model.shadervars["eyePosition"] = {160,-160,MathUtils.lerp(125, 120, self.slow_timer/60)}
		self.model:setTranslation(160, 320, MathUtils.lerp(125, 120, self.slow_timer/60))
	else
		if self.hurted then
			self.model.mesh:setTexture(Assets.getTexture("models/prism"))
			self.model.shadervars["eyePosition"] = {160,-320,120}
			self.hurted = false
		end
		self.timer = self.timer + MathUtils.lerp((10 * Game.battle.encounter.rage_anim_speed), 0, self.slow_timer/60) * DTMULT
		local y_offset = math.sin((self.timer / 10) * 0.1) * 10
		self.model:setRotation(math.rad(90), 0, math.rad(self.timer))
		self.model:setTranslation(160, 320, 120 + y_offset)
	end
    Draw.pushCanvas(self.canvas)
	love.graphics.setMeshCullMode("back")
	love.graphics.push()
	love.graphics.clear()
	self.model:drawModel()
	love.graphics.pop()
	love.graphics.setMeshCullMode("none")
	Draw.popCanvas()
end

function ThreeDActorPrism:draw()
	local canvas = Draw.pushCanvas(SCREEN_WIDTH * 2, SCREEN_HEIGHT * 2)
    self.actor:preSpriteDraw(self)
    self.actor:onSpriteDraw(self)
	Draw.popCanvas()
	
	Draw.draw(canvas, 0, 0, 0, 0.5, 0.5)
	if DEBUG_RENDER then
		love.graphics.setFont(Assets.getFont("main"))
		Draw.setColor(COLORS.red, 1)
		love.graphics.print("LIGHTING X: "..self.debug_lighting.x.."\nLIGHTING Y: "..self.debug_lighting.y.."\nLIGHTING Z: "..self.debug_lighting.z, -10, -10, 0, 0.5, 0.5)
	end
end

return ThreeDActorPrism