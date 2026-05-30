local ThreeDActorPrism, super = Class(ActorSprite)
local Assets3D = modRequire("libraries.ak3d.utils.assets")
local Stage3D = modRequire("libraries.ak3d.src.game.world.Stage3D")

function ThreeDActorPrism:init(actor)
    super.init(self, actor)
	
	self.stage = Stage3D()
	Game.battle:addChild(self.stage)
    self.model = Assets3D.newModel("prism", "models/prism", {20,20,20}, {0,0,0})
    self.model:setScale(80,60,80)
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
	if self.slow_down then
		self.slow_timer = MathUtils.approach(self.slow_timer, 60, DTMULT)
	end
	if self.full_sprite == self:getPath("hurt") then
		if not self.hurted then
			self.model.mesh:setTexture(Assets.getTexture("models/prism_hurt"))
			self.hurted = true
		end
		self.timer = self.timer + Game.battle.encounter.rage_anim_speed * DTMULT
		local rot = MathUtils.lerp(math.sin(self.timer / 4) * 45, 0, self.slow_timer/60)
		self.model:setRotation(math.rad(90), math.rad(MathUtils.lerp(-5, 0, self.slow_timer/60)), math.rad(rot))
		self.model:setTranslation(15, 320, 120)
	else
		if self.hurted then
			self.model.mesh:setTexture(Assets.getTexture("models/prism"))
			self.hurted = false
		end
		self.timer = self.timer + MathUtils.lerp((10 * Game.battle.encounter.rage_anim_speed), 0, self.slow_timer/60) * DTMULT
		local y_offset = math.sin((self.timer / 10) * 0.1) * 10
		self.model:setRotation(math.rad(90), 0, math.rad(self.timer))
		self.model:setTranslation(10, 320, 120 + y_offset)
	end
    Draw.pushCanvas(self.canvas)
	love.graphics.push()
	love.graphics.clear()
	self.model:drawModel()
	love.graphics.pop()
	Draw.popCanvas()
end

function ThreeDActorPrism:draw()
	local canvas = Draw.pushCanvas(SCREEN_WIDTH * 2, SCREEN_HEIGHT * 2)
    self.actor:preSpriteDraw(self)
    self.actor:onSpriteDraw(self)
	Draw.popCanvas()
	
	Draw.draw(canvas, 0, 0, 0, 0.5, 0.5)
end

return ThreeDActorPrism