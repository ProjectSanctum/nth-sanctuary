local OverworldActionBox, super = HookSystem.hookScript(OverworldActionBox)

function OverworldActionBox:init(x, y, index, chara)
    super.init(self, x, y, index, chara)
	
	if chara.id == "lobby_man" then
		local static_fx = ShaderFX(Mod.staticBulletShader, {
			["time"] = function() return Kristal.getTime() end,
			["brightness"] = 0.5
		})
		self.head_sprite:addFX(static_fx, "static_fx")
	end
end

function OverworldActionBox:setHeadIcon(icon)
	super.setHeadIcon(self, icon)
	if self.chara.id == "lobby_man" then
		if icon == "heart" then
			self.head_sprite:getFX("static_fx").active = false
		else
			self.head_sprite:getFX("static_fx").active = true
		end
	end
end

function OverworldActionBox:draw()
    -- Draw the line at the top
	local health_bg_col = PALETTE["action_health_bg"]
    if self.selected then
        Draw.setColor(self.chara:getColor())
		if self.chara.id == "lobby_man" then
			health_bg_col = COLORS.dkgray
            Draw.setColor(COLORS.white)
			local static_shader = Mod.staticBulletShader
			static_shader:send("time", Kristal.getTime())
			static_shader:send("brightness", 1)
            love.graphics.setShader(static_shader)
		end
    else
        Draw.setColor(PALETTE["action_strip"])
		if self.chara.id == "lobby_man" then
			health_bg_col = COLORS.dkgray
		end
    end

    love.graphics.setLineWidth(2)
    love.graphics.line(0, 1, 213, 1)
    
    if Game:getConfig("oldUIPositions") then
        love.graphics.line(0, 2, 2, 2)
        love.graphics.line(211, 2, 213, 2)
    end
    love.graphics.setShader()

    -- Draw health
    Draw.setColor(health_bg_col)
    love.graphics.rectangle("fill", 128, 24, 76, 9)

    local health = (self.chara:getHealth() / self.chara:getStat("health")) * 76

    if health > 0 then
        Draw.setColor(self.chara:getColor())
		if self.chara.id == "lobby_man" then
            Draw.setColor(COLORS.white)
			local static_shader = Mod.staticBulletShader
			static_shader:send("time", Kristal.getTime())
			static_shader:send("brightness", 1)
            love.graphics.setShader(static_shader)
		end
        love.graphics.rectangle("fill", 128, 24, math.ceil(health), 9)
    end
    love.graphics.setShader()

    local color = PALETTE["action_health_text"]
    if health <= 0 then
        color = PALETTE["action_health_text_down"]
    elseif (self.chara:getHealth() <= (self.chara:getStat("health") / 4)) then
        color = PALETTE["action_health_text_low"]
    else
        color = PALETTE["action_health_text"]
    end

    local health_offset = 0
    health_offset = (#tostring(self.chara:getHealth()) - 1) * 8

    Draw.setColor(color)
    love.graphics.setFont(self.font)
    love.graphics.print(self.chara:getHealth(), 152 - health_offset, 11)
    Draw.setColor(PALETTE["action_health_text"])
    love.graphics.print("/", 161, 11)
    local string_width = self.font:getWidth(tostring(self.chara:getStat("health")))
    Draw.setColor(color)
    love.graphics.print(self.chara:getStat("health"), 205 - string_width, 11)

    -- Draw name text if there's no sprite
    if not self.name_sprite then
        local font = Assets.getFont("name")
        love.graphics.setFont(font)
        Draw.setColor(1, 1, 1, 1)

        local name = self.chara:getName():upper()
        local spacing = 5 - StringUtils.len(name)

        local off = 0
        for i = 1, StringUtils.len(name) do
            local letter = StringUtils.sub(name, i, i)
            love.graphics.print(letter, 51 + off, 16 - 1)
            off = off + font:getWidth(letter) + spacing
        end
    end

    local reaction_x = -1

    if self.x == 0 then -- lazy check for leftmost party member
        reaction_x = 3
    end

    love.graphics.setFont(self.main_font)
    Draw.setColor(1, 1, 1, self.reaction_alpha / 6)
    love.graphics.print(self.reaction_text, reaction_x, 43, 0, 0.5, 0.5)

    super.super.draw(self)
end

return OverworldActionBox