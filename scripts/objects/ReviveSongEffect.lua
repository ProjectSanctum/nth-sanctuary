---@class ReviveSongEffect : Object
---@overload fun(...) : ReviveSongEffect
local ReviveSongEffect, super = Class(Object)

function ReviveSongEffect:init(chara, x, y, after)
    super.init(self, x, y)
	
	self.timer = 0
	self.descent_con = 0
	self.feathers = {}
	self.offset = 2.141592653589793 -- ???
	self.xoff = 0
	self.yoff = 0
	self.chara = chara
	for _, chara in ipairs(Game.stage:getObjects(PartyBattler)) do
		if chara.y <= self.chara.y then
			chara.layer = chara.layer - 0.01
		end
	end
	self.yspawn = -5
	self.do_heal = false
    self.after_func = after
	self.spread = 60
	if chara.chara.id == "kris" then
		self.x = self.x + 20
		self.y = self.y + 10
		if chara.chara.health > 0 then
			self.xoff = self.xoff - 6
			self.yoff = self.yoff - 20
		end
	elseif chara.chara.id == "susie" then
		self.x = self.x + 30
		self.y = self.y + 20
		if chara.chara.health > 0 then
			self.yoff = self.yoff - 30
		else		
			self.yoff = self.yoff - 12
			self.xoff = self.xoff + 8
		end
	elseif chara.chara.id == "ralsei" then
		self.x = self.x + 34
		self.y = self.y + 26
		self.yoff = self.yoff - 22
		self.xoff = self.xoff + 2
	elseif chara.chara.id == "jamm" then
		self.x = self.x + 10
		self.y = self.y + 10
		if chara.chara.health > 0 then
			self.xoff = self.xoff + 4
			self.yoff = self.yoff - 20
		else
			self.x = self.x + 12
			self.yoff = self.yoff - 10
		end
	end
end

function ReviveSongEffect:update()
	super.update(self)
end

function ReviveSongEffect:onRemove(parent)
	super.onRemove(self, parent)
	for _, feather in ipairs(self.feathers) do
		if feather and not feather:isRemoved() then
			feather.layer = self.layer
		end
	end
	for _, chara in ipairs(Game.stage:getObjects(PartyBattler)) do
		if chara.y <= self.chara.y then
			chara.layer = chara.layer + 0.01
		end
	end
end

local function returnAlphaColor(color, value)
    local color = color
    return {
        color[1],
        color[2],
        color[3],
        color[4] * (value or 1),
    }
end

function ReviveSongEffect:drawCharacter(object)
    love.graphics.push()
    object:preDraw()
    object:draw()
    object:postDraw()
    love.graphics.pop()
end

function ReviveSongEffect:drawBeam(x, y, length, spread, dir, smooth)
	local xx = x
	local yy = y
	local length = length
	local spread = spread
	local dir = dir
	local end0 = {x = MathUtils.lengthDirX(length, math.rad(dir)),
	y = MathUtils.lengthDirY(length, math.rad(dir))}
	local end1 = {x = MathUtils.lengthDirX(length, math.rad(dir + (spread / 2))),
	y = MathUtils.lengthDirY(length, math.rad(dir + (spread / 2)))}
	local end2 = {x = MathUtils.lengthDirX(length, math.rad(dir - (spread / 2))),
	y = MathUtils.lengthDirY(length, math.rad(dir - (spread / 2)))}
	if smooth then
		love.graphics.circle("fill", end0.x + xx, end0.y + yy, spread / 2)
	end
	love.graphics.polygon("fill", xx, yy, end1.x + xx, end1.y + yy, end2.x + xx, end2.y + yy)
end

function ReviveSongEffect:draw()
    super.draw(self)
	local stupid_ass_chara_canvas = Draw.pushCanvas(640, 480)
	self:drawCharacter(self.chara)
	Draw.popCanvas(true)
	local descent = 10
	local spread = MathUtils.easeInOutAccurate(MathUtils.clamp(self.timer / 20, 0, 1), 4) * 20
	local length = 360 + math.sin((spread / 180) * math.pi) * 20
	local width = MathUtils.lengthDirX(length, math.rad(270 + (spread / 2)))
	local spotlight_height = -300 + 360
	Draw.setColor(returnAlphaColor(ColorUtils.hexToRGB("#FFCF6D"), self.alpha / 2))
	love.graphics.ellipse("fill", 0, spotlight_height, width, (width / 4))
	if self.timer >= descent and self.descent_con < 1 then
		self.descent_con = 1
		Assets.playSound("sparkle_glock", 1, 1.1)
		local feather = CherubFeather(self.x - 10, self.y - 50)
		feather.physics.direction = -math.rad(270 + MathUtils.randomInt(-30, -50))
        feather.layer = self.layer - 0.01
        Game.battle:addChild(feather)
		table.insert(self.feathers, feather)
		local feather = CherubFeather(self.x, self.y - 50)
		feather.physics.direction = -math.rad(270 + MathUtils.randomInt(10, 10))
        feather.layer = self.layer - 0.01
        Game.battle:addChild(feather)
		table.insert(self.feathers, feather)
		local feather = CherubFeather(self.x + 10, self.y - 50)
		feather.physics.direction = -math.rad(270 + MathUtils.randomInt(30, 50))
        feather.layer = self.layer - 0.01
        Game.battle:addChild(feather)
		table.insert(self.feathers, feather)
	end
	love.graphics.translate(-self.x, -self.y)
	love.graphics.setShader(Kristal.Shaders["AddColor"])
	Kristal.Shaders["AddColor"]:sendColor("inputcolor", ColorUtils.hexToRGB("#FFB56C"))
	Kristal.Shaders["AddColor"]:send("amount", MathUtils.clamp(spread * self.alpha, 0, 1))
	if (spread * self.alpha) > 0 then
		Draw.setColor(1,1,1,spread * self.alpha)
		Draw.draw(stupid_ass_chara_canvas, 0, -2)
		Draw.setColor(1,1,1,1)
		love.graphics.setShader()
		Draw.setColor(returnAlphaColor(ColorUtils.hexToRGB("#807976"), MathUtils.clamp(spread * self.alpha, 0, 1)))
		Draw.draw(stupid_ass_chara_canvas, 0, 0)
		Draw.setColor(1,1,1,1)
	end
	for _, feather in ipairs(self.feathers) do
		if feather and not feather:isRemoved() then
			self:drawCharacter(feather)
		end
	end
	love.graphics.translate(self.x, self.y)
	local light_canvas = Draw.pushCanvas(128, 400)
	love.graphics.stencil((function ()
		love.graphics.setShader(Kristal.Shaders["Mask"])
		love.graphics.translate(-self.x+64, -self.y+300-2)
		self:drawCharacter(self.chara)
		love.graphics.translate(0, 2)
		self:drawCharacter(self.chara)
		love.graphics.setShader()
		love.graphics.translate(self.x-64, self.y-300)
	end), "replace", 1)	
	love.graphics.stencil((function ()
		love.graphics.translate(-self.x+64, -self.y+300)
		love.graphics.setShader(Kristal.Shaders["Mask"])
		for _, feather in ipairs(self.feathers) do
			if feather and not feather:isRemoved() then
				self:drawCharacter(feather)
			end
		end
		love.graphics.setShader()
		love.graphics.translate(self.x-64, self.y-300)
	end), "decrement", 1, true)
	love.graphics.setStencilTest("less", 1)
	Draw.setColor(1,1,1,1)
	self:drawBeam(64, 0, length, spread, 270, false)
	love.graphics.ellipse("fill", 64, 360, width, (width / 4))
	love.graphics.setStencilTest()
	Draw.popCanvas(true)
	Draw.setColor(returnAlphaColor(ColorUtils.hexToRGB("#FFB56C"), self.alpha / 2))
	Draw.draw(light_canvas, -64, -300)
	Draw.setColor(1,1,1,1)
	if self.timer >= descent + 24 then
		if self.timer >= descent + 24 and self.descent_con < 2 then
            local cherub = Sprite("effects/titan/ralsei_cherub")
            cherub:setOrigin(0.5, 0.5)
            cherub:setScale(2, 2)
            cherub:setPosition(self.x + 30 + self.xoff, self.y + self.yoff)
            cherub.layer = self.layer + 0.01
            cherub:play(1/30, false, function(s) s:remove() end)
            Game.battle:addChild(cherub)
            local cherub2 = Sprite("effects/titan/ralsei_cherub")
            cherub2:setOrigin(0.5, 0.5)
            cherub2:setScale(-2, 2)
            cherub2:setPosition((self.x + 30 + self.xoff) - self.spread, self.y + self.yoff)
            cherub2.layer = self.layer + 0.01
            cherub2:play(1/30, false, function(s) s:remove() end)
            Game.battle:addChild(cherub2)
			self.descent_con = 2
		elseif self.timer >= descent + 48 and self.descent_con < 3 then
			if not self.do_heal then
				if self.after_func then
					self.after_func()
				end
				self.do_heal = true
			end
			self:fadeOutSpeedAndRemove(0.1)
			self.descent_con = 3
		end
	elseif self.timer >= descent and self.timer <= descent + 24 then
		local xx = self.x
		local ylerp = self.timer - descent
		local yy = MathUtils.lerp(self.yspawn, self.y + self.yoff, MathUtils.clamp(ylerp / 25, 0, 1))
		if self.timer % 2 == 0 then
            local star = Sprite("effects/spare/star")
            star:setOrigin(0.5, 0.5)
            star:setScale(2, 2)
			star:setColor(TableUtils.pick({ColorUtils.hexToRGB("#FFE04D"), ColorUtils.hexToRGB("#FFB56C")}))
            star:setPosition(xx + math.cos((self.timer / 3) + self.offset) * 30, yy + math.sin((self.timer / 3) + self.offset) * 10)
            star.layer = self.layer + 0.01
            star:play(1/15, false, function(s) s:remove() end)
            Game.battle:addChild(star)
            local star2 = Sprite("effects/spare/star")
            star2:setOrigin(0.5, 0.5)
            star2:setScale(2, 2)
			star2:setColor(TableUtils.pick({ColorUtils.hexToRGB("#FFE04D"), ColorUtils.hexToRGB("#FFB56C")}))
            star2:setPosition(xx - math.sin((self.timer / 3) + self.offset) * 30, yy - math.cos((self.timer / 3) + self.offset) * 10)
            star2.layer = self.layer + 0.01
            star2:play(1/15, false, function(s) s:remove() end)
            Game.battle:addChild(star2)
		end
	end
	self.timer = self.timer + DTMULT
end

return ReviveSongEffect