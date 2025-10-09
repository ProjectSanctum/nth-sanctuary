local Lib = {}
Lib.warned = {}

function Lib:init()

    if Mod.libs["morebattle"] then -- Prevents the library from running when 'morebattle' is also present
        error("MoreBattle is conflicting with MoreParty, remove it to advance.")
    end
    
    HookSystem.hook(ActionBoxDisplay, "draw", function(orig, self)
        if #Game.party <= 3 then orig(self) return end
        
        local x = self.parent.realWidth
        
        if Game.battle.current_selecting == self.actbox.index then
            Draw.setColor(self.actbox.battler.chara:getColor())
        else
            Draw.setColor(PALETTE["action_strip"], 1)
        end

        love.graphics.setLineWidth(2)
        love.graphics.line((Game.battle.current_selecting == self.actbox.index) and 0 or 2 , Game:getConfig("oldUIPositions") and 2 or 1, x + 1, Game:getConfig("oldUIPositions") and 2 or 1)

        love.graphics.setLineWidth(2)
        if Game.battle.current_selecting == self.actbox.index then
            love.graphics.line(1  , 2, 1,   36)
            love.graphics.line(x, 2, x, 36)
        end

        Draw.setColor(PALETTE["action_fill"])
        love.graphics.rectangle("fill", 2, Game:getConfig("oldUIPositions") and 3 or 2, x - 3, Game:getConfig("oldUIPositions") and 34 or 35)
        
        if not Kristal.getLibConfig("moreparty", "classic_mode") then
            Draw.setColor(Mod.libs["magical-glass"] and Kristal.getLibConfig("magical-glass", "light_world_dark_battle_color_override") and Game:isLight() and MG_PALETTE["player_health_bg"] or Mod.libs["better_battles"] and self.actbox.battler.chara.health_bg_color or PALETTE["action_health_bg"]) -- Compatibility with 'better_battles' and 'magical-glass' Libraries.
            love.graphics.rectangle("fill", 118, 22 - self.actbox.data_offset, 39, 9)
            local health = (self.actbox.battler.chara:getHealth() / self.actbox.battler.chara:getStat("health")) * 39

            if health > 0 then
                if Mod.libs["magical-glass"] and Kristal.getLibConfig("magical-glass", "light_world_dark_battle_color_override") and Game:isLight() then -- Compatibility with 'magical-glass' Library.
                    Draw.setColor(MG_PALETTE["player_health"])
                else
                    Draw.setColor(self.actbox.battler.chara:getColor())
                end
                love.graphics.rectangle("fill", 118, 22 - self.actbox.data_offset, Game:isLight() and math.min(math.ceil(health), 39) or math.ceil(health), 9)
            end
            
            if Mod.libs["better_battles"] and self.actbox.battler.shield then -- Compatibility with 'better_battles' Library.
                Draw.setColor({128/255, 128/255, 128/255})
                love.graphics.rectangle("fill", 118, 27 - self.actbox.data_offset, math.ceil((self.actbox.battler.shield / self.actbox.battler.chara:getMaxShield()) * 39), 4)
            end
            
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
            love.graphics.print(self.actbox.battler.chara:getHealth(), 113 - health_offset, 9 - self.actbox.data_offset)
            Draw.setColor(PALETTE["action_health_text"])
            love.graphics.print("/", 121, 9 - self.actbox.data_offset)
            Draw.setColor(color)
            local string_width = self.font:getWidth(tostring(self.actbox.battler.chara:getStat("health")))
            love.graphics.print(self.actbox.battler.chara:getStat("health"), 159 - string_width, 9 - self.actbox.data_offset)
            love.graphics.translate(-10, 0)
        else
            Draw.setColor(Mod.libs["magical-glass"] and Kristal.getLibConfig("magical-glass", "light_world_dark_battle_color_override") and Game:isLight() and MG_PALETTE["player_health_bg"] or Mod.libs["better_battles"] and self.actbox.battler.chara.health_bg_color or PALETTE["action_health_bg"]) -- Compatibility with 'better_battles' and 'magical-glass' Libraries.
            love.graphics.rectangle("fill", 128, 22 - self.actbox.data_offset, 76, 9)

            local health = (self.actbox.battler.chara:getHealth() / self.actbox.battler.chara:getStat("health")) * 76

            if health > 0 then
                if Mod.libs["magical-glass"] and Kristal.getLibConfig("magical-glass", "light_world_dark_battle_color_override") and Game:isLight() then -- Compatibility with 'magical-glass' Library.
                    Draw.setColor(MG_PALETTE["player_health"])
                else
                    Draw.setColor(self.actbox.battler.chara:getColor())
                end
                love.graphics.rectangle("fill", 128, 22 - self.actbox.data_offset, Game:isLight() and math.min(math.ceil(health), 76) or math.ceil(health), 9)
            end

            if Mod.libs["better_battles"] and self.actbox.battler.shield then -- Compatibility with 'better_battles' Library.
                Draw.setColor({128/255, 128/255, 128/255})
                love.graphics.rectangle("fill", 128, 27 - self.actbox.data_offset, math.ceil((self.actbox.battler.shield / self.actbox.battler.chara:getMaxShield()) * 76), 4)
            end
            
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
        end
      
        Object.draw(self)
    end)
    
    HookSystem.hook(ActionBox, "drawActionBox", function(orig, self)
        if #Game.party <= 3 then orig(self) return end
        
        local x = self.realWidth
        if Game.battle.current_selecting == self.index then
            Draw.setColor(self.battler.chara:getColor())
            love.graphics.setLineWidth(2)
            love.graphics.line(1  , 2, 1,   37)
            love.graphics.line(Game:getConfig("oldUIPositions") and Kristal.getLibConfig("moreparty", "classic_mode") and (x - 1) or x, 2, Game:getConfig("oldUIPositions") and Kristal.getLibConfig("moreparty", "classic_mode") and (x - 1) or x, 37)
            love.graphics.line(0  , 6, x, 6 )
        end
        Draw.setColor(1, 1, 1, 1)
    end)
    
    HookSystem.hook(ActionBox, "drawSelectionMatrix", function(orig, self)
        if #Game.party <= 3 then orig(self) return end

        local x = self.realWidth

        -- Draw the background of the selection matrix
        Draw.setColor(0, 0, 0, 1)
        love.graphics.rectangle("fill", 2, 2, x - 3, 35)

        if Game.battle.current_selecting == self.index then
            local r,g,b,a = self.battler.chara:getColor()

            for i = 0, 11 do
                local siner = self.selection_siner + (i * (10 * math.pi))

                love.graphics.setLineWidth(2)
                Draw.setColor(r, g, b, a * math.sin(siner / 60))
                if math.cos(siner / 60) < 0 then
                    love.graphics.line(1 - (math.sin(siner / 60) * 30) + 30, 0, 1 - (math.sin(siner / 60) * 30) + 30, 37)
                    love.graphics.line(x - 1 + (math.sin(siner / 60) * 30) - 30, 0, x - 1 + (math.sin(siner / 60) * 30) - 30, 37)
                end
            end

            Draw.setColor(1, 1, 1, 1)
        end
    end)
    
    HookSystem.hook(BattleUI, "drawActionStrip", function(orig, self)
        orig(self)
        
        if #Game.battle.party <= (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4) then return end
        
        -- Draw the top line of the action strip
        Draw.setColor(PALETTE["action_strip"])
        love.graphics.rectangle("fill", 0, Game:getConfig("oldUIPositions") and -35 or -37, 640, Game:getConfig("oldUIPositions") and 3 or 2)
        -- Draw the background of the action strip
        Draw.setColor(PALETTE["action_fill"])
        love.graphics.rectangle("fill", 0, Game:getConfig("oldUIPositions") and -32 or -35, 640, Game:getConfig("oldUIPositions") and 33 or 35)
    end)
    
    if not Mod.libs["ExpandedAttackLib"] then -- Compatibility with 'ExpandedAttackLib' Library.
        HookSystem.hook(AttackBox, "draw", function(orig, self)

            local target_color = {self.battler.chara:getAttackBarColor()}
            local box_color = {self.battler.chara:getAttackBoxColor()}

            if self.flash > 0 then
                box_color = TableUtils.lerp(box_color, {1, 1, 1, 1}, self.flash)
            end

            love.graphics.setLineWidth(2)
            love.graphics.setLineStyle("rough")

            local ch1_offset = Game:getConfig("oldUIPositions") and #Game.battle.party <= 4

            Draw.setColor(box_color)
            local height = #Game.battle.party > 3 and math.floor(104 / #Game.battle.party) or 36
            
            love.graphics.rectangle("line", 80, ch1_offset and 0 or 1, (15 * AttackBox.BOLTSPEED) + 3, height + (ch1_offset and 1 or 0))

            Draw.setColor(target_color)
            love.graphics.rectangle("line", 83, 1, 8, height)
            Draw.setColor(0, 0, 0)
            love.graphics.rectangle("fill", 84, 2, 6, height - 2)

            love.graphics.setLineWidth(1)

            Object.draw(self)
        end)
    end
      
    HookSystem.hook(BattleUI, "beginAttack", function(orig, self)

        if #Game.battle.party <= 3 then orig(self) return end

        local attack_order = Utils.pickMultiple(Game.battle.normal_attackers, #Game.battle.normal_attackers)

        for _,box in ipairs(self.attack_boxes) do
            box:remove()
            end
            self.attack_boxes = {}

            local last_offset = -1
            local offset = 0
            local height = math.floor(112 / #Game.battle.party)
            for i = 1, #attack_order do
            offset = offset + last_offset

            local battler = attack_order[i]
            local index = Game.battle:getPartyIndex(battler.chara.id)
            local attack_box = AttackBox(battler, 30 + offset, index, 0, 40 + (height * (index - 1)))
            attack_box.layer = -10 + (index * 0.01)
            self:addChild(attack_box)
            table.insert(self.attack_boxes, attack_box)

            if i < #attack_order and last_offset ~= 0 then
                last_offset = TableUtils.pick{{0, 10, 15}}
            else
                last_offset = TableUtils.pick{{10, 15}}
            end
        end
        self.attacking = true
    end)
    
    if not Mod.libs["ExpandedAttackLib"] then -- Compatibility with 'ExpandedAttackLib' Library.
        HookSystem.hook(AttackBox, "update", function(orig, self)
            if self.removing or Game.battle.cancel_attack then
                self.fade_rect.alpha = MathUtils.approach(self.fade_rect.alpha, 1, 0.08 * DTMULT)
            end

            if not self.attacked then
                self.bolt:move(-AttackBox.BOLTSPEED * DTMULT, 0)

                self.afterimage_timer = self.afterimage_timer + DTMULT/2
                while math.floor(self.afterimage_timer) > self.afterimage_count do
                    self.afterimage_count = self.afterimage_count + 1
                    local afterimg = AttackBar(self.bolt.x, 0, 6, #Game.battle.party > 3 and math.floor(112/#Game.battle.party) or 38)
                    afterimg.layer = 3
                    afterimg.alpha = 0.4
                    afterimg:fadeOutSpeedAndRemove()
                    self:addChild(afterimg)
                end
            end

            local pressed_confirm = false
            if Mod.libs["multiplayer"] then -- Compatibility with 'multiplayer' Library.
                for i = 2, math.min(Mod.libs["multiplayer"].max_players, #Game.battle.party) do
                    if Input.pressed("p".. i .."_confirm") then
                        pressed_confirm = true
                    end
                end
            end
        
            if not Game.battle.cancel_attack and (Input.pressed("confirm") or pressed_confirm) then
                self.flash = 1
            else
                self.flash = MathUtils.approach(self.flash, 0, DTMULT/5)
            end

            Object.update(self)
        end)
    end
    
    if not Mod.libs["ExpandedAttackLib"] then -- Compatibility with 'ExpandedAttackLib' Library.
        HookSystem.hook(AttackBox, "init", function(orig, self, battler, offset, index, x, y)
            orig(self, battler, offset, index, x, y)
            if #Game.battle.party <= 3 then return end
            
            self.bolt.height = math.floor(112 / #Game.battle.party)
            self.head_sprite:setOrigin(0.5, 0.75 + (2 * (#Game.battle.party - 4) * 0.075))
            self.press_sprite:setOrigin(0, (#Game.battle.party - 4) * 0.025)
            self.head_sprite:setScale(1 - ((#Game.battle.party - 4) * 0.125))
        end)
    end
   
    HookSystem.hook(BattleUI, "drawState", function(orig, self)
        if #Game.battle.party <= 3 then orig(self) return end
        
        if Game.battle.state == "ATTACKING" or self.attacking then
            local y = 40
            local h = math.floor((115 - (#Game.battle.party % 4)) / #Game.battle.party)
            
            local ch1_offset = Game:getConfig("oldUIPositions")
            
            for c = 1, (#Game.battle.party - 1) do
                love.graphics.setColor(PALETTE["battle_attack_lines"])
                y = y + h
                if not ch1_offset then
                    love.graphics.rectangle("fill", 79, y, 224, 2)
                else
                    local has_index = {}
                    for _,box in ipairs(self.attack_boxes) do
                        has_index[box.index] = true
                    end
                    love.graphics.rectangle("fill", has_index[c+1] and 77 or 2, y, has_index[c+1] and 226 or 301, 3)
                end
            end
        elseif Game.battle.state == "MENUSELECT" then
            local page = math.ceil(Game.battle.current_menu_y / 3) - 1
            local max_page = math.ceil(#Game.battle.menu_items / 6) - 1

            local x = 0
            local y = 0
            Draw.setColor(Game.battle.encounter:getSoulColor())
            Draw.draw(self.heart_sprite, 5 + ((Game.battle.current_menu_x - 1) * 230), 30 + ((Game.battle.current_menu_y - (page*3)) * 30))

            local font = Assets.getFont("main")
            love.graphics.setFont(font)

            local page_offset = page * 6
            for i = page_offset+1, math.min(page_offset+6, #Game.battle.menu_items) do
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
                    -- Head counter
                    local heads = 0
                    for index, party_id in ipairs(item.party) do
                        local chara = Game:getPartyMember(party_id)
                        if Game.battle:getPartyIndex(party_id) ~= Game.battle.current_selecting then
                            heads = heads + 1
                        end
                    end
                    for index, party_id in ipairs(item.party) do
                        local chara = Game:getPartyMember(party_id)
                        -- Draw head only if it isn't the currently selected character
                        if Game.battle:getPartyIndex(party_id) ~= Game.battle.current_selecting then
                            local ox, oy = chara:getHeadIconOffset()
                            local party = 0
                            if heads > 2 then
                                party = heads - 2
                            end
                            Draw.draw(Assets.getTexture(chara:getHeadIcons() .. "/head"), text_offset + 30 + (x * 230) + ox, 50 + (y * 30) + oy + (party ~= 0 and (3.6 + party * 2.3) or 0), 0, 1 / (1 + party * 0.35))
                            text_offset = text_offset + (30 / (1 + party * 0.5))
                        end
                    end
                end
                if item.icons then
                    if not able then
                        -- We're not able to select this, so make the heads gray.
                        Draw.setColor(COLORS.gray)
                    end

                    for _, icon in ipairs(item.icons) do
                        if type(icon) == "string" then
                            icon = {icon, false, 0, 0, nil}
                        end
                        if not icon[2] then
                            local texture = Assets.getTexture(icon[1])
                            Draw.draw(texture, text_offset + 30 + (x * 230) + (icon[3] or 0), 50 + (y * 30) + (icon[4] or 0))
                            text_offset = text_offset + (icon[5] or texture:getWidth())
                        end
                    end
                end

                if able then
                    Draw.setColor(item.color() or {1, 1, 1, 1})
                else
                    Draw.setColor(COLORS.gray)
                end
                love.graphics.print(item.name, text_offset + 30 + (x * 230), 50 + (y * 30))
                text_offset = text_offset + font:getWidth(item.name)

                if item.icons then
                    if able then
                        Draw.setColor(1, 1, 1)
                    end

                    for _, icon in ipairs(item.icons) do
                        if type(icon) == "string" then
                            icon = {icon, false, 0, 0, nil}
                        end
                        if icon[2] then
                            local texture = Assets.getTexture(icon[1])
                            Draw.draw(texture, text_offset + 30 + (x * 230) + (icon[3] or 0), 50 + (y * 30) + (icon[4] or 0))
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

            -- Print information about currently selected item
            local tp_offset = 0
            local current_item = Game.battle.menu_items[Game.battle:getItemIndex()]
            if current_item.description then
                Draw.setColor(COLORS.gray)
                love.graphics.print(current_item.description, 260 + 240, 50)
                Draw.setColor(1, 1, 1, 1)
                _, tp_offset = current_item.description:gsub('\n', '\n')
                tp_offset = tp_offset + 1
            end

            if current_item.tp and current_item.tp ~= 0 then
                Draw.setColor(PALETTE["tension_desc"])
                love.graphics.print(math.floor((current_item.tp / Game:getMaxTension()) * 100) .. "% "..Game:getConfig("tpName"), 260 + 240, 50 + (tp_offset * 32))
                Game:setTensionPreview(current_item.tp)
            else
                Game:setTensionPreview(0)
            end

            Draw.setColor(1, 1, 1, 1)
            if page < max_page then
                Draw.draw(self.arrow_sprite, 470, 120 + (math.sin(Kristal.getTime()*6) * 2))
            end
            if page > 0 then
                Draw.draw(self.arrow_sprite, 470, 70 - (math.sin(Kristal.getTime()*6) * 2), 0, 1, -1)
            end

        else
            orig(self)
        end
    end)
    
    HookSystem.hook(BattleUI, "init", function(orig, self)
        if #Game.battle.party <= (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4) then
            orig(self)
        else
            Object.init(self, 0, 480 + (Game:getConfig("oldUIPositions") and 36 or 37))

            self.layer = BATTLE_LAYERS["ui"]

            self.current_encounter_text = Game.battle.encounter.text

            self.encounter_text = Textbox(30, 53, SCREEN_WIDTH - 30, SCREEN_HEIGHT - 53, "main_mono", nil, true)
            self.encounter_text.text.line_offset = 0
            self.encounter_text:setText("")
            self.encounter_text.debug_rect = {-30, -12, SCREEN_WIDTH+1, 124}
            self:addChild(self.encounter_text)

            self.choice_box = Choicebox(56, 49, 529, 103, true)
            self.choice_box.active = false
            self.choice_box.visible = false
            self:addChild(self.choice_box)

            self.short_act_text_1 = DialogueText("", 30, 51, SCREEN_WIDTH - 30, SCREEN_HEIGHT - 53, {wrap = false, line_offset = 0})
            self.short_act_text_2 = DialogueText("", 30, 51 + 30, SCREEN_WIDTH - 30, SCREEN_HEIGHT - 53, {wrap = false, line_offset = 0})
            self.short_act_text_3 = DialogueText("", 30, 51 + 30 + 30, SCREEN_WIDTH - 30, SCREEN_HEIGHT - 53, {wrap = false, line_offset = 0})
            self:addChild(self.short_act_text_1)
            self:addChild(self.short_act_text_2)
            self:addChild(self.short_act_text_3)

            self.action_boxes = {}
            self.attack_boxes = {}

            self.attacking = false

            local size_offset = 0
            local box_gap = 0
            
            if #Game.battle.party == 3 then
                size_offset = 0
                box_gap = 0
            elseif #Game.battle.party == 2 then
                size_offset = 108
                box_gap = 1
                if Game:getConfig("oldUIPositions") then
                    size_offset = 106
                    box_gap = 7
                end
            elseif #Game.battle.party == 1 then
                size_offset = 213
                box_gap = 0
            end

            for index,battler in ipairs(Game.battle.party) do
                local action_box = ActionBox(size_offset+ (index - 1) * (213 + box_gap), 0, index, battler)
                self:addChild(action_box)
                table.insert(self.action_boxes, action_box)
                battler.chara:onActionBox(action_box, false)
            end

            self.parallax_x = 0
            self.parallax_y = 0

            self.animation_done = true
            self.animation_timer = 0
            self.animate_out = false

            self.animation_y = 0
            self.animation_y_lag = 0

            self.shown = false

            self.heart_sprite = Assets.getTexture("player/heart")
            self.arrow_sprite = Assets.getTexture("ui/page_arrow_down")

            self.sparestar = Assets.getTexture("ui/battle/sparestar")
            self.tiredmark = Assets.getTexture("ui/battle/tiredmark")
        end
        
        if #Game.battle.party <= 3 then return end
        
        local x = 0
        local realW = ((640 - 1) / (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4)) -- SCREEN_WIDTH
        
        local e = 0
        
        for k,v in ipairs(self.action_boxes) do
            if k > (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4) then
                v.x = x - e + (Kristal.getLibConfig("moreparty", "classic_mode") and ((6 - #Game.party) * (640 - 1)/6) or ((8 - #Game.party) * (640 - 1)/8))
                v.y = Game:getConfig("oldUIPositions") and 36 or 37
                v.realWidth = realW
                x = x + realW
            else
                v.x = x
                v.y = 0
                v.realWidth = realW
                x = x + realW
                e = x
            end
        end
        
        if #Game.battle.party > (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4) then
            for k,v in ipairs(self.action_boxes) do
                v.y = v.y - (Game:getConfig("oldUIPositions") and 36 or 37)
            end
        end
    end)
    
    HookSystem.hook(BattleUI, "update", function(orig, self)
        orig(self)
        
        if #Game.battle.party <= (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4) then return end
        
        for k,v in ipairs(self.action_boxes) do
            if k == Game.battle.current_selecting then
                v:setLayer(BATTLE_LAYERS["ui"] + 0.5)
            else
                v:setLayer(BATTLE_LAYERS["ui"])
            end
        end

    end)
    
    HookSystem.hook(BattleUI, "getTransitionBounds", function(orig, self)
        if #Game.battle.party <= (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4) then return orig(self) end
        
        return 480 + (Game:getConfig("oldUIPositions") and 36 or 37), 325
    end)
    
    HookSystem.hook(Encounter, "getPartyPosition", function(orig, self, index)
        if #Game.battle.party <= 3 then return orig(self, index) end
        
        local x, y = 0, 0
        local column = 0
        local reset = 0
        local middle = 0
        local classic = (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4)
        if #Game.battle.party > classic then
            if index <= classic then
                column = 80
            else
                reset = classic
                middle = (classic * 2 - #Game.battle.party) * ((Kristal.getLibConfig("moreparty", "classic_mode") and 40 or 35))
            end
        end
        x = 80 + column
        y = (((not Kristal.getLibConfig("moreparty", "classic_mode") and #Game.battle.party <= 4) and 120 or 50) / classic) + ((SCREEN_HEIGHT * 0.5) / classic) * (index - 1 - reset) + middle

        local battler = Game.battle.party[index]
        local ox, oy = battler.chara:getBattleOffset()
        x = x + (battler.actor:getWidth()/2 + ox) * 2
        y = y + (battler.actor:getHeight()  + oy) * 2
        return x, y
    end)
    
    HookSystem.hook(Battle, "createPartyBattlers", function(orig, self)
        
        for i = 1, #Game.party do
            local party_member = Game.party[i]

            if Game.world.player and Game.world.player.visible and Game.world.player.actor.id == party_member:getActor().id then
                -- Create the player battler
                local player_x, player_y = Game.world.player:getScreenPos()
                local player_battler = PartyBattler(party_member, player_x, player_y)
                player_battler:setAnimation("battle/transition")
                self:addChild(player_battler)
                table.insert(self.party,player_battler)
                table.insert(self.party_beginning_positions, {player_x, player_y})
                self.party_world_characters[party_member.id] = Game.world.player

                Game.world.player.visible = false
            else
                local found = false
                for _,follower in ipairs(Game.world.followers) do
                    if follower.visible and follower.actor.id == party_member:getActor().id then
                        local chara_x, chara_y = follower:getScreenPos()
                        local chara_battler = PartyBattler(party_member, chara_x, chara_y)
                        chara_battler:setAnimation("battle/transition")
                        self:addChild(chara_battler)
                        table.insert(self.party, chara_battler)
                        table.insert(self.party_beginning_positions, {chara_x, chara_y})
                        self.party_world_characters[party_member.id] = follower

                        follower.visible = false

                        found = true
                        break
                    end
                end
                if not found then
                    local chara_battler = PartyBattler(party_member, SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
                    chara_battler:setAnimation("battle/transition")
                    self:addChild(chara_battler)
                    table.insert(self.party, chara_battler)
                    table.insert(self.party_beginning_positions, {chara_battler.x, chara_battler.y})
                end
            end
        end
    end)
    
    HookSystem.hook(Battle, "shortActText", function(orig, self, text)
        local advances = 3 -- initial override so we can run it
        local function displayShortActText()
            advances = advances + 1
            if advances >= 3 then
                self.battle_ui:clearEncounterText()
                advances = 0
            
                local t1, t2, t3 = table.remove(text,1), table.remove(text,1), table.remove(text,1)
                local text_exhausted = not (t1 and t2 and t3) or #text == 0
                local advance_to_next = not text_exhausted and displayShortActText
                self.battle_ui.short_act_text_1:setText(t1 or "", advance_to_next)
                self.battle_ui.short_act_text_2:setText(t2 or "", advance_to_next)
                self.battle_ui.short_act_text_3:setText(t3 or "", advance_to_next)

                if text_exhausted then
                    self:setState("SHORTACTTEXT")
                end
            end
        end
        
        displayShortActText()
    end)
    
    HookSystem.hook(DarkEquipMenu, "init", function(orig, self)
        orig(self)
        if #Game.party <= 3 then return end
      
        if not Kristal.getLibConfig("moreparty", "classic_mode") and #Game.party >= 4 or not Kristal.getLibConfig("moreparty", "scroller") and #Game.party == 4 then
            self.party:setPosition(-15, 48)
        end
        
        if not Kristal.getLibConfig("moreparty", "scroller") and #Game.party > 4 then
            self.party:setScale(0.5)
        end
    end)
   
    HookSystem.hook(DarkPowerMenu, "init", function(orig, self)
        orig(self)
        if #Game.party <= 3 then return end
      
        if not Kristal.getLibConfig("moreparty", "classic_mode") and #Game.party >= 4 or not Kristal.getLibConfig("moreparty", "scroller") and #Game.party == 4 then
            self.party:setPosition(-15, 48)
        end
        
        if not Kristal.getLibConfig("moreparty", "scroller") and #Game.party > 4 then
            self.party:setScale(0.5)
        end
    end)
    
    HookSystem.hook(DarkMenuPartySelect, "init", function(orig, self, x, y)
        orig(self, x, y)
        
        if not Kristal.getLibConfig("moreparty", "scroller") then return end
        self.shown = Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4
        self.arrow = Assets.getTexture("ui/flat_arrow_left")
    end)
   
    HookSystem.hook(DarkMenuPartySelect, "draw", function(orig, self)
        if #Game.party <= 4 and not Kristal.getLibConfig("moreparty", "scroller") or #Game.party <= 3 then orig(self) return end 
        
        if not Kristal.getLibConfig("moreparty", "scroller") then
            for i,party in ipairs(Game.party) do
                if self.selected_party ~= i then
                    Draw.setColor(1, 1, 1, 0.4)
                else
                    Draw.setColor(1, 1, 1, 1)
                end
                local ox, oy = party:getMenuIconOffset()
                Draw.draw(Assets.getTexture(party:getMenuIcon()), (i-1)*50 + (ox*2), oy*2, 0, 2, 2)
            end
            if self.focused then
                local frames = Assets.getFrames("player/heart_harrows")
                Draw.setColor(Game:getSoulColor())
                Draw.draw(frames[(math.floor(self.heart_siner/20)-1)%#frames+1], ((self.selected_party-1)*50 - 5), -36, 0 , 2)
            end
        else
            local offset = math.sin(Kristal.getTime()*2.5)
            
            if self.selected_party >= #Game.party then
                self.shown = #Game.party
            elseif self.selected_party > self.shown then
                self.shown = self.shown + 1
            end
            if self.selected_party <= 1 then
                self.shown = (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4)
            elseif self.selected_party + (Kristal.getLibConfig("moreparty", "classic_mode") and 2 or 3) < self.shown then
                self.shown = self.shown - 1
            end
            
            if self.shown ~= (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4) then
                Draw.draw(self.arrow, -8 - offset, 14)
            end
            if self.shown ~= #Game.party then
                Draw.draw(self.arrow, (Kristal.getLibConfig("moreparty", "classic_mode") and 158 or 208) + offset, 14, 0, -1, 1)
            end

            Draw.scissor(0, -18, Kristal.getLibConfig("moreparty", "classic_mode") and 150 or 200, 64)

            for i,party in ipairs(Game.party) do
                if self.selected_party ~= i then
                    Draw.setColor(1, 1, 1, 0.4)
                else
                    Draw.setColor(1, 1, 1, 1)
                end
                local ox, oy = party:getMenuIconOffset()
                Draw.draw(Assets.getTexture(party:getMenuIcon()), (i-1)*50 + (ox*2) - (self.shown - (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4)) * 50, oy*2, 0, 2, 2)
            end
            if self.focused then
                local frames = Assets.getFrames("player/heart_harrows")
                Draw.setColor(Game:getSoulColor())
                Draw.draw(frames[(math.floor(self.heart_siner/20)-1)%#frames+1], (self.selected_party-1)*50 + 10  - (self.shown - (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4)) * 50, -18)
            end
        end
        Object.draw(self)
    end)
    
    HookSystem.hook(ActionBox, "draw", function(orig, self)
        if #Game.battle.party <= 3 then orig(self) return end 
    
        self:drawSelectionMatrix()
        self:drawActionBox()

        Object.draw(self)

        if not self.name_sprite then
            local font = Assets.getFont("name")
            love.graphics.setFont(font)
            Draw.setColor(1, 1, 1, 1)

            local name = self.battler.chara:getName():upper()
            local spacing = 5 - name:len()

            local off = 0
            for i = 1, name:len() do
                local letter = name:sub(i, i)
                love.graphics.print(letter, self.box.x + (Kristal.getLibConfig("moreparty", "classic_mode") and 51 or 41) + off, self.box.y + 14 - self.data_offset - 1)
                off = off + font:getWidth(letter) + spacing
            end
        end
    end)
   
    HookSystem.hook(OverworldActionBox, "draw", function(orig, self)
        if #Game.party <= 3 then orig(self) return end
        
        local double_row = false
        if #Game.party > (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4) then
            double_row = true
        end
      
        local parent = self.parent
      
        local x = 0
        -- local w = ((108 * .5) + 212) * 2
        local realW = ((640 - 1) / (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4)) -- SCREEN_WIDTH
        local e = 0
        
        for k,v in ipairs(parent.action_boxes) do
            if k > (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4) then
                v.x = x - e + (Kristal.getLibConfig("moreparty", "classic_mode") and ((6 - #Game.party) * (640 - 1)/6) or ((8 - #Game.party) * (640 - 1)/8))
                v.y = 44
                v.realWidth = realW
                x = x + realW
            else
                v.x = x
                v.y = 0
                v.realWidth = realW
                x = x + realW
                e = x
            end
        end
        
        if double_row then
            for k,v in ipairs(parent.action_boxes) do
                v.y = v.y - 44
            end
        end
      
        local string_width = self.font:getWidth(tostring(self.chara:getStat("health")))
        
        -- Draw the line at the top
        if self.selected then
            love.graphics.setColor(self.chara:getColor())
        else
            love.graphics.setColor(PALETTE["action_strip"])
        end

        love.graphics.setLineWidth(2)
        love.graphics.line(0, double_row and 20 or 1, realW, double_row and 20 or 1)
        
        if Game:getConfig("oldUIPositions") then
            love.graphics.line(0, double_row and 21 or 2, 2, double_row and 21 or 2)
            love.graphics.line(realW - 2, double_row and 21 or 2, realW, double_row and 21 or 2)
        end
        
        local y_bar = double_row and 36 or 24
        local y_hp = double_row and 24 or 11
      
        if not Kristal.getLibConfig("moreparty", "classic_mode") then
            -- Draw health
            love.graphics.setColor(PALETTE["action_health_bg"])
            love.graphics.rectangle("fill", 118, y_bar, 39, 9)

            local health = (self.chara.health / self.chara:getStat("health")) * 39

            if health > 0 then
                love.graphics.setColor(self.chara:getColor())
                love.graphics.rectangle("fill", 118, y_bar, math.ceil(health), 9)
            end

            local color = PALETTE["action_health_text"]
            if health <= 0 then
                color = PALETTE["action_health_text_down"]
            elseif (self.chara:getHealth() <= (self.chara:getStat("health") / 4)) then
                color = PALETTE["action_health_text_low"]
            else
                color = PALETTE["action_health_text"]
            end

            local health_offset = 0
            health_offset = (#tostring(self.chara.health) - 1) * 8

            love.graphics.setColor(color)
            love.graphics.setFont(self.font)
            love.graphics.print(self.chara.health, 113 - health_offset, y_hp)
            love.graphics.setColor(PALETTE["action_health_text"])
            love.graphics.print("/", 121, y_hp)
            love.graphics.setColor(color)
            love.graphics.print(self.chara:getStat("health"), 159 - string_width, y_hp)
        else
            -- Draw health
            Draw.setColor(PALETTE["action_health_bg"])
            love.graphics.rectangle("fill", 128, y_bar, 76, 9)

            local health = (self.chara:getHealth() / self.chara:getStat("health")) * 76

            if health > 0 then
                Draw.setColor(self.chara:getColor())
                love.graphics.rectangle("fill", 128, y_bar, math.ceil(health), 9)
            end

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
            love.graphics.print(self.chara:getHealth(), 152 - health_offset, y_hp)
            Draw.setColor(PALETTE["action_health_text"])
            love.graphics.print("/", 161, y_hp)
            local string_width = self.font:getWidth(tostring(self.chara:getStat("health")))
            Draw.setColor(color)
            love.graphics.print(self.chara:getStat("health"), 205 - string_width, y_hp)
        end

        -- Draw name text if there's no sprite
        if not self.name_sprite then
            local font = Assets.getFont("name")
            love.graphics.setFont(font)
            love.graphics.setColor(1, 1, 1, 1)

            local name = self.chara:getName():upper()
            local spacing = 5 - name:len()

            local off = 0
            for i = 1, name:len() do
                local letter = name:sub(i, i)
                love.graphics.print(letter, (Kristal.getLibConfig("moreparty", "classic_mode") and 51 or 41) + off, 16 - 1)
                off = off + font:getWidth(letter) + spacing
            end
        end

        local reaction_x = -1

        if self.x == 0 then -- lazy check for leftmost party member
            reaction_x = 3
        end

        love.graphics.setFont(self.main_font)
        love.graphics.setColor(1, 1, 1, self.reaction_alpha / 6)
        if double_row then
            love.graphics.print(self.reaction_text, reaction_x, 46, 0, 0.5, 0.5)
            love.graphics.translate(Kristal.getLibConfig("moreparty", "classic_mode") and 0 or -10, 12)
        else
            love.graphics.print(self.reaction_text, reaction_x, 43, 0, 0.5, 0.5)
            love.graphics.translate(Kristal.getLibConfig("moreparty", "classic_mode") and 0 or -10, 0)
        end

        Object.draw(self)
    end)
    
   HookSystem.hook(HealthBar, "draw", function(orig, self)
        
        if #Game.party <= (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4) then orig(self) return end
          
        -- Draw the black background
        Draw.setColor(PALETTE["world_fill"])
        love.graphics.rectangle("fill", 0, -23, 640, 124)
          
        Object.draw(self)
   end)
   
    HookSystem.hook(HealthBar, "init", function(orig, self)
        orig(self)
        
        if #Game.party <= (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4) then return end
        self.animation_y = -126
    end)
    
    HookSystem.hook(HealthBar, "update", function(orig, self)
        if #Game.party <= (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4) then orig(self) return end
        
        self.animation_timer = self.animation_timer + DTMULT
        self.auto_hide_timer = self.auto_hide_timer + DTMULT
        if Game.world.menu or Game.world:inBattle() then
            -- If we're in an overworld battle, or the menu is open, we don't want the health bar to disappear
            self.auto_hide_timer = 0
        end

        if self.auto_hide_timer > 60 then -- After two seconds outside of a battle, we hide the health bar
            self:transitionOut()
        end

        local max_time = self.animate_out and 3 or 8

        if self.animation_timer > max_time + 1 then
            self.animation_done = true
            self.animation_timer = max_time + 1
            if self.animate_out then
                Game.world.healthbar = nil
                self:remove()
                return
            end
        end

        if not self.animate_out then
            if self.animation_y < 0 then
                if self.animation_y > -103 then
                    self.animation_y = self.animation_y + math.ceil(-self.animation_y / 2.5) * DTMULT
                else
                    self.animation_y = self.animation_y + 30 * DTMULT
                end
            else
                self.animation_y = 0
            end
        else
            if self.animation_y > -126 then
                if self.animation_y > 0 then
                    self.animation_y = self.animation_y - math.floor(self.animation_y / 2.5) * DTMULT
                else
                    self.animation_y = self.animation_y - 30 * DTMULT
                end
            else
                self.animation_y = -126
            end
        end

        self.y = 480 - (self.animation_y + 63)

        Object.update(self)
    end)
   
   HookSystem.hook(Shop, "draw", function(orig, self)
   
        if #Game.party <= 4 then orig(self) return end
        
        
        if not (self.state == "BUYMENU") then
            return orig(self)
        end
        self:drawBackground()

        Object.draw(self)

        love.graphics.setFont(self.font)
        if self.state == "BUYMENU" then

            while self.current_selecting - self.item_offset > 5 do
                self.item_offset = self.item_offset + 1
            end

            while self.current_selecting - self.item_offset < 1 do
                self.item_offset = self.item_offset - 1
            end

            if self.item_offset + 5 > #self.items + 1 then
                if #self.items + 1 > 5 then
                    self.item_offset = self.item_offset - 1
                end
            end

            if #self.items + 1 == 5 then
                self.item_offset = 0
            end

            -- Item type (item, key, weapon, armor)
            for i = 1 + self.item_offset, self.item_offset + math.max(4, math.min(5, #self.items)) do
                if i == math.max(4, #self.items) + 1 then break end
                local y = 220 + ((i - self.item_offset) * 40)
                local item = self.items[i]
                if not item then
                    -- If the item is null, add some empty space
                    Draw.setColor(COLORS.dkgray)
                    love.graphics.print("--------", 60, y)
                elseif item.options["stock"] and (item.options["stock"] <= 0) then
                    -- If we've depleted the stock, show a "sold out" message
                    Draw.setColor(COLORS.gray)
                    love.graphics.print("--SOLD OUT--", 60, y)
                else
                    Draw.setColor(item.options["color"])
                    love.graphics.print(item.options["name"], 60, y)
                    if not self.hide_price then
                        Draw.setColor(COLORS.white)
                        love.graphics.print(string.format(self.currency_text, item.options["price"] or 0), 60 + 240, y)
                    end
                end
            end
            Draw.setColor(COLORS.white)
            if self.item_offset == math.max(4, #self.items) - 4 then
                love.graphics.print("Exit", 60, 220 + (math.max(4, #self.items) + 1 - self.item_offset) * 40)
            end
            Draw.setColor(Game:getSoulColor())
            if not self.buy_confirming then
                Draw.draw(self.heart_sprite, 30, 230 + ((self.current_selecting - self.item_offset) * 40))
            else
                Draw.draw(self.heart_sprite, 30 + 420, 230 + 80 + 10 + (self.current_selecting_choice * 30))
                Draw.setColor(COLORS.white)
                local lines = StringUtils.split(string.format(self.buy_confirmation_text, string.format(self.currency_text, self.items[self.current_selecting].options["price"] or 0)), "\n")
                for i = 1, #lines do
                    love.graphics.print(lines[i], 60 + 400, 420 - 160 + ((i - 1) * 30))
                end
                love.graphics.print("Yes", 60 + 420, 420 - 80)
                love.graphics.print("No",  60 + 420, 420 - 80 + 30)
            end
            Draw.setColor(COLORS.white)

            if (self.current_selecting <= #self.items) then
                local current_item = self.items[self.current_selecting]
                local box_left, box_top = self.info_box:getBorder()

                local left = self.info_box.x - self.info_box.width - (box_left / 2) * 1.5
                local top = self.info_box.y - self.info_box.height - (box_top / 2) * 1.5
                local width = self.info_box.width + box_left * 1.5
                local height = self.info_box.height + box_top * 1.5

                Draw.pushScissor()
                Draw.scissor(left, top, width, height)

                Draw.setColor(COLORS.white)
                love.graphics.print(current_item.options["description"], left + 32, top + 20)

                if current_item.item.type == "armor" or current_item.item.type == "weapon" then
                    for i = 1, #Game.party do
                        -- Turn the index into a 2 wide grid (0-indexed)
                        local transformed_x = (i - 1) % 2
                        local transformed_y = math.floor((i - 1) / 2) - (#Game.party <= 6 and 0 or 0.9)

                        -- Transform the grid into coordinates
                        local offset_x = transformed_x * 100
                        local offset_y = transformed_y * 26

                        local party_member = Game.party[i]
                        local can_equip = party_member:canEquip(current_item.item)
                        local head_path = ""

                        love.graphics.setFont(self.plain_font)
                        Draw.setColor(COLORS.white)

                        if can_equip then
                            head_path = Assets.getTexture(party_member:getHeadIcons() .. "/head")
                            if current_item.item.type == "armor" then
                                Draw.draw(self.stat_icons["defense_1"], offset_x + 470, offset_y + 132 + top)
                                Draw.draw(self.stat_icons["defense_2"], offset_x + 470, offset_y + 145 + top)

                                for j = 1, 2 do
                                    self:drawBonuses(party_member, party_member:getArmor(j), current_item.options["bonuses"], "defense", offset_x + 470 + 21, offset_y + 132 + ((j - 1) * 13) + top)
                                end

                            elseif current_item.item.type == "weapon" then
                                Draw.draw(self.stat_icons["attack"], offset_x + 470, offset_y + 134 + top)
                                Draw.draw(self.stat_icons["magic" ], offset_x + 470, offset_y + 146 + top)
                                self:drawBonuses(party_member, party_member:getWeapon(), current_item.options["bonuses"], "attack", offset_x + 470 + 21, offset_y + 132 + top)
                                self:drawBonuses(party_member, party_member:getWeapon(), current_item.options["bonuses"], "magic",  offset_x + 470 + 21, offset_y + 145 + top)
                            end
                        else
                            head_path = Assets.getTexture(party_member:getHeadIcons() .. "/head_error")
                        end

                        Draw.draw(head_path, offset_x + 426, offset_y + 134 + top)
                    end
                end

                Draw.popScissor()

                Draw.setColor(COLORS.white)

                if not self.hide_storage_text then
                    love.graphics.setFont(self.plain_font)

                    local current_storage = Game.inventory:getDefaultStorage(current_item.item)
                    local space = Game.inventory:getFreeSpace(current_storage)

                    if space <= 0 then
                        love.graphics.print("NO SPACE", 521, 430)
                    else
                        love.graphics.print("Space:" .. space, 521, 430)
                    end
                end
            end
        end

        if self.state == "MAINMENU" or
           self.state == "BUYMENU"  or
           self.state == "SELLMENU" or
           self.state == "SELLING"  or
           self.state == "TALKMENU" then
            Draw.setColor(COLORS.white)
            love.graphics.setFont(self.font)
            love.graphics.print(string.format(self.currency_text, self:getMoney()), 440, 420)
        end

        Draw.setColor(0, 0, 0, self.fade_alpha)
        love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
   end)
   
   if not Mod.libs["better_battles"] then -- Compatibility with 'better_battles' Library.
        HookSystem.hook(ActionButton, "select", function(orig, self)
            if Game.battle.encounter:onActionSelect(self.battler, self) then return end
            if Kristal.callEvent("onActionSelect", self.battler, self) then return end
            if self.type == "act" and not Kristal.getLibConfig("moreparty", "classic_mode") and #Game.battle.party > 3 and self.battler.chara:hasSpells() then
                Game.battle:clearMenuItems()
                Game.battle:addMenuItem({
                    ["name"] = Kristal.getLibConfig("moreparty", "custom_act_name")[1],
                    ["description"] = Kristal.getLibConfig("moreparty", "custom_act_name")[2],
                    ["color"] = {1,1,1,1},
                    ["callback"] = function() Game.battle:setState("ENEMYSELECT", "ACT") end
                })
                local magic_color = {1,1,1,1}
                if self.battler then
                    local has_tired = false
                    for _,enemy in ipairs(Game.battle:getActiveEnemies()) do
                        if enemy.tired then
                            has_tired = true
                            break
                        end
                    end
                    if has_tired then
                        local has_pacify = false
                        for _,spell in ipairs(self.battler.chara:getSpells()) do
                            if spell and spell:hasTag("spare_tired") then
                                if spell:isUsable(self.battler.chara) and spell:getTPCost(self.battler.chara) <= Game:getTension() then
                                    has_pacify = true
                                    break
                                end
                            end
                        end
                        if has_pacify then
                            magic_color = {0, 178/255, 1, 1}
                        end
                    end
                end
                Game.battle:addMenuItem({
                    ["name"] = Kristal.getLibConfig("moreparty", "custom_magic_name")[1],
                    ["description"] = Kristal.getLibConfig("moreparty", "custom_magic_name")[2],
                    ["color"] = magic_color,
                    ["callback"] = function() 
                        Game.battle:clearMenuItems()

                        -- First, register X-Actions as menu items.

                        if Game.battle.encounter.default_xactions and self.battler.chara:hasXAct() then
                            local spell = {
                                ["name"] = Game.battle.enemies[1]:getXAction(self.battler),
                                ["target"] = "xact",
                                ["id"] = 0,
                                ["default"] = true,
                                ["party"] = {},
                                ["tp"] = 0
                            }

                            Game.battle:addMenuItem({
                                ["name"] = self.battler.chara:getXActName() or "X-Action",
                                ["tp"] = 0,
                                ["color"] = {self.battler.chara:getXActColor()},
                                ["data"] = spell,
                                ["callback"] = function(menu_item)
                                    Game.battle.selected_xaction = spell
                                    Game.battle:setState("XACTENEMYSELECT", "SPELL")
                                end
                            })
                        end

                        for id, action in ipairs(Game.battle.xactions) do
                            if action.party == self.battler.chara.id then
                                local spell = {
                                    ["name"] = action.name,
                                    ["target"] = "xact",
                                    ["id"] = id,
                                    ["default"] = false,
                                    ["party"] = {},
                                    ["tp"] = action.tp or 0
                                }

                                Game.battle:addMenuItem({
                                    ["name"] = action.name,
                                    ["tp"] = action.tp or 0,
                                    ["description"] = action.description,
                                    ["color"] = action.color or {1, 1, 1, 1},
                                    ["data"] = spell,
                                    ["callback"] = function(menu_item)
                                        Game.battle.selected_xaction = spell
                                        Game.battle:setState("XACTENEMYSELECT", "SPELL")
                                    end
                                })
                            end
                        end

                        -- Now, register SPELLs as menu items.
                        for _,spell in ipairs(self.battler.chara:getSpells()) do
                            local color = spell.color or {1, 1, 1, 1}
                            if spell:hasTag("spare_tired") then
                                local has_tired = false
                                for _,enemy in ipairs(Game.battle:getActiveEnemies()) do
                                    if enemy.tired then
                                        has_tired = true
                                        break
                                    end
                                end
                                if has_tired then
                                    color = {0, 178/255, 1, 1}
                                end
                            end
                            Game.battle:addMenuItem({
                                ["name"] = spell:getName(),
                                ["tp"] = spell:getTPCost(self.battler.chara),
                                ["unusable"] = not spell:isUsable(self.battler.chara),
                                ["description"] = spell:getBattleDescription(),
                                ["party"] = spell.party,
                                ["color"] = color,
                                ["data"] = spell,
                                ["callback"] = function(menu_item)
                                    Game.battle.selected_spell = menu_item

                                    if not spell.target or spell.target == "none" then
                                        Game.battle:pushAction("SPELL", nil, menu_item)
                                    elseif spell.target == "ally" then
                                        Game.battle:setState("PARTYSELECT", "SPELL")
                                    elseif spell.target == "enemy" then
                                        Game.battle:setState("ENEMYSELECT", "SPELL")
                                    elseif spell.target == "party" then
                                        Game.battle:pushAction("SPELL", Game.battle.party, menu_item)
                                    elseif spell.target == "enemies" then
                                        Game.battle:pushAction("SPELL", Game.battle:getActiveEnemies(), menu_item)
                                    end
                                end
                            })
                        end

                        Game.battle:setState("MENUSELECT", "SPELL")
                    end
                })
                Game.battle:setState("MENUSELECT", "ACT+")
            else
                orig(self)
            end
        end)
        
        HookSystem.hook(ActionButton, "hasSpecial", function(orig, self)
            if self.type == "act" and not Kristal.getLibConfig("moreparty", "classic_mode") and #Game.battle.party > 3 and self.battler.chara:hasSpells() then
                if self.battler then
                    local has_tired = false
                    for _,enemy in ipairs(Game.battle:getActiveEnemies()) do
                        if enemy.tired then
                            has_tired = true
                            break
                        end
                    end
                    if has_tired then
                        local has_pacify = false
                        for _,spell in ipairs(self.battler.chara:getSpells()) do
                            if spell and spell:hasTag("spare_tired") then
                                if spell:isUsable(self.battler.chara) and spell:getTPCost(self.battler.chara) <= Game:getTension() then
                                    has_pacify = true
                                    break
                                end
                            end
                        end
                        return has_pacify
                    end
                end
            else
                return orig(self)
            end
        end)
        
        HookSystem.hook(ActionBox, "createButtons", function(orig, self)
            for _,button in ipairs(self.buttons or {}) do
                button:remove()
            end

            self.buttons = {}

            local btn_types = {"fight", "act", "magic", "item", "spare", "defend"}

            if not self.battler.chara:hasAct() then TableUtils.removeValue(btn_types, "act") end
            if not self.battler.chara:hasSpells() or self.battler.chara:hasAct() and not Kristal.getLibConfig("moreparty", "classic_mode") and #Game.battle.party > 3 and self.battler.chara:hasSpells() then TableUtils.removeValue(btn_types, "magic") end

            for lib_id,_ in Kristal.iterLibraries() do
                btn_types = Kristal.libCall(lib_id, "getActionButtons", self.battler, btn_types) or btn_types
            end
            btn_types = Kristal.modCall("getActionButtons", self.battler, btn_types) or btn_types

            local start_x = (213 / 2) - ((#btn_types-1) * 35 / 2) - 1

            if (#btn_types <= 5) and Game:getConfig("oldUIPositions") then
                start_x = start_x - 5.5
            end

            for i,btn in ipairs(btn_types) do
                if type(btn) == "string" then
                    local button = ActionButton(btn, self.battler, math.floor(start_x + ((i - 1) * 35)) + 0.5, 21)
                    button.actbox = self
                    table.insert(self.buttons, button)
                    self:addChild(button)
                elseif type(btn) ~= "boolean" then -- nothing if a boolean value, used to create an empty space
                    btn:setPosition(math.floor(start_x + ((i - 1) * 35)) + 0.5, 21)
                    btn.battler = self.battler
                    btn.actbox = self
                    table.insert(self.buttons, btn)
                    self:addChild(btn)
                end
            end

            self.selected_button = MathUtils.clamp(self.selected_button, 1, #self.buttons)
        end)
    end
    
    if Mod.libs["magical-glass"] then -- Compatibility with 'magical-glass' Library.
    
        HookSystem.hook(LightBattle, "shortActText", function(orig, self, text)
            local advances = 3 -- initial override so we can run it
            local function displayShortActText()
                advances = advances + 1
                if advances >= 3 then
                    self.battle_ui:clearEncounterText()
                    advances = 0
                
                    local t1, t2, t3 = table.remove(text,1), table.remove(text,1), table.remove(text,1)
                    local text_exhausted = not (t1 and t2 and t3) or #text == 0
                    local advance_to_next = not text_exhausted and displayShortActText
                    self.battle_ui.short_act_text_1:setText(t1 and "[voice:battle][shake:"..MagicalGlassLib.light_battle_shake_text.."]" .. t1 or "", advance_to_next)
                    self.battle_ui.short_act_text_2:setText(t2 and "[voice:battle][shake:"..MagicalGlassLib.light_battle_shake_text.."]" .. t2 or "", advance_to_next)
                    self.battle_ui.short_act_text_3:setText(t3 and "[voice:battle][shake:"..MagicalGlassLib.light_battle_shake_text.."]" .. t3 or "", advance_to_next)

                    if text_exhausted then
                        self:setState("SHORTACTTEXT")
                    end
                end
            end
            
            displayShortActText()
        end)
        
        HookSystem.hook(LightBattle, "createPartyBattlers", function(orig, self)
            for i = 1, #Game.party do
                local battler = LightPartyBattler(Game.party[i])
                table.insert(self.party, battler)
            end
        end)
        
        HookSystem.hook(LightStatusDisplay, "drawStatusStrip", function(orig, self)
            if not Game.battle.multi_mode or #Game.battle.party <= 3 then
                orig(self)
            else
                for index = 1, #Game.battle.party do
                    local x, y = 0, 0
                    local z = Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4
                    if #Game.battle.party == 4 and not Kristal.getLibConfig("moreparty", "classic_mode") then
                        x, y = 83 + (3 - #Game.battle.party) * 80 + (index - 1) * 80 * 2, 10
                    else
                        if index <= z then
                            x, y = 83 + (3 - math.min(#Game.battle.party,z)) * 80 + (index - 1) * 80 * 2, 8
                        else
                            x, y = 83 + (3 - math.min(#Game.battle.party - z,z)) * 80 + (index - 1 - z) * 80 * 2, 28
                        end
                    end
                    local function target_text_area()
                        love.graphics.rectangle("fill", x + 1, y - 9, 25, 4)
                    end
                    love.graphics.stencil(target_text_area, "replace", 1, true)
                end
                for index,battler in ipairs(Game.battle.party) do
                    if #Game.battle.party == 4 and not Kristal.getLibConfig("moreparty", "classic_mode") then
                        local x, y = 83 + (3 - #Game.battle.party) * 80 + (index - 1) * 80 * 2, 10
                        
                        local name = battler.chara:getShortName()
                        local level = Game:isLight() and battler.chara:getLightLV() or battler.chara:getLevel()
                        
                        local current = battler.chara:getHealth()
                        local max = battler.chara:getStat("health")
                        local karma = battler.karma
                        
                        love.graphics.setFont(Assets.getFont("namelv", 16))
                        love.graphics.setColor(MG_PALETTE["player_text"])
                        love.graphics.print(name, x, y - 2)
                        love.graphics.setFont(Assets.getFont("namelv", 8))
                        love.graphics.print((Game:isLight() and Kristal.getLibConfig("magical-glass", "light_level_name_short") or Kristal.getLibConfig("magical-glass", "light_level_name_dark")).." " .. level, x, y + 13)
                        
                        love.graphics.draw(Assets.getTexture("ui/lightbattle/hp"), x + 49, y + 14, 0, 0.5)
                        
                        local small = false
                        for _,party in ipairs(Game.battle.party) do
                            if party.chara:getStat("health") >= 100 then
                                small = true
                            end
                        end
                        
                        local karma_mode = Game.battle.encounter.karma_mode
                        if karma_mode then
                            love.graphics.draw(Assets.getTexture("ui/lightbattle/kr"), x + 64 + (small and 12 or 26) * 1.2 + 1, y + 14, 0, 0.5)
                        end
                        
                        love.graphics.setColor(Game:isLight() and (karma_mode and MG_PALETTE["player_karma_health_bg"] or MG_PALETTE["player_health_bg"]) or MG_PALETTE["player_health_bg_dark"])
                        love.graphics.rectangle("fill", x + 62, y + (small and 3 or 0), (small and 12 or 26) * 1.2 + 1, small and 14 or 21)
                        if current > 0 then
                            love.graphics.setColor(Game:isLight() and MG_PALETTE["player_karma_health"] or MG_PALETTE["player_karma_health_dark"])
                            love.graphics.rectangle("fill", x + 62, y + (small and 3 or 0), math.ceil((MathUtils.clamp(current, 0, max) / max) * (small and 12 or 26)) * 1.2 + 1, small and 14 or 21)
                            love.graphics.setColor(Game:isLight() and MG_PALETTE["player_health"] or {battler.chara:getColor()})
                            love.graphics.rectangle("fill", x + 62, y + (small and 3 or 0), math.ceil((MathUtils.clamp(current - karma, 0, max) / max) * (small and 12 or 26)) * 1.2 + 1 - (karma_mode and 1 or 0), small and 14 or 21)
                        end
                        
                        love.graphics.setFont(Assets.getFont("namelv", 16))
                        if max < 10 and max >= 0 then
                            max = "0" .. tostring(max)
                        end

                        if current < 10 and current >= 0 then
                            current = "0" .. tostring(current)
                        end
                        
                        local color = MG_PALETTE["player_text"]
                        if battler.is_down then
                            color = MG_PALETTE["player_down_text"]
                        elseif battler.sleeping then
                            color = MG_PALETTE["player_sleeping_text"]
                        elseif Game.battle:getActionBy(battler) and Game.battle:getActionBy(battler).action == "DEFEND" then
                            color = MG_PALETTE["player_defending_text"]
                        elseif Game.battle:getActionBy(battler) and TableUtils.contains({"ACTIONSELECT", "MENUSELECT", "ENEMYSELECT", "PARTYSELECT"}, Game.battle:getState()) and Game.battle:getActionBy(battler).action ~= "AUTOATTACK" then
                            color = MG_PALETTE["player_action_text"]
                        elseif karma > 0 then
                            color = MG_PALETTE["player_karma_text"]
                        end
                        love.graphics.setColor(color)
                        Draw.printAlign(current .. "/" .. max, x + 156, y + 3 - (karma_mode and 3 or 0), "right")
                        
                        if Game.battle.current_selecting == index or DEBUG_RENDER and Input.alt() then
                            love.graphics.setColor(battler.chara:getColor())
                            love.graphics.setLineWidth(2)
                            love.graphics.rectangle("line", x - 2, y - 7, 158, 35)
                        end
                        
                        if battler:isTargeted() and Game:getConfig("targetSystem") and Game.battle.state == "ENEMYDIALOGUE" then
                            love.graphics.setColor(1, 1, 1, 1)
                            love.graphics.setLineWidth(2)
                            love.graphics.setStencilTest("equal", 0)
                            if math.floor(Kristal.getTime() * 3) % 2 == 0 then
                                love.graphics.rectangle("line", x - 2, y - 7, 158, 35)
                            else
                                love.graphics.rectangle("line", x - 1, y - 6, 156, 33)
                            end
                            love.graphics.setStencilTest()
                            love.graphics.draw(Assets.getTexture("ui/lightbattle/chartarget"), x + 2, y - 9)
                        end
                    else
                        local x, y = 0, 0
                        local z = Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4
                        if index <= z then
                            x, y = 83 + (3 - math.min(#Game.battle.party,z)) * 80 + (index - 1) * 80 * 2, 8
                        else
                            x, y = 83 + (3 - math.min(#Game.battle.party - z,z)) * 80 + (index - 1 - z) * 80 * 2, 28
                        end
                        
                        local name = battler.chara:getShortName()
                        local level = Game:isLight() and battler.chara:getLightLV() or battler.chara:getLevel()
                        
                        local current = battler.chara:getHealth()
                        local max = battler.chara:getStat("health")
                        local karma = battler.karma
                        
                        love.graphics.setFont(Assets.getFont("namelv", 16))
                        love.graphics.setColor(MG_PALETTE["player_text"])
                        love.graphics.print(name, x, y - 7)
                        love.graphics.setFont(Assets.getFont("namelv", 8))
                        love.graphics.print((Game:isLight() and Kristal.getLibConfig("magical-glass", "light_level_name_short") or Kristal.getLibConfig("magical-glass", "light_level_name_dark")).." " .. level, x, y + 5)
                        
                        love.graphics.draw(Assets.getTexture("ui/lightbattle/hp"), x + 49, y + 6, 0, 0.5)
                        
                        local small = false
                        for _,party in ipairs(Game.battle.party) do
                            if party.chara:getStat("health") >= 100 then
                                small = true
                            end
                        end
                        
                        local karma_mode = Game.battle.encounter.karma_mode
                        if karma_mode then
                            love.graphics.draw(Assets.getTexture("ui/lightbattle/kr"), x + 64 + (small and 12 or 26) * 1.2 + 1, y + 6, 0, 0.5)
                        end
                        
                        love.graphics.setColor(Game:isLight() and (karma_mode and MG_PALETTE["player_karma_health_bg"] or MG_PALETTE["player_health_bg"]) or MG_PALETTE["player_health_bg_dark"])
                        love.graphics.rectangle("fill", x + 62, y - 2, (small and 12 or 26) * 1.2 + 1, 10)
                        if current > 0 then
                            love.graphics.setColor(Game:isLight() and MG_PALETTE["player_karma_health"] or MG_PALETTE["player_karma_health_dark"])
                            love.graphics.rectangle("fill", x + 62, y - 2, math.ceil((MathUtils.clamp(current, 0, max) / max) * (small and 12 or 26)) * 1.2 + 1, 10)
                            love.graphics.setColor(Game:isLight() and MG_PALETTE["player_health"] or {battler.chara:getColor()})
                            love.graphics.rectangle("fill", x + 62, y - 2, math.ceil((MathUtils.clamp(current - karma, 0, max) / max) * (small and 12 or 26)) * 1.2 + 1 - (karma_mode and 1 or 0), 10)
                        end
                        
                        love.graphics.setFont(Assets.getFont("namelv", 16))
                        if max < 10 and max >= 0 then
                            max = "0" .. tostring(max)
                        end

                        if current < 10 and current >= 0 then
                            current = "0" .. tostring(current)
                        end
                        
                        local color = MG_PALETTE["player_text"]
                        if battler.is_down then
                            color = MG_PALETTE["player_down_text"]
                        elseif battler.sleeping then
                            color = MG_PALETTE["player_sleeping_text"]
                        elseif Game.battle:getActionBy(battler) and Game.battle:getActionBy(battler).action == "DEFEND" then
                            color = MG_PALETTE["player_defending_text"]
                        elseif Game.battle:getActionBy(battler) and TableUtils.contains({"ACTIONSELECT", "MENUSELECT", "ENEMYSELECT", "PARTYSELECT"}, Game.battle:getState()) and Game.battle:getActionBy(battler).action ~= "AUTOATTACK" then
                            color = MG_PALETTE["player_action_text"]
                        elseif karma > 0 then
                            color = MG_PALETTE["player_karma_text"]
                        end
                        love.graphics.setColor(color)
                        Draw.printAlign(current .. "/" .. max, x + 156, y - 4 - (karma_mode and 3 or 0), "right")
                        
                        if Game.battle.current_selecting == index or DEBUG_RENDER and Input.alt() then
                            love.graphics.setColor(battler.chara:getColor())
                            love.graphics.setLineWidth(2)
                            love.graphics.rectangle("line", x - 2, y - 7, 158, 20)
                        end
                        
                        if battler:isTargeted() and Game:getConfig("targetSystem") and Game.battle.state == "ENEMYDIALOGUE" then
                            love.graphics.setColor(1, 1, 1, 1)
                            love.graphics.setLineWidth(2)
                            love.graphics.setStencilTest("equal", 0)
                            if math.floor(Kristal.getTime() * 3) % 2 == 0 then
                                love.graphics.rectangle("line", x - 2, y - 7, 158, 20)
                            else
                                love.graphics.rectangle("line", x - 1, y - 6, 156, 18)
                            end
                            love.graphics.setStencilTest()
                            love.graphics.draw(Assets.getTexture("ui/lightbattle/chartarget"), x + 2, y - 9)
                        end
                    end
                end
            end
        end)
        
        HookSystem.hook(LightHealthBar, "init", function(orig, self)
             orig(self)
             if #Game.party <= 3 then return end
             
             if Kristal.getLibConfig("moreparty", "classic_mode") then
                self.box.x = 103
                self.box.width = 434
             else
                self.box.x = 26
                self.box.width = 588
             end
        end)
        
        HookSystem.hook(LightHealthBar, "draw", function(orig, self)
            if #Game.party <= 3 then orig(self) return end
            
            Object.draw(self)
            
            for index,party in ipairs(Game.party) do
                if #Game.party == 4 and not Kristal.getLibConfig("moreparty", "classic_mode") then
                    local x, y = 93 + (3 - #Game.party) * 77 + (index - 1) * 77 * 2, 10
                    
                    local name = party:getShortName()
                    
                    local current = party:getHealth()
                    local max = party:getStat("health")
                    
                    love.graphics.setFont(Assets.getFont("namelv", 16))
                    love.graphics.setColor(PALETTE["world_text"])
                    love.graphics.print(name, x, y + 3)
                    
                    local small = false
                    for _,target in ipairs(Game.party) do
                        if target:getStat("health") >= 100 then
                            small = true
                        end
                    end
                    
                    love.graphics.setColor(MG_PALETTE["player_health_bg"])
                    love.graphics.rectangle("fill", x + 62, y + (small and 3 or 0), (small and 12 or 26) * 1.2 + 1, small and 14 or 21)
                    if current > 0 then
                        love.graphics.setColor(MG_PALETTE["player_health"])
                        love.graphics.rectangle("fill", x + 62, y + (small and 3 or 0), math.ceil((MathUtils.clamp(current, 0, max) / max) * (small and 12 or 26)) * 1.2 + 1, small and 14 or 21)
                    end
                    
                    love.graphics.setFont(Assets.getFont("namelv", 16))
                    if max < 10 and max >= 0 then
                        max = "0" .. tostring(max)
                    end

                    if current < 10 and current >= 0 then
                        current = "0" .. tostring(current)
                    end
                    
                    love.graphics.setColor(PALETTE["world_text"])
                    Draw.printAlign(current .. "/" .. max, x + 148, y + 3, "right")
                else
                    local x, y = 0, 0
                    local z = Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4
                    if index <= z then
                        x, y = 93 + (3 - math.min(#Game.party,z)) * 77 + (index - 1) * 77 * 2, 8
                    else
                        x, y = 93 + (3 - math.min(#Game.party - z,z)) * 77 + (index - 1 - z) * 77 * 2, 28
                    end
                    
                    local name = party:getShortName()
                    
                    local current = party:getHealth()
                    local max = party:getStat("health")
                    
                    love.graphics.setFont(Assets.getFont("namelv", 16))
                    love.graphics.setColor(PALETTE["world_text"])
                    love.graphics.print(name, x, y - 4)
                    
                    local small = false
                    for _,target in ipairs(Game.party) do
                        if target:getStat("health") >= 100 then
                            small = true
                        end
                    end
                    
                    love.graphics.setColor(MG_PALETTE["player_health_bg"])
                    love.graphics.rectangle("fill", x + 62, y - 2, (small and 12 or 26) * 1.2 + 1, 10)
                    if current > 0 then
                        love.graphics.setColor(MG_PALETTE["player_health"])
                        love.graphics.rectangle("fill", x + 62, y - 2, math.ceil((MathUtils.clamp(current, 0, max) / max) * (small and 12 or 26)) * 1.2 + 1, 10)
                    end
                    
                    love.graphics.setFont(Assets.getFont("namelv", 16))
                    if max < 10 and max >= 0 then
                        max = "0" .. tostring(max)
                    end

                    if current < 10 and current >= 0 then
                        current = "0" .. tostring(current)
                    end
                    
                    love.graphics.setColor(PALETTE["world_text"])
                    Draw.printAlign(current .. "/" .. max, x + 148, y - 4, "right")
                end
            end
        end)
    end
    
    HookSystem.hook(ActionBox, "createButtons", function(orig, self)
        orig(self)
        if #Game.battle.party > 3 and Kristal.getLibConfig("moreparty", "classic_mode") then
            for _,button in ipairs(self.buttons) do
                button.x = button.x + 1
            end
        end
    end)
    
    HookSystem.hook(ActionBox, "update", function(orig, self)
        orig(self)
        
        if #Game.battle.party <= 3 or Kristal.getLibConfig("moreparty", "classic_mode") then return end

        local x = 16 + (5 - #self.buttons) * 16
        
        for _,button in ipairs(self.buttons) do
            button.visible = (Game.battle.current_selecting == self.index)
            button.x = x
            
            x = x + 32
        end
    end)
    
    print("Loaded MoreParty Library")
end

function Lib:postUpdate()
    local max_members = (Kristal.getLibConfig("moreparty", "classic_mode") and 6 or 8)
    if #Game.party > max_members and not Lib.warned["too_many_pm"] then
        Kristal.Console:warn("too many party members than MoreParty can support. (MAX: ".. max_members ..")")
        if Kristal.getLibConfig("moreparty", "classic_mode") then
            Kristal.Console:warn("try disabling the library's 'classic_mode' to allow up to 8.")
        end
        Lib.warned["too_many_pm"] = true
    end
end

return Lib