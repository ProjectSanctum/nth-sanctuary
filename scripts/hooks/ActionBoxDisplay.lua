local ActionBoxDisplay, super = HookSystem.hookScript(ActionBoxDisplay)

function ActionBoxDisplay:draw()
	local health_bg_col = PALETTE["action_health_bg"]
    if Game.battle.current_selecting == self.actbox.index then
        Draw.setColor(self.actbox.battler.chara:getColor())
		if self.actbox.battler.chara.id == "lobby_man" then
			health_bg_col = COLORS.dkgray
            Draw.setColor(COLORS.white)
			local static_shader = Mod.staticBulletShader
			static_shader:send("time", Kristal.getTime())
			static_shader:send("brightness", 1)
            love.graphics.setShader(static_shader)
		end
    else
        Draw.setColor(PALETTE["action_strip"], 1)
		if self.actbox.battler.chara.id == "lobby_man" then
			health_bg_col = COLORS.dkgray
		end
    end

    love.graphics.setLineWidth(2)
    love.graphics.line(0  , Game:getConfig("oldUIPositions") and 2 or 1, 213, Game:getConfig("oldUIPositions") and 2 or 1)

    love.graphics.setLineWidth(2)
    if Game.battle.current_selecting == self.actbox.index then
        love.graphics.line(1  , 2, 1,   36)
        love.graphics.line(212, 2, 212, 36)
    end
    love.graphics.setShader()

    Draw.setColor(PALETTE["action_fill"])
    love.graphics.rectangle("fill", 2, Game:getConfig("oldUIPositions") and 3 or 2, 209, Game:getConfig("oldUIPositions") and 34 or 35)

    Draw.setColor(health_bg_col)
    love.graphics.rectangle("fill", 128, 22 - self.actbox.data_offset, 76, 9)

    local health = (self.actbox.battler.chara:getHealth() / self.actbox.battler.chara:getStat("health")) * 76

    if health > 0 then
        Draw.setColor(self.actbox.battler.chara:getColor())
		if self.actbox.battler.chara.id == "lobby_man" then
            Draw.setColor(COLORS.white)
			local static_shader = Mod.staticBulletShader
			static_shader:send("time", Kristal.getTime())
			static_shader:send("brightness", 1)
            love.graphics.setShader(static_shader)
		end
        love.graphics.rectangle("fill", 128, 22 - self.actbox.data_offset, math.ceil(health), 9)
    end
    love.graphics.setShader()

    local color = PALETTE["action_health_text"]
    if health <= 0 then
        color = PALETTE["action_health_text_down"]
    elseif (self.actbox.battler.chara:getHealth() <= (self.actbox.battler.chara:getStat("health") / 4)) then
        color = PALETTE["action_health_text_low"]
    else
        color = PALETTE["action_health_text"]
    end


    local health_offset = 0
    health_offset = (#tostring(self.actbox.battler.chara:getHealth()) - 1) * 8

    Draw.setColor(color)
    love.graphics.setFont(self.font)
    love.graphics.print(self.actbox.battler.chara:getHealth(), 152 - health_offset, 9 - self.actbox.data_offset)
    Draw.setColor(PALETTE["action_health_text"])
    love.graphics.print("/", 161, 9 - self.actbox.data_offset)
    local string_width = self.font:getWidth(tostring(self.actbox.battler.chara:getStat("health")))
    Draw.setColor(color)
    love.graphics.print(self.actbox.battler.chara:getStat("health"), 205 - string_width, 9 - self.actbox.data_offset)

    super.super.draw(self)
end

return ActionBoxDisplay