local Lib = {}

function dictSize(t)
	local count = 0
	for _ in pairs(t) do
		count = count + 1
	end
	return count
end

function Lib:init()
    print("Loaded Status CORE " .. self.info.version .. "!")
	
	HookSystem.hook(TableUtils, "dump", function(orig, o)
		if type(o) == "table" and isClass(o) and o.__tostring then
			return tostring(o)
		end
		return orig(o)
	end)
    
    HookSystem.hook(PartyBattler, "init", function(orig, self, ...)
        orig(self, ...)
		
		self.statuses = {}	-- status_id: {statcon: status, turn_count: number of turns}
    end)
    HookSystem.hook(PartyBattler, "inflictStatus", function(orig, self, status, turns, ...)
		if self.statuses[status] then
			self.statuses[status].turn_count = math.max(
				self.statuses[status].turn_count,
				(
					turns or self.statuses[status].statcon.default_turns
				)
			)
			self.statuses[status].statcon:onMerge(self, {...})
		elseif ((Kristal.getLibConfig("status_core", "max_effects") and Kristal.getLibConfig("status_core", "max_effects") > dictSize(self.statuses)) or (not Kristal.getLibConfig("status_core", "max_effects"))) then
			local effect = Lib:createStatus(status, ...)
			self.statuses[status] = {statcon = effect, turn_count = (turns or effect.default_turns)}
			self.statuses[status].statcon:onStatus(self)
		end
    end)
    HookSystem.hook(PartyBattler, "cureStatus", function(orig, self, status, reason)
		if self.statuses[status] then
			self.statuses[status].statcon:onCure(self, reason)
			self.statuses[status] = nil
		end
    end)
    HookSystem.hook(PartyBattler, "update", function(orig, self)
		orig(self)
		for id, status in pairs(self.statuses) do
			status.statcon:onUpdate(self)
		end
    end)
    HookSystem.hook(PartyBattler, "hurt", function(orig, self, amount, exact, color, options)
		for id, status in pairs(self.statuses) do
			amount = status.statcon:onHurt(self, amount) or amount
		end
		if amount > 0 then
			orig(self, amount, exact, color, options)
		end
		for _,battler in ipairs(Game.battle.party) do
			if battler ~= self then
				for id, status in pairs(battler.statuses) do
					status.statcon:onOtherHurt(battler, self, amount)
				end
			end
		end
    end)
    HookSystem.hook(PartyBattler, "hasStatus", function(orig, self, status)
		return (self.statuses[status] ~= nil)
    end)
    
    HookSystem.hook(EnemyBattler, "init", function(orig, self, ...)
        orig(self, ...)
		
		self.statuses = {}	-- status_id: {statcon: status, turn_count: number of turns}
    end)
    HookSystem.hook(EnemyBattler, "inflictStatus", function(orig, self, status, turns, ...)
		if self.statuses[status] then
			self.statuses[status].turn_count = math.max(
				self.statuses[status].turn_count,
				(
					turns or self.statuses[status].statcon.default_turns
				)
			)
			self.statuses[status].statcon:onMerge(self, {...})
		elseif ((Kristal.getLibConfig("status_core", "max_effects") and Kristal.getLibConfig("status_core", "max_effects") > dictSize(self.statuses)) or (not Kristal.getLibConfig("status_core", "max_effects"))) then
			local effect = Lib:createEnemyStatus(status, ...)
			self.statuses[status] = {statcon = effect, turn_count = (turns or effect.default_turns)}
			self.statuses[status].statcon:onStatus(self)
		end
    end)
    HookSystem.hook(EnemyBattler, "cureStatus", function(orig, self, status, reason)
		if self.statuses[status] then
			self.statuses[status].statcon:onCure(self, reason)
			self.statuses[status] = nil
		end
    end)
    HookSystem.hook(EnemyBattler, "update", function(orig, self)
		orig(self)
		for id, status in pairs(self.statuses) do
			status.statcon:onUpdate(self)
		end
    end)
    HookSystem.hook(EnemyBattler, "draw", function(orig, self)
		local i = 0
		love.graphics.setFont(Assets.getFont("smallnumbers"))
		for k, status in pairs(self.statuses) do
			if not status.statcon.hidden then
				Draw.setColor(1, 1, 1, 1)
				love.graphics.draw(Assets.getTexture(status.statcon.icon), (self.width/2) + 4 + 10, (self.height/2) - 24 + (i * 24), 0, 0.5, 0.5)
				
				local width = Assets.getFont("smallnumbers"):getWidth(status.turn_count)
				Draw.setColor(0, 0, 0, 1)
				love.graphics.print(status.turn_count, (self.width/2) + 19 - width + 10, (self.height/2) - 16 + (i * 24), 0, 0.5, 0.5)
				love.graphics.print(status.turn_count, (self.width/2) + 19 - width + 10, (self.height/2) - 15 + (i * 24), 0, 0.5, 0.5)
				love.graphics.print(status.turn_count, (self.width/2) + 19 - width + 10, (self.height/2) - 17 + (i * 24), 0, 0.5, 0.5)
				love.graphics.print(status.turn_count, (self.width/2) + 20 - width + 10, (self.height/2) - 15 + (i * 24), 0, 0.5, 0.5)
				love.graphics.print(status.turn_count, (self.width/2) + 21 - width + 10, (self.height/2) - 16 + (i * 24), 0, 0.5, 0.5)
				love.graphics.print(status.turn_count, (self.width/2) + 21 - width + 10, (self.height/2) - 15 + (i * 24), 0, 0.5, 0.5)
				love.graphics.print(status.turn_count, (self.width/2) + 21 - width + 10, (self.height/2) - 17 + (i * 24), 0, 0.5, 0.5)
				love.graphics.print(status.turn_count, (self.width/2) + 20 - width + 10, (self.height/2) - 17 + (i * 24), 0, 0.5, 0.5)
				Draw.setColor(1, 1, 1, 1)
				love.graphics.print(status.turn_count, (self.width/2) + 20 - width + 10, (self.height/2) - 16 + (i * 24), 0, 0.5, 0.5)
				
				if status.statcon.amplifier and status.statcon.amplifier >= 1 then
					Draw.setColor(0, 0, 0, 1)
					love.graphics.print(status.statcon.amplifier, (self.width/2) + 1 + 10, (self.height/2) - 28 + (i * 24), 0, 0.5, 0.5)
					love.graphics.print(status.statcon.amplifier, (self.width/2) + 1 + 10, (self.height/2) - 27 + (i * 24), 0, 0.5, 0.5)
					love.graphics.print(status.statcon.amplifier, (self.width/2) + 1 + 10, (self.height/2) - 29 + (i * 24), 0, 0.5, 0.5)
					love.graphics.print(status.statcon.amplifier, (self.width/2) + 2 + 10, (self.height/2) - 27 + (i * 24), 0, 0.5, 0.5)
					love.graphics.print(status.statcon.amplifier, (self.width/2) + 3 + 10, (self.height/2) - 28 + (i * 24), 0, 0.5, 0.5)
					love.graphics.print(status.statcon.amplifier, (self.width/2) + 3 + 10, (self.height/2) - 27 + (i * 24), 0, 0.5, 0.5)
					love.graphics.print(status.statcon.amplifier, (self.width/2) + 3 + 10, (self.height/2) - 29 + (i * 24), 0, 0.5, 0.5)
					love.graphics.print(status.statcon.amplifier, (self.width/2) + 2 + 10, (self.height/2) - 29 + (i * 24), 0, 0.5, 0.5)
					Draw.setColor(1, 1, 1, 1)
					love.graphics.print(status.statcon.amplifier, (self.width/2) + 2 + 10, (self.height/2) - 28 + (i * 24), 0, 0.5, 0.5)
				end
			
				i = i + 1
			end
		end
        orig(self)
    end)
    HookSystem.hook(EnemyBattler, "hurt", function(orig, self, amount, party, on_defeat, color, show_status, attacked)
		local changed = false
		for id, status in pairs(self.statuses) do
			local old_amount = amount
			amount = status.statcon:onHurt(self, amount) or amount
			if amount ~= old_amount then
				changed = true
			end
		end
		Kristal.Console:log(party.chara.id .. ": " .. (changed and "True" or "False"))
		if (amount > 0) or not changed then
			orig(self, amount, party, on_defeat, color, show_status, attacked)
		end
		for _,battler in ipairs(Game.battle.enemies) do
			if battler ~= self then
				for id, status in pairs(battler.statuses) do
					status.statcon:onOtherHurt(battler, self, amount, party)
				end
			end
		end
    end)
    HookSystem.hook(EnemyBattler, "hasStatus", function(orig, self, status)
		return (self.statuses[status] ~= nil)
    end)
    
    HookSystem.hook(Battle, "nextTurn", function(orig, self)
        orig(self)
		
		for _, battler in ipairs(Game.battle.party) do
			for id, status in pairs(battler.statuses) do
				status.turn_count = status.turn_count - 1
				
				if status.turn_count == 0 then
					battler.statuses[id].statcon:onCure(battler, "TIMEOUT")
					battler.statuses[id] = nil
				else
					battler.statuses[id].statcon:onTurnStart(battler)
				end
			end
		end
		
		for _, battler in ipairs(Game.battle.enemies) do
			for id, status in pairs(battler.statuses) do
				status.turn_count = status.turn_count - 1
				
				if status.turn_count == 0 then
					battler.statuses[id].statcon:onCure(battler, "TIMEOUT")
					battler.statuses[id] = nil
				else
					battler.statuses[id].statcon:onTurnStart(battler)
				end
			end
		end
    end)
    HookSystem.hook(Battle, "onStateChange", function(orig, self, old, new)
        orig(self, old, new)
		
		if new == "ACTIONSDONE" then
			for _, battler in ipairs(Game.battle.party) do
				for id, status in pairs(battler.statuses) do
					status.statcon:onActionsEnd(battler)
				end
			end
			for _, battler in ipairs(Game.battle.enemies) do
				for id, status in pairs(battler.statuses) do
					status.statcon:onActionsEnd(battler)
				end
			end
		elseif new == "DEFENDINGBEGIN" then
			for _, battler in ipairs(Game.battle.party) do
				for id, status in pairs(battler.statuses) do
					status.statcon:onDefenseStart(battler)
				end
			end
			for _, battler in ipairs(Game.battle.enemies) do
				for id, status in pairs(battler.statuses) do
					status.statcon:onDefenseStart(battler)
				end
			end
		end
    end)
    HookSystem.hook(Battle, "init", function(orig, self, ...)
        orig(self, ...)
		if Kristal.getLibConfig("status_core", "status_menu") then
			local sv = StatusView()
			sv:setLayer(BATTLE_LAYERS["top"])
			self:addChild(sv)
		end
    end)

	HookSystem.hook(PartyMember, "getStat", function (orig, self, name, default, light)
        local value = orig(self, name, default, light)
        if Game.battle then
            local battler = Game.battle:getPartyBattler(self.id)
            for id, status in pairs(battler.statuses) do
                ---@cast status {statcon:StatusCondition}
                value = status.statcon:applyStatModifier(name, value)
            end
        end
        return value
    end)

    HookSystem.hook(ActionBoxDisplay, "draw", function(orig, self)
		local i = 0
		love.graphics.setFont(Assets.getFont("smallnumbers"))
		for k, status in pairs(self.actbox.battler.statuses) do
			if not status.statcon.hidden then
				Draw.setColor(1, 1, 1, 1)
				if Kristal.getLibConfig("status_core", "match_color") then
					Draw.setColor(self.actbox.battler.chara.color)
				end
				love.graphics.draw(Assets.getTexture(status.statcon.icon), (i * 24) + 4, -24)
				
				local width = Assets.getFont("smallnumbers"):getWidth(status.turn_count)
				Draw.setColor(0, 0, 0, 1)
				love.graphics.print(status.turn_count, (i * 24) + 25 - width, -12)
				love.graphics.print(status.turn_count, (i * 24) + 25 - width, -11)
				love.graphics.print(status.turn_count, (i * 24) + 25 - width, -13)
				love.graphics.print(status.turn_count, (i * 24) + 26 - width, -11)
				love.graphics.print(status.turn_count, (i * 24) + 27 - width, -12)
				love.graphics.print(status.turn_count, (i * 24) + 27 - width, -11)
				love.graphics.print(status.turn_count, (i * 24) + 27 - width, -13)
				love.graphics.print(status.turn_count, (i * 24) + 26 - width, -13)
				Draw.setColor(1, 1, 1, 1)
				love.graphics.print(status.turn_count, (i * 24) + 26 - width, -12)
				
				if status.statcon.amplifier and status.statcon.amplifier >= 1 then
					Draw.setColor(0, 0, 0, 1)
					love.graphics.print(status.statcon.amplifier, (i * 24) + 3, -28)
					love.graphics.print(status.statcon.amplifier, (i * 24) + 3, -27)
					love.graphics.print(status.statcon.amplifier, (i * 24) + 3, -29)
					love.graphics.print(status.statcon.amplifier, (i * 24) + 4, -27)
					love.graphics.print(status.statcon.amplifier, (i * 24) + 5, -28)
					love.graphics.print(status.statcon.amplifier, (i * 24) + 5, -27)
					love.graphics.print(status.statcon.amplifier, (i * 24) + 5, -29)
					love.graphics.print(status.statcon.amplifier, (i * 24) + 4, -29)
					Draw.setColor(1, 1, 1, 1)
					love.graphics.print(status.statcon.amplifier, (i * 24) + 4, -28)
				end
			
				i = i + 1
			end
		end
        orig(self)
    end)
	if Mod.libs["magical-glass"] and Kristal.getLibConfig("status_core", "magical-glass") then
		print("[Status CORE] Magical Glass detected and changes allowed.")
		if LightPartyBattler then
			HookSystem.hook(LightPartyBattler, "init", function(orig, self, ...)
				orig(self, ...)
				
				self.statuses = {}	-- status_id: {statcon: status, turn_count: number of turns}
			end)
			HookSystem.hook(LightPartyBattler, "inflictStatus", function(orig, self, status, turns, ...)
				if self.statuses[status] then
					self.statuses[status].turn_count = math.max(
						self.statuses[status].turn_count,
						(
							turns or self.statuses[status].statcon.default_turns
						)
					)
				else
					local effect = Lib:createStatus(status, ...)
					self.statuses[status] = {statcon = effect, turn_count = (turns or effect.default_turns)}
					self.statuses[status].statcon:onStatus(self)
				end
			end)
			HookSystem.hook(LightPartyBattler, "cureStatus", function(orig, self, status)
				if self.statuses[status] then
					self.statuses[status].statcon:onCure(self)
					self.statuses[status] = nil
				end
			end)
			HookSystem.hook(LightPartyBattler, "update", function(orig, self)
				orig(self)
				for id, status in pairs(self.statuses) do
					status.statcon:onUpdate(self)
				end
			end)
			HookSystem.hook(LightPartyBattler, "hurt", function(orig, self, amount, exact, color, options)
				for id, status in pairs(self.statuses) do
					amount = status.statcon:onHurt(self, amount) or amount
				end
				if amount > 0 then
					orig(self, amount, exact, color, options)
				end
				for _,battler in ipairs(Game.battle.party) do
					if battler ~= self then
						for id, status in pairs(battler.statuses) do
							status.statcon:onOtherHurt(battler, self, amount)
						end
					end
				end
			end)
			HookSystem.hook(LightPartyBattler, "hasStatus", function(orig, self, status)
				return (self.statuses[status] ~= nil)
			end)
		end
		
		if LightBattle then
			HookSystem.hook(LightBattle, "nextTurn", function(orig, self)
				orig(self)
				
				for _, battler in ipairs(Game.battle.party) do
					for id, status in pairs(battler.statuses) do
						status.turn_count = status.turn_count - 1
						
						if status.turn_count == 0 then
							battler.statuses[id].statcon:onCure(battler)
							battler.statuses[id] = nil
						else
							battler.statuses[id].statcon:onTurnStart(battler)
						end
					end
				end
			end)
			HookSystem.hook(LightBattle, "onStateChange", function(orig, self, old, new)
				orig(self, old, new)
				
				if new == "ACTIONSDONE" then
					for _, battler in ipairs(Game.battle.party) do
						for id, status in pairs(battler.statuses) do
							status.statcon:onActionsEnd(battler)
						end
					end
				elseif new == "DEFENDINGBEGIN" then
					for _, battler in ipairs(Game.battle.party) do
						for id, status in pairs(battler.statuses) do
							status.statcon:onDefenseStart(battler)
						end
					end
				end
			end)
			HookSystem.hook(LightBattle, "init", function(orig, self, ...)
				orig(self, ...)
				if Kristal.getLibConfig("status_core", "status_menu") then
					local sv = StatusView()
					sv:setLayer(BATTLE_LAYERS["top"])
					self:addChild(sv)
				end
			end)
			HookSystem.hook(LightBattle, "draw", function(orig, self)
				orig(self)
				
				for i, battler in ipairs(self.party) do
					Draw.setColor(1, 1, 1, (1 - self.fader.alpha))
					local head_icon = Assets.getTexture(battler.chara.head_icons + "/head")
					love.graphics.draw(head_icon, 600, (i * 28) - 20)
					
					x = 566
					love.graphics.setFont(Assets.getFont("smallnumbers"))
					for k, status in pairs(battler.statuses) do
						if not status.statcon.hidden then
							Draw.setColor(1, 1, 1, (1 - self.fader.alpha))
							if Kristal.getLibConfig("status_core", "match_color") then
								Draw.setColor(battler.chara.color)
							end
							love.graphics.draw(Assets.getTexture(status.statcon.icon), x + 4, (i * 28) - 16)
							
							local width = Assets.getFont("smallnumbers"):getWidth(status.turn_count)
							Draw.setColor(0, 0, 0, (1 - self.fader.alpha))
							love.graphics.print(status.turn_count, x + 25 - width, (i * 28) - 4)
							love.graphics.print(status.turn_count, x + 25 - width, (i * 28) - 3)
							love.graphics.print(status.turn_count, x + 25 - width, (i * 28) - 5)
							love.graphics.print(status.turn_count, x + 26 - width, (i * 28) - 3)
							love.graphics.print(status.turn_count, x + 27 - width, (i * 28) - 4)
							love.graphics.print(status.turn_count, x + 27 - width, (i * 28) - 3)
							love.graphics.print(status.turn_count, x + 27 - width, (i * 28) - 5)
							love.graphics.print(status.turn_count, x + 26 - width, (i * 28) - 5)
							Draw.setColor(1, 1, 1, (1 - self.fader.alpha))
							love.graphics.print(status.turn_count, x + 26 - width, (i * 28) - 4)
							
							if status.statcon.amplifier and status.statcon.amplifier >= 1 then
								Draw.setColor(0, 0, 0, 1)
								love.graphics.print(status.statcon.amplifier, x + 3, (i * 28) - 20)
								love.graphics.print(status.statcon.amplifier, x + 3, (i * 28) - 19)
								love.graphics.print(status.statcon.amplifier, x + 3, (i * 28) - 21)
								love.graphics.print(status.statcon.amplifier, x + 4, (i * 28) - 19)
								love.graphics.print(status.statcon.amplifier, x + 5, (i * 28) - 20)
								love.graphics.print(status.statcon.amplifier, x + 5, (i * 28) - 19)
								love.graphics.print(status.statcon.amplifier, x + 5, (i * 28) - 21)
								love.graphics.print(status.statcon.amplifier, x + 4, (i * 28) - 21)
								Draw.setColor(1, 1, 1, 1)
								love.graphics.print(status.statcon.amplifier, x + 4, (i * 28) - 20)
							end
							
							x = x - 24
						end
					end
					
				end
			end)
		end
	end
end

function Lib:onRegistered()
    Mod.statuses = {}
    Mod.estatuses = {}

    for _,path,stat in Registry.iterScripts("battle/statuses") do
        assert(stat ~= nil, '"statuses/'..path..'.lua" does not return value')
        stat.id = stat.id or path
        Mod.statuses[stat.id] = stat
    end

    for _,path,estat in Registry.iterScripts("battle/enemy_statuses") do
        assert(estat ~= nil, '"enemy_statuses/'..path..'.lua" does not return value')
        estat.id = estat.id or path
        Mod.estatuses[estat.id] = estat
    end
end

function Lib:registerStatus(id, class)
    Mod.statuses[id] = class
end

function Lib:getStatus(id)
    return Mod.statuses[id]
end

function Lib:createStatus(id, ...)
    if Mod.statuses[id] then
        return Mod.statuses[id](...)
    else
        error("Attempt to create non existent status condition \"" .. tostring(id) .. "\"")
    end
end

function Lib:registerEnemyStatus(id, class)
    Mod.estatuses[id] = class
end

function Lib:getEnemyStatus(id)
    return Mod.estatuses[id]
end

function Lib:createEnemyStatus(id, ...)
    if Mod.estatuses[id] then
        return Mod.estatuses[id](...)
    else
        error("Attempt to create non existent status condition \"" .. tostring(id) .. "\"")
    end
end

return Lib