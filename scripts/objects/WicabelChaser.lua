local WicabelChaser, super = Class(ChaserEnemy)

function WicabelChaser:init(x, y)
    super.init(self, "wicabel", x, y)
    
	self.sprite:setSprite("body_1")
	self.sprite:setPartVisible(false)

	self.encounter = "wicabel"
	self.encounted = false
	self.makeexcl = true
	self.con = 0
	self.myspeed = 0
	self.remove_on_encounter = true
    self.sprite.aura = false
	self.flag = "bigpiano_wicabel"
end

function WicabelChaser:onEncounterEnd(primary, encounter)
    if self.remove_on_encounter then
		local afterimage = AfterImage(self, 0.5)
		afterimage.physics.gravity = -0.5
		Game.world:addChild(afterimage)
		if self.flag then
			Game:setFlag(self.flag, true)
		end
        self:remove()
    else
        self.visible = true
    end
end

function WicabelChaser:update()
    super.update(self)
	local delaytime = 10
	if self.con == 1 then
		if self.makeexcl then
			self.makeexcl = false
			Assets.stopAndPlaySound("alert")
			self.alert_timer = 20
			if self.alert_icon then self.alert_icon:remove() end
			self.alert_icon = Sprite("effects/alert", (self.width/2), 0)
			self.alert_icon:setOrigin(0.5, 1)
			self.alert_icon.layer = 100
			self.alert_icon.physics.speed_y = -3
			self.alert_icon.physics.gravity = 0.7
			self.alert_icon.y_start = self.alert_icon.y
			self:addChild(self.alert_icon)
			return self.alert_icon
		end
		Game.world.timer:after(delaytime/30, function()
			self.sprite.aura = true
			self.con = 1.1
		end)
		self.con = -1
	end
	if self.con == 1.1 then
		local diff = 0
		if self.flag and Game:getFlag(self.flag) == true then
			diff = 1
		end
		local maxspeed = 18
		local accel = 1/3
		if diff == 1 then
			maxspeed = 8
			accel = 0.125
		end
		if self:isActive() then
			self.myspeed = MathUtils.lerp(self.myspeed, maxspeed, accel*DTMULT)
			local myx = self.x
			local myy = self.y - 10
			local targx = Game.world.player.x
			local targy = Game.world.player.y - Game.world.player.sprite.texture:getHeight()/2
			local dir = MathUtils.angle(myx, myy, targx, targy)
			self.x = self.x + math.cos(dir) * self.myspeed * DTMULT
			self.y = self.y + math.sin(dir) * self.myspeed * DTMULT
		end
	end
    if self.alert_icon then
		if self.alert_icon.y >= self.alert_icon.y_start then
			self.alert_icon.y = self.alert_icon.y_start
		end
    end
end

function WicabelChaser:isActive()
    return not self.encountered and
        not self.world.encountering_enemy and
        not self.world:hasCutscene() and
        self.world.state ~= "MENU" and
        Game.state == "OVERWORLD"
end

function WicabelChaser:onCollide(player)
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
            self.sprite.aura = false
            Game.lock_movement = true
            self.world.timer:script(function(wait)
                Assets.playSound("tensionhorn")
                wait(10/30)
                local src = Assets.playSound("tensionhorn")
                src:setPitch(1.1)
                wait(26/30)
                self.world.encountering_enemy = false
                Game.lock_movement = false
                local enemy_target = self
                if self.enemy then
                    enemy_target = {{self.enemy, self}}
                end
                Game:encounter(encounter, true, enemy_target, self)
            end)
        end
    end
end

return WicabelChaser