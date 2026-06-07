local CreatureGueiTextbox, super = Class(Object)

function CreatureGueiTextbox:init(x, y, w, h, tailx, taily, taildir, frame)
    super.init(self, x, y)
	
	self.text_tex = Assets.getFramesOrTexture("bubbles/creature_guei/small")
	self.text_frame = frame or 1
	self.w = w or 60
	self.h = h or 40
	self.tailx = tailx or 220
	self.taily = taily or 140
	self.tail_direction = taildir or "top"
	self.spike_drawing = {
		top = true,
		left = true,
		right = true,
		bottom = true
	}
	
	self.draw_alpha = 0.7
	self.framethreshold = 3
	self.framecount = 3
	self.siner = 0
	self.text_offset_x = 0
	self.text_offset_y = 0
	
    self:setScale(1)
    self:setOrigin(1, 0)

    self.done = false

    self.wait_timer = 15/30
	self.canvas = love.graphics.newCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)
end

function CreatureGueiTextbox:advance()
    if self.wait_timer == 0 then
        self.done = true
        self:remove()
    end
end

function CreatureGueiTextbox:isTyping()
    return false
end

function CreatureGueiTextbox:isDone()
    return self.done
end

function CreatureGueiTextbox:onAddToStage(stage)
    super.onAddToStage(self, stage)
end

function CreatureGueiTextbox:onRemove()
    self.canvas:release()
    self.canvas = nil
end

function CreatureGueiTextbox:update()
    self.wait_timer = MathUtils.approach(self.wait_timer, 0, DT)

    if Input.pressed("confirm") or Input.down("menu") then
        self:advance()
    end
end

function CreatureGueiTextbox:draw()
    super.draw(self)
	self.framecount = self.framecount + DTMULT
	local xx, yy = 0, 0
	local surfaceupdate = false
	local r = 1
	if self.framecount >= self.framethreshold or not self.init then
		surfaceupdate = true
	end
	if surfaceupdate then
		self.siner = self.siner + r
		local x1 = (self.x - xx) + (MathUtils.random(-1, 2) * r) + (math.sin(self.siner / 3) * 3)
		local x2 = ((self.x + self.w) - xx) + (MathUtils.random(-1, 2) * r) + (math.sin(self.siner / 3) * 3)
		local y1 = (self.y - yy) + (MathUtils.random(-1, 2) * r) + (math.cos(self.siner / 3) * 3)
		local y2 = ((self.y + self.h) - yy) + (MathUtils.random(-1, 2) * r) + (math.cos(self.siner / 3) * 3)
		self.text_offset_x = x1 - self.x
		self.text_offset_y = y1 - self.y
		Draw.pushCanvas(self.canvas)
		love.graphics.clear()
		love.graphics.push()
		love.graphics.origin()
		Draw.setColor(COLORS.dkgray, 1)
		love.graphics.rectangle("fill", x1, y1, x2 - x1, y2 - y1)
		love.graphics.polygon("fill", {x1, y1, x1 + (self.w / 3), y1, x1 - (MathUtils.random(7) * r), y1 - 7 - (MathUtils.random(4) * r)})
		if self.spike_drawing["top"] then
			love.graphics.polygon("fill", {x1 + (self.w / 3), y1, x1 + ((self.w / 3) * 2), y1, x1 + (self.w / 2) + (MathUtils.random(-3, 4) * r), y1 - 7 + (MathUtils.random(4) * r)})
		end
		love.graphics.polygon("fill", {x2, y1, x2 - (self.w / 3), y1, x2 + (MathUtils.random(7) * r), y1 - 7 - (MathUtils.random(4) * r)})
		if self.spike_drawing["left"] then
			love.graphics.polygon("fill", {x1, y1, x1, y1 + (self.h / 2), x1 - 5 - (MathUtils.random(6) * r), y1 + (self.h / 4) + (MathUtils.random(-3, 4) * r)})
			love.graphics.polygon("fill", {x1, y1 + (self.h / 2), x1, y2, x1 - 5 - (MathUtils.random(6) * r), y2 - (self.h / 4) + (MathUtils.random(-3, 4) * r)})
		end
		if self.spike_drawing["right"] then
			love.graphics.polygon("fill", {x2, y1, x2, y1 + (self.h / 2), x2 + 5 + (MathUtils.random(6) * r), y1 + (self.h / 4) + (MathUtils.random(-3, 4) * r)})
			love.graphics.polygon("fill", {x2, y1 + (self.h / 2), x2, y2, x2 + 5 + (MathUtils.random(6) * r), y2 - (self.h / 4) + (MathUtils.random(-3, 4) * r)})
		end
		love.graphics.polygon("fill", {x1, y1, x1 + (self.w / 3), y2, x1 - (MathUtils.random(7) * r), y2 + 7 + (MathUtils.random(4) * r)})
		if self.spike_drawing["bottom"] then
			love.graphics.polygon("fill", {x1 + (self.w / 3), y2, x1 + ((self.w / 3) * 2), y2, x1 + (self.w / 2) + (MathUtils.random(-3, 4) * r), y2 + 7 + (MathUtils.random(4) * r)})
		end
		love.graphics.polygon("fill", {x2, y1, x2 - (self.w / 3), y2, x2 + (MathUtils.random(7) * r), y2 + 7 + (MathUtils.random(4) * r)})
		local t2x01 = x1 + (self.w / 3)
		local t2y01 = y1
		local t2x02 = x1 + ((self.w / 3) * 2)
		local t2y02 = y1
		local t2x1 = (x2 - (self.w / 3)) + (MathUtils.random(-2, 3) * r)
		local t2y1 = ((y1 + self.taily) / 2) + (MathUtils.random(-2, 3) * r)
		local t2x2 = (x1 + (self.w / 3)) + (MathUtils.random(-2, 3) * r)
		local t2y2 = t2y1
		local t2x3 = ((t2x1 + t2x2) / 2) + 1
		local t2y3 = y1 - 3
		local t2x4 = (self.tailx + (MathUtils.random(-3, 4) * r)) - xx
		local t2y4 = t2y2
		local t2x5 = (self.tailx + (MathUtils.random(-1, 2) * r)) - xx
		local t2y5 = (self.taily + (MathUtils.random(-1, 2) * r)) - yy
		if self.tail_direction == "bottom" then
			t2y01 = y2
			t2y02 = y2
			t2y1 = ((y2 + self.taily) / 2) + (MathUtils.random(-2, 3) * r)
			t2y2 = t2y1
			t2y3 = y2 + 3
			t2y4 = t2y2
		end	
		if self.tail_direction == "left" or self.tail_direction == "right" then	
			t2x01 = x1
			t2y01 = y1 + (self.h / 3)
			t2x02 = x1
			t2y02 = y1 + ((self.h / 3) * 2)
			t2x1 = ((x1 + self.tailx) / 2) + (MathUtils.random(-2, 3) * r)
			t2y1 = (y2 - (self.h / 3)) + (MathUtils.random(-2, 3) * r)
			t2x2 = t2x1
			t2y2 = (y1 + (self.h / 3)) + (MathUtils.random(-2, 3) * r)
			t2x3 = x1 - 3
			t2y3 = ((t2y1 + t2y2) / 2) + 1
			t2x4 = t2x2
			t2y4 = (self.taily + (MathUtils.random(-3, 4) * r)) - yy
		end
		if self.tail_direction == "right" then
			t2x01 = x2
			t2x02 = x2
			t2x1 = ((x2 + self.tailx) / 2) + (MathUtils.random(-2, 3) * r)
			t2x2 = t2x1
			t2x3 = x2 + 3
			t2x4 = t2x2
		end
		love.graphics.polygon("fill", {t2x01, t2y01, t2x02, t2y02, t2x1, t2y1})
		love.graphics.polygon("fill", {t2x1, t2y1, t2x2, t2y2, t2x3, t2y3})
		love.graphics.polygon("fill", {t2x2, t2y2, t2x4, t2y4, t2x5, t2y5})
		love.graphics.pop()
		Draw.popCanvas()
		self.framecount = 0
	end
	love.graphics.push()
	love.graphics.origin()
	Draw.setColor(1,1,1,self.draw_alpha)
	Draw.draw(self.canvas, -10, -10, 0, 1, 1)
	Draw.setColor(1,1,1,self.draw_alpha / 4)
	Draw.draw(self.canvas, -8, -8, 0, 1, 1)
	love.graphics.pop()
	Draw.setColor(1,1,1,1)
	local static_shader = Assets.getShader("static_bullet")
	static_shader:send("time", Kristal.getTime())
	static_shader:send("brightness", 0.3)
    love.graphics.setShader(static_shader)
	Draw.draw(self.text_tex[self.text_frame], self.text_offset_x, self.text_offset_y)
	for i = 0, 5 do
		Draw.setColor(1,1,1,0.7 - (i * 0.1))
		Draw.draw(self.text_tex[self.text_frame], self.text_offset_x - (i * 2) + MathUtils.random(i * 4), self.text_offset_y - (i * 2) + MathUtils.random(i * 4))
	end
    love.graphics.setShader()
	Draw.setColor(1,1,1,1)
end

return CreatureGueiTextbox