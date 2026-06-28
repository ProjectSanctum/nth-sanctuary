local spell, super = Class(Spell, "scythemare")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Scythemare"
    -- Name displayed when cast (optional)
    self.cast_name = "Scythemare"

    -- Battle description
    self.effect = "Spare all\nTIRED foes"
    -- Menu description
    self.description = "Inflicts all enemies with bad dreams.\nAll TIRED enemies will be SPAREd."

    -- TP cost
    self.cost = 100

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemies"

    -- Tags that apply to this spell
    self.tags = { "spare_tired" }
end

function spell:getTPCost(chara)
    local cost = super.getTPCost(self, chara)
    if chara and chara:getFlag("pacifyUses") ~= nil then
		if chara:getFlag("pacifyUses") == 0 then
			cost = 70
		elseif chara:getFlag("pacifyUses") >= 1 and chara:getFlag("pacifyUses") < 4 then
			cost = 65
		elseif chara:getFlag("pacifyUses") >= 4 and chara:getFlag("pacifyUses") < 7 then
			cost = 60
		elseif chara:getFlag("pacifyUses") >= 7 and chara:getFlag("pacifyUses") < 10 then
			cost = 55
		elseif chara:getFlag("pacifyUses") >= 10 and chara:getFlag("pacifyUses") < 13 then
			cost = 50
		elseif chara:getFlag("pacifyUses") >= 13 and chara:getFlag("pacifyUses") < 15 then
			cost = 45
		elseif chara:getFlag("pacifyUses") >= 15 then
			cost = 40
		end
    end
    return cost
end

function spell:onCast(user, target)
    local count = 0
	user.chara:setFlag("pacifyUses", user.chara:getFlag("pacifyUses", 0) + 1)
	if user.chara:getFlag("pacifyUses") > 15 then
		user.chara:setFlag("pacifyUses", 15)
	end
    for _, enemy in ipairs(target) do
        if enemy.done_state == nil then
            local success = enemy.tired

            if success then
                enemy.done_state = "PACIFIED"
            end

            Game.battle.timer:after(10 / 30 * count, function()
				local parent = enemy.parent
				local x, y = enemy:getRelativePos(enemy.width / 2, enemy.height / 2)

				local effect = ScythemareEffect(x, y, count, success)
				effect.layer = enemy.layer + 0.1
				if count == 0 then
					effect.laugh = true
				end
				parent:addChild(effect)
				
                Game.battle.timer:after(56 / 30, function()
                    enemy:spare(true)
                end)
			end)

            count = count + 1
        end
    end
	Game.world.timer:after((64 + (count * 10)/30, function()
		Game.battle:finishAction()
	end)
    return false
end

return spell