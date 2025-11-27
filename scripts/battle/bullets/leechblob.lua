---@class LeechBlob : Bullet
---@overload fun(...) : LeechBlob
local LeechBlob, super = Class(Bullet)

function LeechBlob:init(x, y)
    super.init(self, x, y, "battle/bullets/titan/darkshape_transform")
    self.sprite:stop()

    self.layer = BATTLE_LAYERS["top"]
	self:setScale(1,1)
    self.collidable = false
    self.grazed = true
    self.size = 2
    self.damage = 90
	self.tension_amt = 0

    self.prime_speed = 12
    self.max_speed = 40
    self.acc = 200

    self.image_index = 1
    self.image_speed = 0.5
    self.r = 1
    self.g = 1
    self.b = 1
end

function LeechBlob:prime()
    local size_to = 1.2
	
    Game.battle.timer:lerpVar(self, "scale_x", self.scale_x, size_to, 20)
    Game.battle.timer:lerpVar(self, "scale_y", self.scale_y, size_to, 20)
    
    if self.size == 0 then
        Game.battle.timer:after(20/30, function()
		    self:remove()
        end)
    else
        Game.battle.timer:lerpVar(self, "r", self.r, 0, 20)
        Game.battle.timer:lerpVar(self, "g", self.g, 1, 20)
        Game.battle.timer:lerpVar(self, "b", self.b, 0, 20)

        Game.battle.timer:after(20/30, function()
		    self.collidable = true
        end)
    end
    
	self.target_x = self.attacker.x+self.attacker.width/2
	self.target_y = self.attacker.y-self.attacker.height
    self.physics.direction = MathUtils.angle(self.x, self.y, self.target_x, self.target_y) + -math.rad(180)
    self.physics.speed = self.prime_speed

    --Assets.playSound("hurt_bc", nil, 0.5)
end

function LeechBlob:update()
    super.update(self)
	
    self.image_index = self.image_index + (1/(30 * self.image_speed)) * DTMULT

    self:setColor({self.r, self.g, self.b})
    self.sprite:setFrame(1 + math.floor(self.image_index % 6))
    self.physics.speed = self.physics.speed * 0.85
	
	self.target_x = self.attacker.x+self.attacker.width/2
	self.target_y = self.attacker.y-self.attacker.height
    if self.collidable then
        local accel = self.acc / Utils.dist(self.x, self.y, self.target_x + 2, self.target_y + 2)
        self.physics.direction = Utils.angle(self.x, self.y, self.target_x, self.target_y)
        self.physics.speed = MathUtils.approach(self.physics.speed, self.max_speed, accel*DTMULT)
    end
    if MathUtils.dist(self.x, self.y, self.target_x, self.target_y) <= 40 then
		local damage = self:getDamage()
		if damage > 0 then
			if self.attacker.hit_count >= 4 then
				self.attacker.hit_count = 0
			end
			self.attacker:heal(damage)
			Assets.stopSound("power")
			Assets.stopAndPlaySound("titan_cure", 1, 2)
		end
		self:finisherExplosion()
		self:remove()
	end
end

function LeechBlob:onCollide()
	if not self.collidable then
		return
	end
    local damage = self:getDamage()
    if damage > 0 then 
		local party = Game.battle:getPartyFromTarget(self:getTarget())
        for _, target in pairs (party) do
			if target.hit_count >= 4 then
				target.hit_count = 0
			end
			target:heal(damage)
        end
    end
	if self.tension_amt > 0 then
		Assets.stopAndPlaySound("swallow", 0.5+((self.tension_amt/Game:getMaxTension()) * 1.5))
		Assets.stopAndPlaySound("eye_telegraph", 0.5+((self.tension_amt/Game:getMaxTension()) * 1.5), 2)
		Game.battle.tension_bar:flash()
		Game:giveTension(self.tension_amt)
	end
	if self.spin_amt > 0 then
	    self.wave.spinfactor =  self.wave.spinfactor - math.floor(self.spin_amt/2)
	end
    self:finisherExplosion()
    self:remove()
end

function LeechBlob:finisherExplosion()
    local boom = Sprite("effects/titan/finisher_explosion", self.x, self.y)
    boom.rotation = math.rad(0)
    boom:setOrigin(0.5, 0.5)
    boom:setScale(0.09375, 0.09375)
    boom:setLayer(BATTLE_LAYERS["top"])
    Game.battle.timer:lerpVar(boom, "scale_x", boom.scale_x, boom.scale_x * 3, 4)
    Game.battle.timer:lerpVar(boom, "scale_y", boom.scale_y, boom.scale_y * 3, 4)
    boom:setFrame(3)
    boom:play(1/30, false)
    boom:setColor(COLORS.lime)
    Game.battle:addChild(boom)

    Game.battle.timer:after(5/30, function()
	    boom:remove()
    end)
end

return LeechBlob
