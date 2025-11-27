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

    self.can_do_shrivel = false
    self.can_do_pushback = false
    --self.can_destroy = false
	
	self.updateimageangle = true
end

function LeechShape:update()
    super.update(self)

    self.collider = CircleCollider(self, 15, 17, self.radius/2)
end

function LeechShape:destroy()
    self.wave.spinfactor =  self.wave.spinfactor - 0.25
	super.destroy(self)
end

function LeechShape:onDamage(soul)
    local damage = self:getDamage()
    if damage > 0 then
		Assets.playSound("spawn_weaker", 1, 2)
		Assets.playSound("break1")
        local target = self:getTarget()
        local battlers = Game.battle:hurt(damage, false, target, self:shouldSwoon(damage, target, soul))
        soul.inv_timer = self.inv_timer
        soul:onDamage(self, damage)
		local spin_amt = (Game:getTension()/Game:getMaxTension())*0.25
		self.wave.spinfactor = self.wave.spinfactor + spin_amt
		local tension_loss = math.floor(4 + (8 * (Game:getTension()/Game:getMaxTension())))
		tension_loss = Game:removeTension(tension_loss)
		local tp_blob = self.wave:spawnBullet("leechblob", self.x, self.y)
		tp_blob:setLayer(self.layer - 1)
		tp_blob.attacker = self.attacker
		tp_blob.damage = self:getDamage()
		tp_blob.tension_amt = tension_loss
		tp_blob.spin_amt = spin_amt
		tp_blob:prime()
		local boom = Sprite("effects/titan/finisher_explosion", self.x, self.y)
		boom.rotation = math.rad(0)
		boom:setOrigin(0.5, 0.5)
		boom:setScale(0.09375, 0.09375)
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
