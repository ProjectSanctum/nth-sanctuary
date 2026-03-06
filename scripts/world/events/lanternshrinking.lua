local ChurchLanternShrinking, super = Class(Event)

function ChurchLanternShrinking:init(data)
    super.init(self, data)
	self:setOrigin(0.5)
    local properties = data and data.properties or {}
	self.draw_dimmer_light = properties["dimmerlight"] or false
	self.size = properties["size"] or 80
	self.littlesize = properties["littlesize"] or 80
	self.bigsize = properties["bigsizes"] or 240
	self.timer = 0
	self.maxtimer = properties["maxtimer"] or 120
	self.timebuffer = properties["timebuffer"] or 20
	self.nointeract = properties["interactable"] ~= false
	self.group = properties["group"] or nil
	self.con = 0
	self.siner = 0
	self.growtime = 0
	self.timetogrow = 15
	self.lightalpha = 1
	self.light_source = true
	self.light_active = true
	self.unlit_sprite = Sprite("world/events/churchlantern/unlit", -2, -54 - 18)
	self.unlit_sprite:setOriginExact(9, 0)
	self.unlit_sprite:setScale(2)
	self.unlit_sprite.debug_select = false
	self:addChild(self.unlit_sprite)
	self.lit_sprite = Sprite("world/events/churchlantern/lit", -2, -54 - 18)
	self.lit_sprite:setOriginExact(9, 0)
	self.lit_sprite:setScale(2)
	self.lit_sprite.alpha = 0
	self.lit_sprite.layer = 1
	self.lit_sprite.debug_select = false
	self:addChild(self.lit_sprite)
end

function ChurchLanternShrinking:getDebugRectangle()
    return {-18, -30, 30, 52}
end

function ChurchLanternShrinking:easeInOutExpo(t, b, c, d)
    t = t / d * 2
    if t < 1 then
        return c / 2 * math.pow(2, 10 * (t - 1)) + b - c * 0.0005
    else
        t = t - 1
        return c / 2 * 1.0005 * (-math.pow(2, -10 * t) + 2) + b
    end
end

function ChurchLanternShrinking:update()
    super.update(self)
	self.siner = self.siner + DTMULT
	self.size = self:easeInOutExpo(self.timer, self.littlesize, self.bigsize - self.littlesize, self.maxtimer + self.timebuffer)
	if not self.nointeract then
		if self.con == 0 and Game.world.player:isMovementEnabled() then
			self.timer = math.max(self.timer - DTMULT, 0)
		end
		if self.con == 1 then
			self.growtime = self.growtime - DTMULT
			if self.growtime <= 0 then
				self.con = 0
			end
		end
	end
	if self.group then
		local amon = false
		for _, button in ipairs(Game.world.map:getEvents("tilebutton")) do
			if button.group == self.group then
				if button.pressed then
					amon = true
				end
			end
		end
		for _, button in ipairs(Game.world.map:getEvents("churchtilebutton")) do
			if button.group == self.group then
				if button.pressed then
					amon = true
				end
			end
		end
		if amon then
			self.timer = MathUtils.clamp(MathUtils.round(MathUtils.lerp(self.timer, self.maxtimer + self.timebuffer + 1, 0.25 * DTMULT)), 0, self.maxtimer + self.timebuffer)
		else
			self.timer = self.timer - DTMULT
		end
	end
	if self.lit_sprite then
		self.lit_sprite.alpha = ((((self.size + (self.littlesize / 6)) * 1.125) + (math.sin(self.siner / 30) * 2)) - self.littlesize) / (self.bigsize - self.littlesize), 0, 1
	end
end

function ChurchLanternShrinking:onInteract()
	if not self.nointeract and self.con == 0 then
		Assets.playSound("wing", 1, 1.4)
		self.growtime = self.timetogrow
		Game.world.timer:lerpVar(self, "timer", self.timer, self.maxtimer + self.timebuffer, self.growtime, 2, "in")
		self.con = 1
		return true
	end
	return false
end

function ChurchLanternShrinking:drawLightA()
    local x, y = self:getScreenPos()
	Draw.setColor(1, 1, 1, self.lightalpha)
	love.graphics.circle("fill", x, y, (self.size * 1.125) + (math.sin(self.siner / 30) * 2))
	Draw.setColor(1, 1, 1, 1)
end

function ChurchLanternShrinking:drawLightB()
	if self.draw_dimmer_light then
		local x, y = self:getScreenPos()
		Draw.setColor(1, 1, 1, self.lightalpha)
		love.graphics.circle("fill", x, y, self.size + (math.sin(self.siner / 30) * 2))
		Draw.setColor(1, 1, 1, 1)
	end
end

return ChurchLanternShrinking