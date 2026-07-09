local MidBattleParty = {}

function MidBattleParty:init()
    self.transitioning = {}
    self.introing = {}
    self.party_beginning_positions = {}
    Utils.hook(PartyBattler, "init", function (orig, partyBattler, chara, x, y)
        orig(partyBattler, chara, x, y)
        partyBattler.intro_timer = 0
        partyBattler.transition_timer = 0
        partyBattler.afterimage_count = 0
    end)
end

---@param member     string
---@param x    number?
---@param y    number?
---@param follower    Character?
---@param transition    boolean?
---@param index number?
function MidBattleParty:addPartyBattler(member, x, y, follower, transition, index)
    if (not Game.battle) then
        Console:warn("addPartyBattler was called, but Game.battle is "..Game.battle)
        return nil
    end

    local party = Game.battle.party
    index = index or #party + 1

    local battler
    if type(member) == "string" then
        battler = PartyBattler(Game:addPartyMember(member), SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)
    else
        battler = member
    end
    
    table.insert(party, index, battler)

    if (x == nil) or (y == nil) then x, y = Game.battle.encounter:getPartyPosition(index) end

    local chara_x, chara_y
    local memberFollower   
    if (follower) then
        if (type(follower) == "table") then
            memberFollower = follower:convertToFollower(index-1)
            --memberFollower:setPosition(x,y)
        else
            memberFollower = Game.world:spawnFollower(Game.party_data[member]:getActor(),
            { party = member })
            memberFollower:setScreenPos(x,y)
        end
        
        memberFollower.visible = false
        chara_x, chara_y = memberFollower:getScreenPos() 
        Game.battle.party_world_characters[member] = memberFollower
        battler:setPosition(chara_x, chara_y)
    else
        if transition then
            battler:setPosition(-battler.sprite.width/2, y)
            chara_x, chara_y = battler:getPosition()
        end
    end

     

    if (#Game.battle.party_beginning_positions < index) then
        Game.battle.party_beginning_positions[index] = { chara_x, chara_y }
        self.party_beginning_positions[index] = Game.battle.party_beginning_positions[index]
    end


    Game.battle.battler_targets[index] = {x, y}
    if transition then  
        self:setTransitioning(battler)
    else
        battler:setPosition(x, y)
    end

    if Game.battle and Game.state == "BATTLE" then
        print(battler)
        Game.battle:addChild(battler)
        MidBattleParty:refreshActionBoxes()
        --Game.battle.battle_ui:transitionIn()
    end
    return battler, memberFollower
end

function MidBattleParty:preUpdate()
    introSnd = false
    for _, battler in ipairs(self.transitioning) do
        MidBattleParty:updateTransition(battler)
    end

    for _, battler in ipairs(self.introing) do
        MidBattleParty:updateIntro(battler)
    end
end

function MidBattleParty:removePartyBattler(index)
    if (not Game.battle) then
        Console:warn("addPartyBattler was called, but Game.battle is "..Game.battle)
        return nil
    end
    Game.battle.party[index].sprite.visible = false
    local party = Game.battle.party
    table.remove(party, index)
    MidBattleParty:refreshPartyPositions(nil, true)
    MidBattleParty:refreshActionBoxes()
end

---@param battler PartyBattler
function MidBattleParty:updateTransition(battler)
    local index = Utils.getIndex(Game.battle.party, battler)
    while battler.afterimage_count < math.floor(battler.transition_timer) do
        local target_x, target_y = unpack(Game.battle.battler_targets[index])

        local battler_x = battler.x
        local battler_y = battler.y

        battler.x = Utils.lerp(self.party_beginning_positions[index][1], target_x, (battler.afterimage_count + 1) / 10)
        battler.y = Utils.lerp(self.party_beginning_positions[index][2], target_y, (battler.afterimage_count + 1) / 10)

        local afterimage = AfterImage(battler, 0.5)
        Game.battle:addChild(afterimage)

        battler.x = battler_x
        battler.y = battler_y
        
        battler.afterimage_count = battler.afterimage_count + 1
    end

    battler.transition_timer = battler.transition_timer + 1 * DTMULT

    if battler.transition_timer >= 10 then
        self:setIntroing(battler)
    end

    local target_x, target_y = unpack(Game.battle.battler_targets[index])

    battler.x = Utils.lerp(self.party_beginning_positions[index][1], target_x, battler.transition_timer / 10)
    battler.y = Utils.lerp(self.party_beginning_positions[index][2], target_y, battler.transition_timer / 10)

end

---@param positions table
---@param transition boolean
function MidBattleParty:refreshPartyPositions(positions, transition)
    Game.battle.battler_targets = positions or {}
    for i = 1, #Game.battle.party, 1 do
        if (#Game.battle.battler_targets < i or not Game.battle.battler_targets[i]) then
            local x,y = Game.battle.encounter:getPartyPosition(i)
            table.insert(Game.battle.battler_targets, i, {x,y})
        end
    end

    for index, value in ipairs(Game.battle.party) do
        if (transition) then
            local x, y = value:getPosition()
            self.party_beginning_positions[index] = {x, y}
            self:setTransitioning(value)
        else
            value:setPosition(unpack(Game.battle.battler_targets[index]))
        end
    end
end

function MidBattleParty:setTransitioning(battler)
    print(battler.chara.name.." is transitioning")
    Utils.removeFromTable(self.transitioning, battler)
    Utils.removeFromTable(self.introing, battler)
    battler:setAnimation("battle/transition")
    battler.transition_timer = 0
    battler.afterimage_count = 0
    
    table.insert(self.transitioning,battler)
end

local introSnd = false
function MidBattleParty:setIntroing(battler)
    print(battler.chara.name.." is introing")
    Utils.removeFromTable(self.transitioning, battler)
    Utils.removeFromTable(self.introing, battler)

    battler.transition_timer = 10
    battler.intro_timer = 0

    battler:setAnimation("battle/intro")
    if (introSnd) then
        Assets.playSound("weaponpull_fast", 0.5)
        introSnd = true
    end
    table.insert(self.introing, battler)
end

---@param battler PartyBattler
function MidBattleParty:updateIntro(battler)
    battler.intro_timer = battler.intro_timer + 1 * DTMULT
    if battler.intro_timer >= 15 then -- TODO: find out why this is 15 instead of 13
        Utils.removeFromTable(self.introing, battler)
        
        battler.intro_timer = 15
        battler:resetSprite()
        --self:nextTurn()
    end
end

function MidBattleParty:refreshActionBoxes()
    for k, v in ipairs(Game.battle.battle_ui.action_boxes) do
        v:remove()
    end
    Game.battle.battle_ui.action_boxes = {}
    Game.battle.battle_ui.attack_boxes = {}

    Game.battle.battle_ui.attacking = false

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

    for index, battler in ipairs(Game.battle.party) do
        print(battler.chara.id)
        local action_box = ActionBox(size_offset + (index - 1) * (213 + box_gap), 0, index, battler)
        Game.battle.battle_ui:addChild(action_box)
        table.insert(Game.battle.battle_ui.action_boxes, action_box)
        battler.chara:onActionBox(action_box, false)
    end

    --MOD COMPATIPILITY
    if ((Mod.libs["moreparty"]) and #Game.battle.party > 3) then 
        local x = 0
        local realW = ((640 - 1) / (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4)) -- SCREEN_WIDTH

        local e = 0

        for k, v in ipairs(Game.battle.battle_ui.action_boxes) do
            if k > (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4) then
                v.x = x - e +
                    (Kristal.getLibConfig("moreparty", "classic_mode") and ((6 - #Game.party) * (640 - 1) / 6) or ((8 - #Game.party) * (640 - 1) / 8))
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
            for k, v in ipairs(Game.battle.battle_ui.action_boxes) do
                v.y = v.y - (Game:getConfig("oldUIPositions") and 36 or 37)
            end
        end
    end

end



return MidBattleParty
