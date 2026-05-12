local AttackBox, super = HookSystem.hookScript(AttackBox)

function AttackBox:init(battler, offset, index, x, y)
    super.super.init(self, x, y)
	self.BOLTSPEED = 8
    self.battler = battler
    self.offset = offset
    self.index = index

    self.head_sprite = Sprite(battler.chara:getHeadIcons() .. "/head", 21, 19)
    self.head_sprite:setOrigin(0.5, 0.5)
    self:addChild(self.head_sprite)
	if battler.chara.id == "lobbyman_party" then
		local static_fx = ShaderFX(Mod.staticBulletShader, {
			["time"] = function() return Kristal.getTime() end,
			["brightness"] = 0.5
		})
		self.head_sprite:addFX(static_fx, "static_fx")
	end

    self.press_sprite = Sprite("ui/battle/press", 42, 0)
    self:addChild(self.press_sprite)

    self.bolt_target = 80 + 2
    self.bolt_start_x = self.bolt_target + (self.offset * self.BOLTSPEED)

    self.bolt = AttackBar(self.bolt_start_x, 0, 6, 38)
    self.bolt.layer = 1
    self:addChild(self.bolt)

    self.fade_rect = Rectangle(0, 0, SCREEN_WIDTH, 300)
    self.fade_rect:setColor(0, 0, 0, 0)
    self.fade_rect.layer = 2
    self:addChild(self.fade_rect)

    self.afterimage_timer = 0
    self.afterimage_count = -1

    self.flash = 0

    self.attacked = false
    self.removing = false
end

function AttackBox:getClose()
    return (self.bolt.x - self.bolt_target - 2) / self.BOLTSPEED
end

function AttackBox:draw()
	if self.battler.chara.id == "lobbyman_party" then	
		local target_color = { self.battler.chara:getAttackBarColor() }
		local box_color = { self.battler.chara:getAttackBoxColor() }

		if self.flash > 0 then
			box_color = ColorUtils.mergeColor(box_color, { 1, 1, 1 }, self.flash)
		end

		love.graphics.setLineWidth(2)
		love.graphics.setLineStyle("rough")

		local ch1_offset = Game:getConfig("oldUIPositions")
		
		Draw.setColor(COLORS.gray)
		local static_shader = Mod.staticBulletShader
		static_shader:send("time", Kristal.getTime())
		static_shader:send("brightness", 0.5)
        love.graphics.setShader(static_shader)
		love.graphics.rectangle("line", 80, ch1_offset and 0 or 1, (15 * self.BOLTSPEED) + 3, ch1_offset and 37 or 36)
        love.graphics.setShader()
		Draw.setColor(1, 1, 1, self.flash)
		love.graphics.rectangle("line", 80, ch1_offset and 0 or 1, (15 * self.BOLTSPEED) + 3, ch1_offset and 37 or 36)
		
        love.graphics.setShader(static_shader)
		Draw.setColor(COLORS.white)
		love.graphics.rectangle("line", 83, 1, 8, 36)
        love.graphics.setShader()
		Draw.setColor(0, 0, 0)
		love.graphics.rectangle("fill", 84, 2, 6, 34)

		love.graphics.setLineWidth(1)
		
		super.super.draw(self)
	else
		super.draw(self)
	end
end

return AttackBox