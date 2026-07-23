---@class DarkMenu : Object
---@overload fun(...) : DarkMenu
local DarkMenu, super = HookSystem.hookScript(DarkMenu)

function DarkMenu:init()
    super.init(self, 0, -80)
	self.shard_sprite = Assets.getTexture("ui/menu/icon/shard")
end

function DarkMenu:draw()
    super.draw(self)
    if not self.description_box.visible then
		Draw.setColor(COLORS.black)
		love.graphics.rectangle("fill",510, 10, 100, 60)
		Draw.setColor(COLORS.white)
        love.graphics.print(Game:getConfig("darkCurrencyShort") .. " " .. Game.money, 520, 10)
        Draw.draw(self.shard_sprite, 520, 46, 0, 2, 2)
	    local shards = tostring(Mod:getDarkShardCount())
        love.graphics.print(shards, 554, 41)
    end
    if self.box then return end --scary
    love.graphics.push("all")
    love.graphics.origin()
    for k, party in ipairs(Game.party) do
        if k > 3 then
            local col = math.floor((k - 4) / 11)
            local row = (k - 4) % 11

            local x_head  = MathUtils.rangeMap(self.y, -80, 0, -100, 20  + col * 150)
            local x_bar   = MathUtils.rangeMap(self.y, -80, 0, -100, 60  + col * 150)
            local x_text  = MathUtils.rangeMap(self.y, -80, 0, -100, 60  + col * 150)
            local y_pos   = 90 + 30 * row

            Draw.setColor(1, 1, 1, 1)
			if party.id == "lobby_man" then
				local static_shader = Assets.getShader("static_bullet")
				static_shader:send("time", Kristal.getTime())
				static_shader:send("brightness", 0.5)
				love.graphics.setShader(static_shader)
			end
            local a = Assets.getTexture(party:getHeadIcons().."/head")
            Draw.draw(a, x_head, y_pos)

            local health = (party:getHealth() / party:getStat("health")) * 100
			local health_bg_col = PALETTE["action_health_bg"]
			if party.id == "lobby_man" then
				health_bg_col = COLORS.dkgray
			end
            Draw.setColor(health_bg_col)
            Draw.rectangle("fill", x_bar, y_pos + 10, 100, 10)
            Draw.setColor(party:getColor())
			if party.id == "lobby_man" then
				Draw.setColor(COLORS.white)
				local static_shader = Assets.getShader("static_bullet")
				static_shader:send("time", Kristal.getTime())
				static_shader:send("brightness", 1)
				love.graphics.setShader(static_shader)
			end
            Draw.rectangle("fill", x_bar, y_pos + 10, math.ceil(health), 10)
			love.graphics.setShader()

            love.graphics.setFont(Assets.getFont("smallnumbers"))
            local color
            if (party:getHealth() <= (party:getStat("health") / 4)) then
                color = PALETTE["action_health_text_low"]
            else
                color = PALETTE["action_health_text"]
            end

            Draw.setColor(COLORS.black)
            for x = -1, 1 do
                for y = -1, 1 do
                    love.graphics.print(party:getHealth().."/"..party:getStat("health"), x_text + x, y_pos + y)
                end
            end
            Draw.setColor(color)
            love.graphics.print(party:getHealth().."/"..party:getStat("health"), x_text, y_pos)
        end
    end
    Draw.setColor(1,1,1,1)
    love.graphics.pop()
end

function DarkMenu:onKeyPressed(key)
    if self.state == "MAIN" then
		if self.box then
			if self.box.onKeyPressed then
				self.box:onKeyPressed(key)
			end
		end

		if (Input.isMenu(key) or Input.isCancel(key)) then
			Game.world:closeMenu()
			return
		end

		if not self.animation_done then return end

        local old_selected = self.selected_submenu
		local select_direction = 0
        if Input.is("left", key)  then select_direction = -1 end
        if Input.is("right", key) then select_direction = 1 end
		self.selected_submenu = self.selected_submenu + select_direction
        if self.selected_submenu < 1             then self.selected_submenu = #self.buttons end
        if self.selected_submenu > #self.buttons then self.selected_submenu = 1             end
		local button_disabled = false
		if (type(self.buttons[self.selected_submenu].disabled) == "function") then
			button_disabled = self.buttons[self.selected_submenu].disabled()
		else
			button_disabled = self.buttons[self.selected_submenu].disabled
		end
		while (self.buttons[self.selected_submenu] and button_disabled) do
			self.selected_submenu = self.selected_submenu + select_direction
			if self.selected_submenu < 1             then self.selected_submenu = #self.buttons end
			if self.selected_submenu > #self.buttons then self.selected_submenu = 1             end
			button_disabled = false
			if (type(self.buttons[self.selected_submenu].disabled) == "function") then
				button_disabled = self.buttons[self.selected_submenu].disabled()
			else
				button_disabled = self.buttons[self.selected_submenu].disabled
			end
		end
        if old_selected ~= self.selected_submenu then
            self.ui_move:stop()
            self.ui_move:play()
        end
        if Input.isConfirm(key) then
            self:onButtonSelect(self.selected_submenu)
        end
    else
		super.onKeyPressed(self, key)
    end
end

function DarkMenu:getButtonSpacing()
    if #self.buttons <= 4 then
        return 105
    else
        return 105 - (#self.buttons * #self.buttons)
    end
end

function DarkMenu:drawButton(index, x, y)
    local button = self.buttons[index]
    local sprite = button.sprite
    if index == self.selected_submenu then
        sprite = button.hovered_sprite
    end	
	local button_disabled = false
	if (type(button.disabled) == "function") then
		button_disabled = button.disabled()
	else
		button_disabled = button.disabled
	end
    if button_disabled then
        sprite = button.disabled_sprite
    end
    Draw.setColor(1, 1, 1)
    Draw.draw(sprite, x, y, 0, 2, 2)
    if index == self.selected_submenu and self.state == "MAIN" then
        Draw.setColor(Game:getSoulColor())
        Draw.draw(self.heart_sprite, x + 15, y + 25, 0, 2, 2, self.heart_sprite:getWidth() / 2, self.heart_sprite:getHeight() / 2)
    end
end

function DarkMenu:addButtons()
    -- ITEM
    self:addButton({
        ["state"]          = "ITEMMENU",
        ["sprite"]         = Assets.getTexture("ui/menu/btn/item"),
        ["hovered_sprite"] = Assets.getTexture("ui/menu/btn/item_h"),
        ["disabled_sprite"]= Assets.getTexture("ui/menu/btn/item"),
        ["desc_sprite"]    = Assets.getTexture("ui/menu/desc/item"),
        ["callback"]       = function()
            self.box = DarkItemMenu()
            self.box.layer = 1
            self:addChild(self.box)

            self.ui_select:stop()
            self.ui_select:play()
        end,
		["disabled"]       = false
    })

    -- EQUIP
    self:addButton({
        ["state"]          = "EQUIPMENU",
        ["sprite"]         = Assets.getTexture("ui/menu/btn/equip"),
        ["hovered_sprite"] = Assets.getTexture("ui/menu/btn/equip_h"),
        ["disabled_sprite"]= Assets.getTexture("ui/menu/btn/equip"),
        ["desc_sprite"]    = Assets.getTexture("ui/menu/desc/equip"),
        ["callback"]       = function()
            self.box = DarkEquipMenu()
            self.box.layer = 1
            self:addChild(self.box)

            self.ui_select:stop()
            self.ui_select:play()
        end,
		["disabled"]       = false
    })

    -- POWER
    self:addButton({
        ["state"]          = "POWERMENU",
        ["sprite"]         = Assets.getTexture("ui/menu/btn/power"),
        ["hovered_sprite"] = Assets.getTexture("ui/menu/btn/power_h"),
        ["disabled_sprite"]= Assets.getTexture("ui/menu/btn/power"),
        ["desc_sprite"]    = Assets.getTexture("ui/menu/desc/power"),
        ["callback"]       = function()
            self.box = DarkPowerMenu()
            self.box.layer = 1
            self:addChild(self.box)

            self.ui_select:stop()
            self.ui_select:play()
        end,
		["disabled"]       = false
    })
    
    -- TRAVEL
    self:addButton({
        ["state"]          = "TRAVEL",
        ["sprite"]         = Assets.getTexture("ui/menu/btn/sanctum"),
        ["hovered_sprite"] = Assets.getTexture("ui/menu/btn/sanctum_h"),
        ["disabled_sprite"]= Assets.getTexture("ui/menu/btn/sanctum_d"),
        ["desc_sprite"]    = Assets.getTexture("ui/menu/desc/sanctum"),
        ["callback"]       = function()
            Input.clear("confirm")
            Game.world:closeMenu()

            self.ui_select:stop()
            self.ui_select:play()

            Game.world:startCutscene("travel_button")
        end,
		["disabled"]       = function() 
			if Game.world.map.id == "sanctum_hell/hell_1" or 
			Game.world.map.id == "sanctum_hell/hell_unknown" or 
			Game.world.map.id == "secrets/frisk_room" or
            Game:getFlag("unlock_travel") ~= true or
			StringUtils.contains(Game.world.map.id, "final_sanctuary") then
				return true
			end
			return false
		end
    })

    -- CONFIG
    self:addButton({
        ["state"]          = "CONFIGMENU",
        ["sprite"]         = Assets.getTexture("ui/menu/btn/config"),
        ["hovered_sprite"] = Assets.getTexture("ui/menu/btn/config_h"),
        ["disabled_sprite"]= Assets.getTexture("ui/menu/btn/config"),
        ["desc_sprite"]    = Assets.getTexture("ui/menu/desc/config"),
        ["callback"]       = function()
            self.box = DarkConfigMenu()
            self.box.layer = -1
            self:addChild(self.box)

            self.ui_select:stop()
            self.ui_select:play()
        end,
		["disabled"]       = false
    })
end

return DarkMenu
