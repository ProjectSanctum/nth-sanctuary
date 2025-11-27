local LeechShape, super = Class(DarkShapeBullet)

function LeechShape:init(x, y)
    super.init(self, x, y, "bullets/titan/leech/idle", "bullets/titan/leech/shrink")
	
    --self.radius = 22
    --self.light = 0
    --self.color = COLORS.red
    --self.tracking_val2 = 1
    --self.destroy_on_hit = false
    --self.speed_max = self.speed_max * 2.5

    --self:setScale(1, 1)
    --self.scalefactor = 1

    --self.can_do_shrivel = false
    --self.can_do_pushback = false
    --self.can_destroy = false
	
	self.updateimageangle = true
end

function LeechShape:update()
    super.update(self)

    self.collider = CircleCollider(self, 15, 17, self.radius/2)
end

function LeechShape:destroy()
    self.wave.spinfactor =  self.wave.spinfactor - 0.3
	super.destroy(self)
end

function LeechShape:onDamage(soul)
    local damage = self:getDamage()
    if damage > 0 then
        local target = self:getTarget()
        local battlers = Game.battle:hurt(damage, false, target, self:shouldSwoon(damage, target, soul))
        soul.inv_timer = self.inv_timer
        soul:onDamage(self, damage)
		local bullet = self.wave:spawnBullet("leechblob", self.x, self.y)
		bullet.attacker = self.attacker
		bullet.damage = self:getDamage()
        return battlers
    end
    return {}
end

return LeechShape
