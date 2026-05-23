local SpeechSpikeBubble, super = Class(SpeechBubble)

function SpeechSpikeBubble:init(text, x, y, options, speaker)
    super.init(self, text, x, y, options, speaker)
	if Game.state ~= "BATTLE" then
	    self.layer = WORLD_LAYERS["textbox"] - 1
	end
	
	self.bg_color = options["bg_color"] or COLORS.black
	self.text.line_offset = options["line_offset"] or 0
	
	self.centered = options["center"] ~= false
	self.w = options["width"] or 60
	self.h = options["height"] or 40
	self.tailx = options["tailx"] or 220
	self.taily = options["taily"] or 140
	self.tail_direction = options["taildir"] or "top"
	self.spike_drawing = {
		top = options["spiketop"] or true,
		left = options["spikeleft"] or true,
		right = options["spikeright"] or true,
		bottom = options["spikebottom"] or true
	}
	
	self.draw_alpha = options["alpha"] or 0.7
	self.framethreshold = options["frames"] or 3
	self.tail_bug = options["tailbug"] or false
	self.framecount = self.framethreshold
	self.siner = 0
	self.remcamerax = xx
	self.remcameray = yy
	if options["small"] then
		self.scaled = 1
		self.canvas = love.graphics.newCanvas(SCREEN_WIDTH + 20, SCREEN_HEIGHT + 20)
	else
		self.scaled = 2
		self.canvas = love.graphics.newCanvas((SCREEN_WIDTH / 2) + 10, (SCREEN_HEIGHT / 2) + 10)
	end
	if Game.state == "BATTLE" then
		xx = Game.battle.camera.x - SCREEN_WIDTH / 2
		yy = Game.battle.camera.y - SCREEN_HEIGHT / 2
	else
		xx = Game.world.camera.x - SCREEN_WIDTH / 2
		yy = Game.world.camera.y - SCREEN_HEIGHT / 2
	end
    self:updateSize()
	if self.centered then
		self.x = self.x + (self.text_width + 20) / 2
	end
	self.remcamerax = xx
	self.remcameray = yy
end

function SpeechSpikeBubble:onRemove()
    self.canvas:release()
    self.canvas = nil
end

function SpeechSpikeBubble:updateSize()
    if self.auto then
        local w, h = self.text:getTextWidth(), self.text:getTextHeight()

        self.text_width = w
        self.text_height = h

        self.width = w + 20
        self.height = h + 20
		local scaled = self.scaled or 2
		self.w = (self.text_width + 20) / scaled
		self.h = (self.text_height + 35) / scaled
    end
end

function SpeechSpikeBubble:draw()
	self.framecount = self.framecount + DTMULT
	local xx, yy = 0, 0
	xx = Game.world.camera.x - SCREEN_WIDTH / 2
	yy = Game.world.camera.y - SCREEN_HEIGHT / 2
	if Game.state == "BATTLE" then
		xx = Game.battle.camera.x - SCREEN_WIDTH / 2
		yy = Game.battle.camera.y - SCREEN_HEIGHT / 2
	else
		xx = Game.world.camera.x - SCREEN_WIDTH / 2
		yy = Game.world.camera.y - SCREEN_HEIGHT / 2
	end
	local surfaceupdate = false
	local r = 1
	if self.framecount >= self.framethreshold or not self.init then
		surfaceupdate = true
	end
	if self.remcamerax ~= xx or self.remcameray ~= yy then
		r = 0.5
		surfaceupdate = true
	end
	if surfaceupdate then
		self.siner = self.siner + r
		local x = self.x - (self.centered and self.w * self.scaled or self.w * self.scaled)
		local y = self.y - ((self.text_height * 0.25) + 4 * (self.scaled == 2 and 1 or 2)) * 2
		local x1 = ((x - xx) / self.scaled) + (MathUtils.random(-1, 2) * r) + (math.sin(self.siner / 3) * 3)
		local x2 = (((x + (self.w * self.scaled)) - xx) / self.scaled) + (MathUtils.random(-1, 2) * r) + (math.sin(self.siner / 3) * 3)
		local y1 = ((y - yy) / self.scaled) + (MathUtils.random(-1, 2) * r) + (math.cos(self.siner / 3) * 3)
		local y2 = (((y + (self.h * self.scaled)) - yy) / self.scaled) + (MathUtils.random(-1, 2) * r) + (math.cos(self.siner / 3) * 3)
		Draw.pushCanvas(self.canvas)
		love.graphics.clear()
		love.graphics.push()
		love.graphics.origin()
		Draw.setColor(self.bg_color)
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
		local tailx = self.tailx / self.scaled
		local taily = self.taily / self.scaled
		local yyfix = self.tail_bug and 0 or yy / self.scaled
		local t2x01 = x1 + (self.w / 3)
		local t2y01 = y1
		local t2x02 = x1 + ((self.w / 3) * 2)
		local t2y02 = y1
		local t2x1 = (x2 - (self.w / 3)) + (MathUtils.random(-2, 3) * r)
		local t2y1 = ((y1 + (taily - yyfix)) / 2) + (MathUtils.random(-2, 3) * r)
		local t2x2 = (x1 + (self.w / 3)) + (MathUtils.random(-2, 3) * r)
		local t2y2 = t2y1
		local t2x3 = ((t2x1 + t2x2) / 2) + 1
		local t2y3 = y1 - 3
		local t2x4 = (tailx + (MathUtils.random(-3, 4) * r)) - (xx / self.scaled)
		local t2y4 = t2y2
		local t2x5 = (tailx + (MathUtils.random(-1, 2) * r)) - (xx / self.scaled)
		local t2y5 = (taily + (MathUtils.random(-1, 2) * r)) - (yy / self.scaled)
		if self.tail_direction == "bottom" then
			t2y01 = y2
			t2y02 = y2
			t2y1 = ((y2 + (taily - yyfix)) / 2) + (MathUtils.random(-2, 3) * r)
			t2y2 = t2y1
			t2y3 = y2 + 3
			t2y4 = t2y2
		end	
		if self.tail_direction == "left" or self.tail_direction == "right" then
			yyfix = self.tail_bug and 0 or xx / self.scaled
			t2x01 = x1
			t2y01 = y1 + (self.h / 3)
			t2x02 = x1
			t2y02 = y1 + ((self.h / 3) * 2)
			t2x1 = ((x1 + (tailx - yyfix)) / 2) + (MathUtils.random(-2, 3) * r)
			t2y1 = (y2 - (self.h / 3)) + (MathUtils.random(-2, 3) * r)
			t2x2 = t2x1
			t2y2 = (y1 + (self.h / 3)) + (MathUtils.random(-2, 3) * r)
			t2x3 = x1 - 3
			t2y3 = ((t2y1 + t2y2) / 2) + 1
			t2x4 = t2x2
			t2y4 = (taily + (MathUtils.random(-3, 4) * r)) - (yy / self.scaled)
		end
		if self.tail_direction == "right" then
			t2x01 = x2
			t2x02 = x2
			t2x1 = ((x2 + (tailx - yyfix)) / 2) + (MathUtils.random(-2, 3) * r)
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
	Draw.draw(self.canvas, -(10 * self.scaled), -(10 * self.scaled), 0, self.scaled, self.scaled)
	Draw.setColor(1,1,1,self.draw_alpha / 4)
	Draw.draw(self.canvas, -(8 * self.scaled), -(8 * self.scaled), 0, self.scaled, self.scaled)
	love.graphics.pop()
	Draw.setColor(1,1,1,1)
	if Game.state == "BATTLE" then
		xx = Game.battle.camera.x - SCREEN_WIDTH / 2
		yy = Game.battle.camera.y - SCREEN_HEIGHT / 2
	else
		xx = Game.world.camera.x - SCREEN_WIDTH / 2
		yy = Game.world.camera.y - SCREEN_HEIGHT / 2
	end
	self.remcamerax = xx
	self.remcameray = yy
    super.super.draw(self)
end

return SpeechSpikeBubble