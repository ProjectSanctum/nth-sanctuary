local ScythemareEffect, super = Class(Object)

function ScythemareEffect:init(x, y, count, success)
    super.init(self, x, y)

    self.texture = Assets.getTexture("effects/scythemare/scythe")
    self.zzz_tex = Assets.getFrames("effects/scythemare/zzz")
    self.slash_tex = Assets.getFrames("effects/scythemare/slash")
    self.spare_z_tex = Assets.getTexture("effects/spare/z")
    self.z_split_tex = Assets.getFrames("effects/scythemare/spare_z_split")

    self.success = success == nil or success
    self.siner = 0
	self.con = 0
	self.laugh = false
	self.pacify_sound = nil
	self.last_spin = 0
	self.last_altspin = 0
	self.count = count
end

function ScythemareEffect:inverseLerp(from, to, factor)
	if to == from then
		return 0
	end
    return (factor - from) / (to - from)
end

function ScythemareEffect:update()
    self.siner = self.siner + DTMULT
    self.alpha = (math.sin(self.siner / 9) - 0.3) + (self.success and 0.3 or 0)

	if self.siner < 6 then
		local timer = self.siner
		if timer >= 4 and self.con == 0 then
			Assets.playSound("impact")
			self.con = 1
		end
	elseif self.siner < 34 then
		local timer = self.siner - 6
		if timer >= 4 and self.num == 0 and self.con == 1 then
			self.pacify_sound = Assets.playSound("pacify")
			self.con = 2
		end
        self:remove()
    else
		local timer = self.siner - 34
		if timer >= 0 and self.con == 2 then
			if self.success then
				Game.world.timer:script(function(wait)
					Assets.playSound("swing", 1, 1.5 + (self.count * 0.25))
					wait(3/30)
					Assets.playSound("swing", 0.66, 1.5 + (self.count * 0.25))
					wait(3/30)
					Assets.playSound("swing", 0.32, 1.5 + (self.count * 0.25))
				end)
			else
				Assets.playSound("bump", 2, 1 + MathUtils.random(-0.5, 0.5))
			end
			if self.count == 0 then Assets.stopSound(self.pacify_sound)
			if self.joker then
				if self.laugh then
					Assets.playSound("joker_laugh0")
				end
			end
			self.con = 3
		end
    end
	if self.simer >= 64 then
		self:remove()
	end

    super.update(self)
end

function ScythemareEffect:draw()
    local r, g, b, a = self:getDrawColor()
	if self.siner < 6 then
		local timer = self.siner
		local sizer = MathUtils.lerp(4, 2, MathUtils.clamp(timer / 4, 0, 1))
		Draw.setColor(r, g, b, a * MathUtils.clamp(timer / 3, 0, 1))
		Draw.draw(self.texture, 0, 0, 0, sizer, sizer, self.texture:getWidth() / 2, self.texture:getHeight() / 2)
	elseif self.siner < 34 then
		local timer = self.siner - 6
		local spinease = MathUtils.lerp(-1.5707963267948966, 0, MathUtils.clamp(MathUtils.easeOutAccurate(timer / 10, 3), 0, 1))
		local swap = spinease > -1.5707963267948966 and true or false
		local sprite = swap and self.zzz_tex or self.texture
		if not swap then
			spinease = spinease * -1
		end
		local warp = MathUtils.lerp(4, 2, MathUtils.clamp(timer / 2, 0, 1))
		local crossfadeA = MathUtils.clamp(self:inverseLerp(8, 30, timer), 0, 1)
		local crossfadeB = MathUtils.clamp(self:inverseLerp(8, 20, timer), 0, 1)
		local spin = MathUtils.lerp(360, -90, MathUtils.easeInOutAccurate(timer / 20, 3))
		local altspin = MathUtils.lerp(360, -10, MathUtils.easeInOutAccurate(timer / 20, 3))
		if timer >= 20 then
			local spin = MathUtils.lerp(-20, 0, MathUtils.easeInAccurate((timer / 20) / 8, 3))
			local altspin = MathUtils.lerp(-10, 0, MathUtils.easeInAccurate((timer / 20) / 8, 3))
		end
		Draw.setColor(r, g, b, a * crossfadeB / 2)
		Draw.draw(self.spare_z_tex, 0, 0, -math.rad(self.last_altspin), 3, 3, self.spare_z_tex:getWidth() / 2, self.spare_z_tex:getHeight() / 2)
		Draw.setColor(r, g, b, a * crossfadeB)
		Draw.draw(self.spare_z_tex, 0, 0, -math.rad(altspin), 3, 3, self.spare_z_tex:getWidth() / 2, self.spare_z_tex:getHeight() / 2)
		self.last_altspin = altspin
		if timer >= 20 then
			local spin = MathUtils.lerp(-90, 10, MathUtils.easeInAccurate((timer / 20) / 8, 3))
		end
		Draw.setColor(r, g, b, a * (1 - (crossfadeA / 2)))
		Draw.draw(self.texture, 0, 0, -math.rad(self.last_spin), 3, 3, self.texture:getWidth() / 2, self.texture:getHeight() / 2)
		Draw.setColor(r, g, b, a * (1 - crossfadeA))
		Draw.draw(self.texture, 0, 0, -math.rad(spin), 3, 3, self.texture:getWidth() / 2, self.texture:getHeight() / 2)
		self.last_spin = spin
	else
		local timer = self.siner - 34
		local lerp = MathUtils.clamp(self:inverseLerp(6, 24, timer), 0, 1)
		local tween = MathUtils.easeOutAccurate(lerp, 2) * 20
		if self.success then
			local alpha = MathUtils.clamp(MathUtils.lerp(1, 0, timer / 20), 0, 1)
			Draw.setColor(r, g, b, a * alpha)
			Draw.draw(self.z_split_tex[1], tween, 0, 0, 3, 3, self.z_split_tex:getWidth() / 2, self.z_split_tex:getHeight() / 2)
			Draw.draw(self.z_split_tex[2], -tween, 0, 0, 3, 3, self.z_split_tex:getWidth() / 2, self.z_split_tex:getHeight() / 2)
			Draw.draw(self.z_split_tex[1], tween * 2, 0, 0, 3, 3, self.z_split_tex:getWidth() / 2, self.z_split_tex:getHeight() / 2)
			Draw.draw(self.z_split_tex[2], -tween * 2, 0, 0, 3, 3, self.z_split_tex:getWidth() / 2, self.z_split_tex:getHeight() / 2)
		else
			local shake = 0
			if timer < 8 then
				shake = (8 - timer) * (((timer % 2) * 2) - 1)
				lerp = 0
				tween = 0
			else
				lerp = MathUtils.clamp(self:inverseLerp(8, 22, timer), 0, 1)
				tween = MathUtils.easeInAccurate(lerp, 2) * 6
			end
			Draw.setColor(r, g, b, a * (1 - lerp))
			Draw.draw(self.spare_z_tex, tween + shake, (tween * 10), -math.rad(-tween * 5), 3, 3, self.spare_z_tex:getWidth() / 2, self.spare_z_tex:getHeight() / 2)
		end
		if timer < 9 then
			Draw.setColor(r, g, b, a)
			Draw.draw(self.slash_tex[math.floor((timer / 3 % self.slash_tex) + 1], 0, 0, -math.rad(90), 1, 2, self.slash_tex:getWidth() / 2, self.slash_tex:getHeight() / 2)
		end
	end

    Draw.setColor(r, g, b, a)
    super.draw(self)
end

return ScythemareEffect