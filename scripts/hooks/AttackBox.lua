local AttackBox, super = HookSystem.hookScript(AttackBox)

function AttackBox:init(battler, offset, index, x, y)
    super.init(self, battler, offset, index, x, y)
	self.BOLTSPEED = 8
	if battler.chara.id == "lobbyman_party" then
		local static_fx = ShaderFX(Mod.staticBulletShader, {
			["time"] = function() return Kristal.getTime() end,
			["brightness"] = 0.5
		})
		self.head_sprite:addFX(static_fx, "static_fx")
	end
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