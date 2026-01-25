local TitanSpawnChaser, super = Class(ChaserEnemy, "tspawnenemy")

function TitanSpawnChaser:init(data)
    super.init(self, data.properties["actor"], data.x, data.y, data.properties)

    properties = data.properties or {}

    if properties["sprite"] then
        self.sprite:setSprite(properties["sprite"])
    elseif properties["animation"] then
        self.sprite:setAnimation(properties["animation"])
    end

    if properties["facing"] then
        self:setFacing(properties["facing"])
    end

    self.encounter = properties["encounter"]
    self.enemy = properties["enemy"]
    self.group = properties["group"]

    self.path = properties["path"]
    self.speed = properties["speed"] or 6

    self.progress = (properties["progress"] or 0) % 1
    self.reverse_progress = false

    self.can_chase = properties["chase"]
    self.chasing = properties["chasing"] or false
    self.chase_dist = properties["chasedist"] or 200

    self.chase_type = properties["chasetype"] or "linear"
    self.chase_speed = properties["chasespeed"] or 9
    self.chase_max = properties["chasemax"]
    self.chase_accel = properties["chaseaccel"]

    self.pace_type = properties["pacetype"]
    self.pace_marker = TiledUtils.parsePropertyList("marker", properties)
    self.pace_interval = properties["paceinterval"] or 24
    self.pace_return  = properties["pacereturn"] or true
    self.pace_speed = properties["pacespeed"] or 4
    self.swing_divisor = properties["swingdiv"] or 24
    self.swing_length = properties["swinglength"] or 400

    self.chase_timer = 0
    self.pace_timer = 0

    -- Used for multiplier acceleration to keep acceleration consistent across framerates.
    self.chase_init_speed = self.chase_speed
    -- Starting x-coordinate of the enemy for pacing types.
    self.spawn_x = data.x
    -- Starting y-coordinate of the enemy for pacing types.
    self.spawn_y = data.y
    self.pace_index = 1
    self.wandering = false
    self.return_to_spawn = false

    self.noclip = true
    self.enemy_collision = true

    self.remove_on_encounter = true
    self.encountered = false
    self.once = properties["once"] or false
    self.chase_once = properties["chase_once"] or false

    if properties["aura"] == nil then
        self.sprite.aura = Game:getConfig("enemyAuras")
    else
        self.sprite.aura = properties["aura"]
    end
	self:setHitbox(15, 12, 16, 15)
	self.no_shadow = true
	self.darkness = nil
	self.tspawn_siner = 0
	self.ripple_timer = 0
end

function TitanSpawnChaser:onAdd(parent)
	super.onAdd(self, parent)
	Game.world.timer:after(1/30, function()
		self.darkness = Game.world:getEvent("darkness")
	end)
end

function TitanSpawnChaser:update()
    if self:isActive() then
        if self.alert_timer == 0 and self.can_chase and not self.chasing then
            if self.world.player then
                Object.startCache()
                local in_radius = self.world.player:collidesWith(CircleCollider(self.world, self.x, self.y, self.chase_dist))
                if in_radius then
                    local sight = LineCollider(self.world, self.x, self.y, self.world.player.x, self.world.player.y)
                    if not self.world:checkCollision(sight, true) and not self.world:checkCollision(self.collider, true) then
						if not self:getFlag("dont_chase", false) then
							self.path = nil
							Assets.stopAndPlaySound("tspawn", 1, MathUtils.random(0.7, 0.9))
							local x, y = self:getRelativePos(self.width/2, 19 + self.sprite.y)
							self.world.map.ripple_fx:makeRipple(x, y, 60, COLORS.red, 120, 1, 12)
							self.world.map.ripple_fx:makeRipple(x, y, 60, COLORS.red, 200, 1, 12)
							self.world.timer:after(15/30, function()
								self.chasing = true
							end)
							if self.darkness then
								self.world.timer:lerpVar(self.darkness, "alpha", 0, 1, 60, 2, "out")
								self.darkness_unlit = true
								self.world.player.tspawn_circle_light = true
							end
							self.ripple_timer = 0
							self.can_chase = false
							self:onAlerted()
						end
                    end
                end
                Object.endCache()
            end
        elseif self.chasing then
            self:chaseMovement()
			self.sprite.anim_delay = MathUtils.lerp(0.25, 1/30, MathUtils.clamp(self.chase_speed / self.chase_max, 0, 1))
			if self.ripple_timer ~= nil then
				if self.ripple_timer >= 20 then
					local hhsp = MathUtils.lengthDirX(self.chase_speed, -MathUtils.angle(self.x, self.y, self.world.player.x, self.world.player.y))
					local vvsp = MathUtils.lengthDirY(self.chase_speed, -MathUtils.angle(self.x, self.y, self.world.player.x, self.world.player.y))
					local x, y = self:getRelativePos(self.width/2, 19 + self.sprite.y)
					self.world.map.ripple_fx:makeRipple(x, y, 60, COLORS.red, 120, 1, 12, 0, hhsp, vvsp)
					self.ripple_timer = 0
				else
					self.ripple_timer = self.ripple_timer + DTMULT
				end
			end
        end
    end
	self.tspawn_siner = self.tspawn_siner + 0.1 * DTMULT
	self.sprite.y = self.sprite.y + (math.sin(self.tspawn_siner) * 0.6) * DTMULT

    super.super.update(self)
end

function TitanSpawnChaser:onEncounterEnd(primary, encounter)
	if self.darkness then
		Game.world.timer:lerpVar(self.darkness, "alpha", 1, 0, 30)
		Game.world.timer:after(1, function()
			Game.world.player.tspawn_circle_light = false
		end)
	end
    if self.remove_on_encounter then
        self:remove()
    else
        self.visible = true
    end
    if self.once then
        self:setFlag("dont_load", true)
    end
    if self.chase_once then
        self:setFlag("dont_chase", true)
    end
end

function TitanSpawnChaser:onCollide(player)
    if self:isActive() and player:includes(Player) then
        self.encountered = true
        local encounter = self.encounter
        if not encounter and Registry.getEnemy(self.enemy or self.actor.id) then
            encounter = Encounter()
            encounter:addEnemy(self.actor.id)
        end
        if encounter then
            self.world.encountering_enemy = true
			self.sprite:setAnimation("encounter")
			TableUtils.clear(self.world.map.ripple_fx.ripples)
			local ripcount = 3
			for i = 0, ripcount do
				local hhsp = MathUtils.lengthDirX(2, -math.rad((360 / ripcount) * i))
				local vvsp = MathUtils.lengthDirY(2, -math.rad((360 / ripcount) * i))
				local x, y = self:getRelativePos(self.width/2, 19)
				self.world.map.ripple_fx:makeRipple(x, y, 60, COLORS.red, 120, 1, 14, 0, hhsp, vvsp)
			end
			local pl = Game.world.player
			local px = pl.x - pl.width/2
			local py = pl.y
			Game.world.timer:tween(20/30, self, {x = px + 80}, "out-quart")
			Game.world.timer:tween(20/30, self, {y = py}, "out-quad")
			self.layer = WORLD_LAYERS["above_events"]
            self.sprite.aura = false
            Game.lock_movement = true
			self.ripple_timer = nil
            self.world.timer:script(function(wait)
                Assets.playSound("tensionhorn")
                wait(10/30)
                local src = Assets.playSound("tensionhorn")
                src:setPitch(1.1)
                wait(24/30)
                self.world.encountering_enemy = false
                Game.lock_movement = false
                local enemy_target = self
                if self.enemy then
                    enemy_target = {{self.enemy, self}}
                end
				self.darkness_unlit = false
                Game:encounter(encounter, true, enemy_target, self)
            end)
        end
    end
end

return TitanSpawnChaser