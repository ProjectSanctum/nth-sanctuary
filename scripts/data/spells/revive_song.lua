local spell, super = Class(Spell, "revive_song")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "ReviveSong"
    -- Name displayed when cast (optional)
    self.cast_name = "ReviveSong"

    -- Battle description
    self.effect = "Revive\nally"
    -- Menu description
    self.description = "Revives a DOWNed ally and heals them.\nOtherwise, heals a lot of HP."

    -- TP cost
    self.cost = 100

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"

    -- Tags that apply to this spell
    self.tags = {"heal"}
end

function spell:getTPCost(chara)
    local cost = super.getTPCost(self, chara)
    if chara and chara:getFlag("reviveUses") ~= nil then
		cost = 100 - math.min(chara:getFlag("reviveUses"), 15)
    end
    return cost
end

function spell:onCast(user, target)
	user.chara:setFlag("reviveUses", user.chara:getFlag("reviveUses", 0) + 1)
	if user.chara:getFlag("reviveUses") > 15 then
		user.chara:setFlag("reviveUses", 15)
	end
	local bx, by = target:getRelativePos(0, 0)
	user:setAnimation("sing")
    local effect = ReviveSongEffect(target, bx, by, function()
		local start_health = target.chara.health
		local base_heal = user.chara:getStat("magic") * 10
		if start_health <= 0 then
			local base_heal = -start_health + user.chara:getStat("magic") * 7.5		
		end
		local heal_amount = Game.battle:applyHealBonuses(base_heal, user.chara)

		target:heal(heal_amount)
    end)
    effect.layer = target.layer + 0.1
    Game.battle:addChild(effect)
	Game.battle.timer:after(75/30, function()
		Game.battle:finishAction()
	end)
    return false
end

return spell