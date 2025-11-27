local LeechShape, super = Class(DarkShapeBullet)

function LeechShape:init(x, y)
    super.init(self, x, y, "bullets/titan/leech/idle", "bullets/titan/leech/shrink")
	
    self.can_do_pushback = false	
	self.updateimageangle = true
end

function LeechShape:update()
    super.update(self)

    self.collider = CircleCollider(self, 15, 17, self.radius/2)
end

function LeechShape:destroy()
    self.wave.spinfactor =  self.wave.spinfactor - 0.2
	super.destroy(self)
end

function LeechShape:onDamage(soul)
    local damage = self:getDamage()*math.min((1-self.light)+0.25, 1)
    if damage > 0 then
		Assets.playSound("spawn_weaker", 1, 2)
		Assets.playSound("break1")
        local target = self:getTarget()
        local battlers = Game.battle:hurt(damage, false, target, self:shouldSwoon(damage, target, soul))
        soul.inv_timer = self.inv_timer
        soul:onDamage(self, damage)
		local spin_amt = 0.1+(Game:getTension()/Game:getMaxTension())*0.1
		self.wave.spinfactor = self.wave.spinfactor + spin_amt*math.min((1-self.light)+0.25, 1)
		local tension_loss = math.floor(4*math.min((1-self.light)+0.25, 1) + (12 * (Game:getTension()/Game:getMaxTension())*math.min((1-self.light)+0.25, 1)))
		tension_loss = Game:removeTension(tension_loss)
		local tp_blob = self.wave:spawnBullet("leechblob", self.x, self.y)
		tp_blob:setLayer(self.layer - 1)
		tp_blob.attacker = self.attacker
        local enemy_average_hp = 1
		local total_hp = 0
		local total_mhp = 0
		for _,enemy in ipairs(Game.battle:getActiveEnemies()) do
			total_hp = total_hp + enemy.health
			total_mhp = total_mhp + enemy.max_health
		end
		if total_hp > 0 then
			for _,enemy in ipairs(Game.battle:getActiveEnemies()) do
				if enemy.health / enemy.max_health < enemy_average_hp/2 then
					tp_blob.attacker = enemy
				end
			end
		end
		tp_blob.damage = damage
		tp_blob.tension_amt = tension_loss
		tp_blob.spin_amt = spin_amt
		tp_blob:setScale(1+(0.5*(1-self.light)))
		tp_blob.size_to = 0.6+(0.6*math.min((1-self.light)+0.25))
		tp_blob:prime()
		local boom = Sprite("effects/titan/finisher_explosion", self.x, self.y)
		boom.rotation = math.rad(0)
		boom:setOrigin(0.5, 0.5)
		boom:setScale(0.0625+(0.03125*(1-self.light)), 0.0625+(0.03125*(1-self.light)))
		boom:setLayer(BATTLE_LAYERS["top"])
		Game.battle.timer:lerpVar(boom, "scale_x", boom.scale_x, boom.scale_x * 3, 4)
		Game.battle.timer:lerpVar(boom, "scale_y", boom.scale_y, boom.scale_y * 3, 4)
		boom:setFrame(3)
		boom:play(1/30, false)
		Game.battle:addChild(boom)

		Game.battle.timer:after(5/30, function()
			boom:remove()
		end)
        return battlers
    end
    return {}
end

return LeechShape
