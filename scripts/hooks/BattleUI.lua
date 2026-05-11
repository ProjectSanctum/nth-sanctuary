local BattleUI, super = HookSystem.hookScript(BattleUI)

function BattleUI:drawState()
	super.drawState(self)
    if Game.battle.state == "MENUSELECT" then
        local page = math.ceil(Game.battle.current_menu_y / 3) - 1
        local max_page = math.ceil(#Game.battle.menu_items / 6) - 1

        local x = 0
        local y = 0
        local font = Assets.getFont("main")
        love.graphics.setFont(font)

        local page_offset = page * 6
        for i = page_offset + 1, math.min(page_offset + 6, #Game.battle.menu_items) do
            local item = Game.battle.menu_items[i]

            Draw.setColor(1, 1, 1, 1)
            local text_offset = 0
            -- Are we able to select this?
            local able = Game.battle:canSelectMenuItem(item)
            if item.party then
                if not able then
                    -- We're not able to select this, so make the heads gray.
                    Draw.setColor(COLORS.gray)
                end

                for index, party_id in ipairs(item.party) do
                    local chara = Game:getPartyMember(party_id)

                    -- Draw head only if it isn't the currently selected character
                    if Game.battle:getPartyIndex(party_id) ~= Game.battle.current_selecting then
						if chara.id == "lobbyman_party" then
							local static_shader = Mod.staticBulletShader
							static_shader:send("time", Kristal.getTime())
							static_shader:send("brightness", 0.5)
							love.graphics.setShader(static_shader)
						end
                        local ox, oy = chara:getHeadIconOffset()
                        Draw.draw(Assets.getTexture(chara:getHeadIcons() .. "/head"), text_offset + 30 + (x * 230) + ox, 50 + (y * 30) + oy)
						love.graphics.setShader()
                        text_offset = text_offset + 30
                    end
                end
            end

            if item.icons then
                for _, icon in ipairs(item.icons) do
                    if type(icon) == "string" then
                        icon = { icon, false, 0, 0, nil }
                    end
                    if not icon[2] then
                        local texture = Assets.getTexture(icon[1])
                        text_offset = text_offset + (icon[5] or texture:getWidth())
                    end
                end
            end

            if able then
                -- Using color like a function feels wrong... should this be called getColor?
                Draw.setColor(item:color() or { 1, 1, 1, 1 })
				if item.name == Game.battle.party[Game.battle.current_selecting].chara:getXActName() and Game.battle.party[Game.battle.current_selecting].chara.id == "lobbyman_party" then
					local static_shader = Mod.staticBulletShader
					static_shader:send("time", Kristal.getTime())
					static_shader:send("brightness", 0.3)
					love.graphics.setShader(static_shader)
				end
            else
                Draw.setColor(COLORS.gray)
            end
            love.graphics.print(item.name, text_offset + 30 + (x * 230), 50 + (y * 30))
            text_offset = text_offset + font:getWidth(item.name)
			love.graphics.setShader()

            if item.icons then
                if able then
                    Draw.setColor(1, 1, 1)
                end
                for _, icon in ipairs(item.icons) do
                    if type(icon) == "string" then
                        icon = { icon, false, 0, 0, nil }
                    end
                    if icon[2] then
                        local texture = Assets.getTexture(icon[1])
                        text_offset = text_offset + (icon[5] or texture:getWidth())
                    end
                end
            end

            if x == 0 then
                x = 1
            else
                x = 0
                y = y + 1
            end
        end
	elseif Game.battle.state == "ENEMYSELECT" then 
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
                if Game.battle.state_reason == "XACT" then
					if Game.battle.party[Game.battle.current_selecting].chara.id == "lobbyman_party" then
						Draw.setColor(COLORS.white)
						local static_shader = Mod.staticBulletShader
						static_shader:send("time", Kristal.getTime())
						static_shader:send("brightness", 0.3)
						love.graphics.setShader(static_shader)
					else
						Draw.setColor(Game.battle.party[Game.battle.current_selecting].chara:getXActColor())					
					end
                    if Game.battle.selected_xaction.id == 0 then
                        love.graphics.print(enemy:getXAction(Game.battle.party[Game.battle.current_selecting]), self.xact_x_pos, 50 + y_off)
                    else
                        love.graphics.print(Game.battle.selected_xaction.name, self.xact_x_pos, 50 + y_off)
                    end
					love.graphics.setShader()
				else
                    local hp_percent = enemy.health / enemy.max_health

                    local hp_x = draw_mercy and 420 or 510

                    if enemy.selectable and enemy.static_hp then
                        -- Draw the enemy's HP
                        Draw.setColor(COLORS.dkgray)
                        love.graphics.rectangle("fill", hp_x, 55 + y_off, 81, 16)

                        Draw.setColor(COLORS.white)
						local static_shader = Mod.staticBulletShader
						static_shader:send("time", Kristal.getTime())
						static_shader:send("brightness", 1)
                        love.graphics.setShader(static_shader)
                        love.graphics.rectangle("fill", hp_x, 55 + y_off, math.ceil(hp_percent * 81), 16)
                        love.graphics.setShader()

                        if draw_percents then
							love.graphics.stencil(function()
								local last_shader = love.graphics.getShader()
								love.graphics.setShader(Kristal.Shaders["Mask"])
								love.graphics.rectangle("fill", hp_x, 55 + y_off, math.ceil(hp_percent * 81), 16)
								love.graphics.setShader(last_shader)
							end, "replace", 1)
							love.graphics.setStencilTest("greater", 0)
                            Draw.setColor(COLORS.black)
                            love.graphics.print(enemy:getHealthDisplay(), hp_x + 4, 55 + y_off, 0, 1, 0.5)
							love.graphics.setStencilTest("less", 1)
                            Draw.setColor(COLORS.white)
                            love.graphics.print(enemy:getHealthDisplay(), hp_x + 4, 55 + y_off, 0, 1, 0.5)
							love.graphics.setStencilTest()
                        end
                    end
                end
			end
        end
	end
end

return BattleUI