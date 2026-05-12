local DamageNumber, super = HookSystem.hookScript(DamageNumber)

function DamageNumber:init(type, arg, x, y, color, delay, chara)
    super.init(self, type, arg, x, y, color, delay)

	if chara and chara.id == "lobbyman_party" and type == "damage" then
		local static_fx = ShaderFX(Mod.staticBulletShader, {
			["time"] = function() return Kristal.getTime() end,
			["brightness"] = 0.3
		})
		self:addFX(static_fx, "static_fx")
	end
end

return DamageNumber