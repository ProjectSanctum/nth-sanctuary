local Battle, super = HookSystem.hookScript(Battle)

function Battle:createPartyBattlers()
    for i = 1, math.min(4, #Game.party) do
        local party_member = Game.party[i]

        if Game.world.player and Game.world.player.visible and Game.world.player.actor.id == party_member:getActor().id then
            -- Create the player battler
            local player_x, player_y = Game.world.player:getScreenPos()
            local player_battler = PartyBattler(party_member, player_x, player_y)
            player_battler:setAnimation("battle/transition")
			if Game:getFlag("imbued_battle_fading", false) then
				player_battler:addFX(AlphaFX(0), "battle_transition_fade")
			end
            self:addChild(player_battler)
            table.insert(self.party, player_battler)
            table.insert(self.party_beginning_positions, { player_x, player_y })
            self.party_world_characters[party_member.id] = Game.world.player

            Game.world.player.visible = false
        else
            local found = false
            for _, follower in ipairs(Game.world.followers) do
                if follower.visible and follower.actor.id == party_member:getActor().id then
                    local chara_x, chara_y = follower:getScreenPos()
                    local chara_battler = PartyBattler(party_member, chara_x, chara_y)
                    chara_battler:setAnimation("battle/transition")
					if Game:getFlag("imbued_battle_fading", false) then
						chara_battler:addFX(AlphaFX(0), "battle_transition_fade")
					end
                    self:addChild(chara_battler)
                    table.insert(self.party, chara_battler)
                    table.insert(self.party_beginning_positions, { chara_x, chara_y })
                    self.party_world_characters[party_member.id] = follower

                    follower.visible = false

                    found = true
                    break
                end
            end
            if not found then
                local chara_battler = PartyBattler(party_member, SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)
                chara_battler:setAnimation("battle/transition")
				if Game:getFlag("imbued_battle_fading", false) then
					chara_battler:addFX(AlphaFX(0), "battle_transition_fade")
                end
				self:addChild(chara_battler)
                table.insert(self.party, chara_battler)
                table.insert(self.party_beginning_positions, { chara_battler.x, chara_battler.y })
            end
        end
    end
end

function Battle:updateTransition()
    while self.afterimage_count < math.floor(self.transition_timer) do
        for index, battler in ipairs(self.party) do
            local target_x, target_y = unpack(self.battler_targets[index])

            local battler_x = battler.x
            local battler_y = battler.y

            battler.x = MathUtils.lerp(self.party_beginning_positions[index][1], target_x, (self.afterimage_count + 1) / 10)
            battler.y = MathUtils.lerp(self.party_beginning_positions[index][2], target_y, (self.afterimage_count + 1) / 10)

			if Game:getFlag("imbued_battle_fading", false) then
				local afterimage = AfterImage(battler, self.transition_timer/20)
				self:addChild(afterimage)
			else
				local afterimage = AfterImage(battler, 0.5)
				self:addChild(afterimage)			
			end

            battler.x = battler_x
            battler.y = battler_y
			if Game:getFlag("imbued_battle_fading", false) then
				local fade = battler:getFX("battle_transition_fade")
				fade.alpha = self.transition_timer/10
			end
        end
        self.afterimage_count = self.afterimage_count + 1
    end

    self.transition_timer = self.transition_timer + 1 * DTMULT

    if self.transition_timer >= 10 then
        self.transition_timer = 10
        self:setState("INTRO")
    end

    for index, battler in ipairs(self.party) do
        local target_x, target_y = unpack(self.battler_targets[index])

        battler.x = MathUtils.lerp(self.party_beginning_positions[index][1], target_x, self.transition_timer / 10)
        battler.y = MathUtils.lerp(self.party_beginning_positions[index][2], target_y, self.transition_timer / 10)
    end
    for _, enemy in ipairs(self.enemies) do
		if Game:getFlag("imbued_battle_fading", false) then
			local fade = enemy:getFX("battle_transition_fade")
            if not fade then
                fade = enemy:addFX(AlphaFX(1), "battle_transition_fade")
            end
			fade.alpha = self.transition_timer/10
			enemy.x = enemy.target_x
			enemy.y = enemy.target_y
		else
			enemy.x = MathUtils.lerp(self.enemy_beginning_positions[enemy][1], enemy.target_x, self.transition_timer / 10)
			enemy.y = MathUtils.lerp(self.enemy_beginning_positions[enemy][2], enemy.target_y, self.transition_timer / 10)
		end
    end
end

function Battle:updateIntro()
    for index, battler in ipairs(self.party) do
		if Game:getFlag("imbued_battle_fading", false) then
			local fade = battler:getFX("battle_transition_fade")
			fade.alpha = 1
		end
	end
    for _, enemy in ipairs(self.enemies) do
		if Game:getFlag("imbued_battle_fading", false) then
			local fade = enemy:getFX("battle_transition_fade")
			fade.alpha = 1
		end
	end
    super.updateIntro(self)
end

function Battle:updateTransitionOut()
    if not self.battle_ui.animation_done then
        return
    end

    if self.background ~= nil and not self.background:isFading() then
        self.background:fadeOut()
    end

    local all_enemies = {}
    TableUtils.merge(all_enemies, self.enemies)
    TableUtils.merge(all_enemies, self.defeated_enemies)

    self.transition_timer = self.transition_timer - DTMULT

    if self.transition_timer <= 0 then--or not self.transitioned then
        local enemies = {}
        for k, v in pairs(self.enemy_world_characters) do
            table.insert(enemies, v)
        end
        self.encounter:onReturnToWorld(enemies)
        self:returnToWorld()
        return
    end

    for index, battler in ipairs(self.party) do
        battler:setAnimation("battle/transition_out")

        local target_x, target_y = unpack(self.battler_targets[index])

        battler.x = MathUtils.lerp(self.party_beginning_positions[index][1], target_x, self.transition_timer / 10)
        battler.y = MathUtils.lerp(self.party_beginning_positions[index][2], target_y, self.transition_timer / 10)
		--[[if Game:getFlag("imbued_battle_fading", false) then
			local fade = battler:getFX("battle_transition_fade")
			fade.alpha = self.transition_timer/10
		end]]
    end

    for _, enemy in ipairs(all_enemies) do
        local world_chara = self.enemy_world_characters[enemy]
        if enemy.target_x and enemy.target_y and not enemy.exit_on_defeat and world_chara and world_chara.parent then
            enemy.x = MathUtils.lerp(self.enemy_beginning_positions[enemy][1], enemy.target_x, self.transition_timer / 10)
            enemy.y = MathUtils.lerp(self.enemy_beginning_positions[enemy][2], enemy.target_y, self.transition_timer / 10)
        else
            local fade = enemy:getFX("battle_end")
            if not fade then
                fade = enemy:addFX(AlphaFX(1), "battle_end")
            end
            fade.alpha = self.transition_timer / 10
        end
    end
end

function Battle:nextTurn()
	super.nextTurn(self)
	
	for _, battler in ipairs(self.party) do
        if battler.chara:hasAssist() and (battler.chara:getAssistHealth() <= 0) and battler.chara:canAutoHeal() and self.encounter:isAutoHealingEnabled(battler) then
            battler:healAssist(battler.chara:autoHealAssistAmount(), nil, true)
        end
    end
end

return Battle