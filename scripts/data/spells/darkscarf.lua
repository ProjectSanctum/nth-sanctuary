local spell, super = Class(Spell, "darkscarf")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "DarkScarf"

    -- Battle description
    self.effect = "Damage w/\nDarkness"
    -- Menu description
    self.description = "Charges the caster with darkness and deals heavy DARK damage."
    -- Check description
    self.check = "Charges the caster with darkness and deals heavy DARK damage."

    -- TP cost
    self.cost = 100

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    -- Tags that apply to this spell
    self.tags = {"Damage", "dark"}
	self.snd = Music()
			self.snd:play("organ_enemy_loop_temp")
		self.snd:setPitch(0.02)

	self.p = 0.02
	self.charging = false
end

function spell:getCastMessage(user, target)
    return "* "..user.chara:getName().." used "..self:getCastName().."!"
end

function spell:getLightCastMessage(user, target)
    return "* "..user.chara:getName().." used "..self:getCastName().."!"
end

function spell:getTPCost(chara)
	local count = Game:getFlag("imbued_defeat", 0)
    return 100 - (count*5)
end

function spell:onCast(user, target)
	local radius_points = {}
    local particles = {}
    for k = 1, 360 do
    	local angle = math.rad(k)
    	local dx = math.cos(angle) * 100
    	local dy = math.sin(angle) * 100
    	table.insert(radius_points, {dx, dy})
	end
	Game.battle.timer:script(function (wait)
		user:setAnimation("battle/spell_ready")
        local aura = Sprite("effects/darksmoke")
		aura:addFX(ColorMaskFX(COLORS.white), "color")
		Game.battle:addChild(aura)
		aura.layer = user.layer + 1
		aura:setOrigin(0.5, 0.5)
        local x, y = user.x, user.y - user.height

		self.charging = true

        aura:setPosition(x, y)
        aura:setScale(0.1)
        aura.alpha = 0
        --Assets.playSound("rocket", 1, 0.5)
        Game.battle.timer:tween(2, aura, {scale_x = 5, scale_y = 5, alpha = 0.55}, 'out-cubic')
		Game.battle.timer:during(10, function()
	
			if (self.p < 0.96) and self.charging then
				self.p = MathUtils.clamp(self.p + 0.05 * DTMULT, 0, 1)
			end
			self.snd:setPitch(self.p)
			-- for i = #particles, 1, -1 do
       			-- local particle = particles[i]
       			-- local dx = aura.x - particle.x
       			-- local dy = aura.y - particle.y
       			-- if dx * dx + dy * dy < 50 then
       			    -- particle:remove()
       			    -- table.remove(particles, i)
       		    -- end
       		-- end
		end)
		for i = 1, 30 do
            local p = Sprite("effects/darksmoke")
            local offset = TableUtils.pick(radius_points)
			p:addFX(OutlineFX(COLORS.white))
            p:setPosition(x + offset[1], y + offset[2])
            p:setOrigin(0.5, 0.5)
            Game.battle:addChild(p)
            p.layer = aura.layer + 1
            p.physics.gravity = 0.2
            p.physics.gravity_direction = MathUtils.angle(p.x, p.y, x, y)
			p:fadeOutAndRemove(1, 0)
            table.insert(particles, p)
            wait(1/15)
        end
		wait(1)
		self.charging = false
		self.snd:stop()
		Assets.playSound("bigcut")
		Assets.playSound("laz_c", 1, 0.8)
		user:setAnimation("battle/attack")
		wait(0.5)

		local damage = self:getDamage(user, target)
		target:hurt(damage, user)
		target:flash()
		aura:fadeOutAndRemove(1, 0)
		Assets.playSound("heavydamage")
		Game.battle.camera:shake(20, 0, 1)
		wait(2)
		Game.battle:finishActionBy(user)
		user:resetSprite()
	end)
	return false
end

function spell:getDamage(user, target)
    local min_magic = MathUtils.clamp(user.chara:getStat("magic"), 1, 999)

    return math.ceil((min_magic * 30) + 90 + MathUtils.random(10))
end

function spell:update()
	super.update(self)
end

return spell
