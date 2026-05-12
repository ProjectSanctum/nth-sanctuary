local ActionBox, super = HookSystem.hookScript(ActionBox)

function ActionBox:init(x, y, index, battler)
    super.init(self, x, y, index, battler)

	if battler.chara.id == "lobbyman_party" then
		local static_fx = ShaderFX(Mod.staticBulletShader, {
			["time"] = function() return Kristal.getTime() end,
			["brightness"] = 0.5
		})
		self.head_sprite:addFX(static_fx, "static_fx")
	end
end

function ActionBox:drawActionBox()
    if Game.battle.current_selecting == self.index then
		if self.battler.chara.id == "lobbyman_party" then
            Draw.setColor(COLORS.white)
			local static_shader = Mod.staticBulletShader
			static_shader:send("time", Kristal.getTime())
			static_shader:send("brightness", 1)
            love.graphics.setShader(static_shader)
		end
        Draw.setColor(self.battler.chara:getColor())
        love.graphics.setLineWidth(2)
        love.graphics.line(1  , 2, 1,   37)
        love.graphics.line(Game:getConfig("oldUIPositions") and 211 or 212, 2, Game:getConfig("oldUIPositions") and 211 or 212, 37)
        love.graphics.line(0  , 6, 212, 6 )
        love.graphics.setShader()
    end
    Draw.setColor(1, 1, 1, 1)
end

function ActionBox:drawSelectionMatrix()
    -- Draw the background of the selection matrix
    Draw.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", 2, 2, 209, 35)

    if Game.battle.current_selecting == self.index then
        local r,g,b,a = self.battler.chara:getColor()
		if self.battler.chara.id == "lobbyman_party" then
            r,g,b,a = 1,1,1,1
			local static_shader = Mod.staticBulletShader
			static_shader:send("time", Kristal.getTime())
			static_shader:send("brightness", 1)
            love.graphics.setShader(static_shader)
		end
		
        for i = 0, 11 do
            local siner = self.selection_siner + (i * (10 * math.pi))

            love.graphics.setLineWidth(2)
            Draw.setColor(r, g, b, a * math.sin(siner / 60))
            if math.cos(siner / 60) < 0 then
                love.graphics.line(1 - (math.sin(siner / 60) * 30) + 30, 0, 1 - (math.sin(siner / 60) * 30) + 30, 37)
                love.graphics.line(211 + (math.sin(siner / 60) * 30) - 30, 0, 211 + (math.sin(siner / 60) * 30) - 30, 37)
            end
        end
        love.graphics.setShader()

        Draw.setColor(1, 1, 1, 1)
    end
end

return ActionBox