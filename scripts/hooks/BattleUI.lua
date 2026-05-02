local BattleUI, super = HookSystem.hookScript(BattleUI)

function BattleUI:drawState()
	super.drawState(self)
    if Game.battle.state == "ENEMYSELECT" then 
		local enemies = Game.battle.enemies_index
        local page = math.ceil(Game.battle.current_menu_y / 3) - 1
        local max_page = math.ceil(#enemies / 3) - 1
        local page_offset = page * 3
        Draw.setColor(1, 1, 1, 1)
        local font = Assets.getFont("main")
        love.graphics.setFont(font)
        local draw_mercy = Game:getConfig("mercyBar")
        local draw_percents = Game:getConfig("enemyBarPercentages")
        for index = page_offset + 1, math.min(page_offset + 3, #enemies) do
            local enemy = enemies[index]
            local y_off = (index - page_offset - 1) * 30

            if enemy then
                if Game.battle.state_reason ~= "XACT" then
                    local hp_percent = enemy.health / enemy.max_health

                    local hp_x = draw_mercy and 420 or 510

                    if enemy.selectable and enemy.static_hp then
                        -- Draw the enemy's HP
                        Draw.setColor(COLORS.black)
                        love.graphics.rectangle("fill", hp_x, 55 + y_off, 81, 16)

                        Draw.setColor(COLORS.white)
						local static_shader = Mod.staticBulletShader
						static_shader:send("time", Kristal.getTime())
						static_shader:send("brightness", 2)
                        love.graphics.setShader(static_shader)
                        love.graphics.rectangle("fill", hp_x, 55 + y_off, math.ceil(hp_percent * 81), 16)
                        love.graphics.setShader()

                        if draw_percents then
                            Draw.setColor(COLORS.white)
                            love.graphics.print(enemy:getHealthDisplay(), hp_x + 4, 55 + y_off, 0, 1, 0.5)
                        end
                    end
                end
			end
        end
	end
end

return BattleUI