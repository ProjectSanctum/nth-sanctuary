local SmallBullet, super = Class(Bullet)

function SmallBullet:init(x, y, rot)
    -- Last argument = sprite path
    super.init(self, x, y, "enemies/jellycruel/idle")
	self:setScale(0.6, 0.6)
	self:setScaleOrigin(0.5, 0)
	self.rotation = rot
end

function SmallBullet:update()
    super.update(self)
end


function SmallBullet:onDamage(soul)
	super.onDamage(self, soul)
	local target = self:getTarget()
    if isClass(target) and target:includes(PartyBattler) then
		if MathUtils.randomInt(0, 3) <= Game.battle.encounter.poison_chance and not target:hasStatus("poison") then
			Game.battle.encounter.poison_chance = 0
			Assets.stopAndPlaySound("statuseffect")
			target:inflictStatus("poison")
			target.hit_count = target.hit_count + 1
			target:statusMessage("msg", "poisoned")
		else
			Game.battle.encounter.poison_chance = Game.battle.encounter.poison_chance + 1
		end
	end
end

return SmallBullet