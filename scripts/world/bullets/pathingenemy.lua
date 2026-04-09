local PathingEnemy, super = Class(WorldBullet)

function PathingEnemy:init(x, y, properties)
    super.init(self, x, y, "world/events/climbenemy/enemy_40")
	self:setScale(1)
    local properties = properties or {}
	self.buffer = 0
	self:setHitbox(2, 2, 36, 36)
	self.damagecon = 0
	self.timer = 0
	self.bactive = true
	self.hit = 0
	self.dir = properties["dir"] or 0
	self.prefdir = properties["prefdir"] or "left"
	self.neutralcon = 0
	self.waittimer = properties["waittimer"] or 0
	self.updwait = -1
	self.ignoreblocked = false
	self.movetimer = properties["movetimer"] or 0
	self.updmove = -1
	self.safex = self.x
	self.safey = self.y
	self.lastdir = -1
	self.failmovecount = 0
	self.failmovethresh = 4
	self.movevistype = properties["movevistype"] or 0
	self.angle = 0
	self.damage = properties["damage"] or 25
	self.waittime = properties["waittime"] or 30
	self.movetime = properties["speed"] or 12
	self.influenceable = properties["influence"] or true
	self.homedistance = properties["homedist"] or 120
	self.movetype = properties["movetype"] or 0
    self.path = properties["path"]
    self.speed = properties["speed"] or 12
    self.progress = (properties["progress"] or 0) % 1
    self.reverse_progress = false
	self.inv_timer = 1
	self.enemy_collision = true
	self.alpha = 0
	self.sprite.visible = false
	self.animindex = 0
	self.onscreen = properties["onscreen"] or false
	self.bounds = properties["bounds"] or nil
end

function PathingEnemy:onAdd(parent)
    super.onAdd(self, parent)

    self:snapToPath()
	self.sprite.rotation = math.rad(-self.dir * 90)
end

function PathingEnemy:snapToPath()
    if self.path and self.world.map.paths[self.path] then
        local path = self.world.map.paths[self.path]

        local progress = self.progress
        if not path.closed then
            progress = Ease.inOutSine(progress, 0, 1, 1)
        end

        if path.shape == "line" then
            local dist = progress * path.length
            local current_dist = 0

            for i = 1, #path.points - 1 do
                local next_dist = MathUtils.dist(path.points[i].x, path.points[i].y, path.points[i + 1].x, path.points[i + 1].y)

                if current_dist + next_dist > dist then
                    local x = MathUtils.lerp(path.points[i].x, path.points[i + 1].x, MathUtils.clamp((dist - current_dist) / next_dist, 0, 1))
                    local y = MathUtils.lerp(path.points[i].y, path.points[i + 1].y, MathUtils.clamp((dist - current_dist) / next_dist, 0, 1))

                    if self.debug_x and self.debug_y and Kristal.DebugSystem.last_object == self then
                        x = Utils.ease(self.debug_x, x, Kristal.DebugSystem.release_timer, "outCubic")
                        y = Utils.ease(self.debug_y, y, Kristal.DebugSystem.release_timer, "outCubic")
                        if Kristal.DebugSystem.release_timer >= 1 then
                            self.debug_x = nil
                            self.debug_y = nil
                        end
                    end

                    self.x = x + 20
					self.y = y + 20
					self.sprite.rotation = MathUtils.angle(path.points[i].x, path.points[i].y, path.points[i + 1].x, path.points[i + 1].y) - math.rad(90)
                    break
                else
                    current_dist = current_dist + next_dist
                end
            end
        elseif path.shape == "ellipse" then
            local angle = progress * (math.pi * 2)
            local x = path.x + math.cos(angle) * path.rx
            local y = path.y + math.sin(angle) * path.ry

            if self.debug_x and self.debug_y and Kristal.DebugSystem.last_object == self then
                x = Utils.ease(self.debug_x, x, Kristal.DebugSystem.release_timer, "outCubic")
                y = Utils.ease(self.debug_y, y, Kristal.DebugSystem.release_timer, "outCubic")
                if Kristal.DebugSystem.release_timer >= 1 then
                    self.debug_x = nil
                    self.debug_y = nil
                end
            end

            self.x = x + 20
			self.y = y + 20
			self.sprite.rotation = angle
        end
    end
end

function PathingEnemy:onDamage(soul)
    if self:getDamage() > 0 then
		local remdam = self.damage
		local lowhp = 999
		for _, party in ipairs(Game.party) do
			if party and party:getHealth() < lowhp then
				lowhp = party:getHealth()
			end
		end
		if lowhp < 120 then
			self.damage = math.max(MathUtils.round(self.damage * 0.8), 0)
		end
        self.world:hurtParty(self.damage)
        soul.inv_timer = self.inv_timer
		self.hit = 1
		self.damage = remdam
    end
end

function PathingEnemy:update()
    super.update(self)
	if self.doom then
		self.alpha = MathUtils.lerp(self.alpha, -0.1, 1/6*DTMULT)
		
		if self.alpha <= 0 then
			self:remove()
		end
	else
		self.alpha = MathUtils.lerp(self.alpha, 1, 1/6*DTMULT)
	end
	if not Game.world.player:isMovementEnabled() then
		return
	end
	if self.movetype == 9 then
		return
	end
    local x, y = self:getScreenPos()
	local margin = 80
    if self.onscreen and not (x > -margin and x < SCREEN_WIDTH + margin and y < SCREEN_HEIGHT + margin and y > -margin) then
		return
    end
    if self.bounds then
		Object.startCache()
		if not Game.world.player:collidesWith(Game.world:getEvent(self.bounds.id)) then
			Object.endCache()
			return
		end
		Object.endCache()
    end
	if self.path then
        if self.world.map.paths[self.path] then
            local path = self.world.map.paths[self.path]

            if self.reverse_progress then
                self.progress = self.progress - (self.speed / path.length) * DTMULT
            else
                self.progress = self.progress + (self.speed / path.length) * DTMULT
            end
            if path.closed then
                self.progress = self.progress % 1
            elseif self.progress > 1 or self.progress < 0 then
                self.progress = MathUtils.clamp(self.progress, 0, 1)
                self.reverse_progress = not self.reverse_progress
            end

            self:snapToPath()
			self.sprite:setFrame(math.floor(self.animindex % 3) + 1)
		end
	else
		if self.neutralcon == 0 then
			self.waittimer = self.waittimer + DTMULT
			if self.waittimer >= self.waittime then
				self.waittimer = 0
				self.movetimer = 0
				
				if self.updmove ~= -1 then
					self.movetime = self.updmove
					self.updmove = -1
				end			
				if self.updwait ~= -1 then
					self.waittime = self.updwait
					self.updwait = -1
				end
				local domove = false
				local normalpath = false
				local seek = false
				local kris = Game.world.player
				
				if self.movetype == 0 then
					normalpath = true
				end
				
				if self.movetype == 1 then
					if kris and MathUtils.dist(self.x + 20, self.y + 20, kris.x, kris.y) <= self.homedist then
						seek = true
					end
					
					if seek == false then
						normalpath = true
					end
				end
				
				if self.movetype == 2 then
					seek = true
					if not kris then
						seek = false
					end
				end	
				
				if self.movetype == 3 then
					domove = true
					Object.startCache()
					self.pathing_collider = Hitbox(self, 20, 20, 40, 40)
					for _, event in ipairs(self.world.stage:getObjects(Event)) do
						if event.pathender and event:collidesWith(self.pathing_collider) then
							self.doom = true
						end
					end
					Object.endCache()
				end

				if self.influenceable then
					Object.startCache()
					local pathturner
					for _, event in ipairs(self.world.stage:getObjects(Event)) do
						self.pathing_collider = Hitbox(self, 20, 20, 40, 40)
						if (event.pathturner) and event:collidesWith(self.pathing_collider) then
							if event.pathturner then
								pathturner = event
							end
						end
					end
					Object.endCache()
					if pathturner and MathUtils.random(0, 1) <= pathturner.chance then
						seek = false
						normalpath = false
						self.dir = pathturner.dir
						domove = true
					end
				end
				if seek then
					normalpath = false
					local krisdir = MathUtils.angle(self.x + 20, self.y + 20, kris.x, kris.y)
					local card = MathUtils.round(math.deg(krisdir) / 90) + 1
					if card > 3 then
						card = 0
					end
					local good = {true,true,true,true}
					if self.failmovecount < self.failmovethresh then
						if self.lastdir == 0 then
							good[3] = false
						end
						if self.lastdir == 2 then
							good[1] = false
						end
						if self.lastdir == 1 then
							good[4] = false
						end
						if self.lastdir == 3 then
							good[2] = false
						end
					end
						
					for i = 1, 4 do
						local px = 0
						local py = 0
						local potcard = card + (i - 1)
						if potcard > 3 then
								potcard = 0
						end
						if potcard == 0 then
							py = 40
						end
						if potcard == 1 then
							px = 40
						end
						if potcard == 2 then
							py = -40
						end
						if potcard == 3 then
							px = -40
						end
						if good[potcard + 1] then
							Object.startCache()
							self.pathing_collider = Hitbox(self, px, py, 40, 40)
							local collided, target = self.world:checkCollision(self.pathing_collider, true)
							Object.endCache()
							if collided then
								good[potcard + 1] = false
							end
						end
					end
						
					if good[card] then
						self.dir = card
						domove = true
					end
						
					if not domove then
						local turnleft = MathUtils.wrap(card - 1, 0, 3)
						local turnright = MathUtils.wrap(card + 1, 0, 3)
						
						if card == 0 then
							turnleft = 3
							turnright = 1
						elseif card == 1 then
							turnleft = 2
							turnright = 0
						elseif card == 2 then
							turnleft = 3
							turnright = 1
						elseif card == 3 then
							turnleft = 0
							turnright = 2
						end
							
						local px = 0
						local py = 0
						if good[turnleft] and not good[turnright] then
							self.dir = turnleft
							domove = true
						end
						if good[turnright] and not good[turnleft] then
							self.dir = turnright
							domove = true
						end
						if good[turnright] and good[turnleft] then
							local leftdist = 0
							local rightdist = 0
							potcard = turnleft
							if potcard == 0 then
								py = 40
							end
							if potcard == 1 then
								px = 40
							end
							if potcard == 2 then
								py = -40
							end
							if potcard == 3 then
								px = -40
							end
							leftdist = MathUtils.dist(self.x + 20 + px, self.y + 20 + py, kris.x, kris.y)
							potcard = turnright
							if potcard == 0 then
								py = 40
							end
							if potcard == 1 then
								px = 40
							end
							if potcard == 2 then
								py = -40
							end
							if potcard == 3 then
								px = -40
							end
							rightdist = MathUtils.dist(self.x + 20 + px, self.y + 20 + py, kris.x, kris.y)
							if leftdist > rightdist then
								self.dir = turnright
								domove = true
							else
								self.dir = turnleft
								domove = true
							end
						end
					end
						
					if not domove then
						failmovecount = self.failmovecount + 1
					end
				end
				if normalpath then
					for i = 1, 4 do
						if domove then goto continue end
						local px = 0
						local py = 0
						if self.dir == 0 then
							py = 40
						end
						if self.dir == 1 then
							px = 40
						end
						if self.dir == 2 then
							py = -40
						end
						if self.dir == 3 then
							px = -40
						end
						Object.startCache()
						self.pathing_collider = Hitbox(self, px, py, 40, 40)
						local collided, target = self.world:checkCollision(self.pathing_collider, true)
						Object.endCache()
						if not collided then
							domove = true
						end
						if not domove then
							if self.prefdir == "left" then
								self.dir = self.dir + 1
							else
								self.dir = self.dir - 1
							end
							if self.dir > 3 then
								self.dir = 0
							end
							if self.dir < 0 then
								self.dir = 3
							end
						end
						::continue::
					end
				end
				if domove then
					self.neutralcon = 1
					self.safex = self.x
					self.safey = self.y
				end
			end
		end
		if self.neutralcon == 1 then
			local px = 0
			local py = 0
			if self.dir == 0 then
				py = 40
				self.angle = 0
			end
			if self.dir == 1 then
				px = 40
				self.angle = math.rad(270)
			end
			if self.dir == 2 then
				py = -40
				self.angle = math.rad(180)
			end
			if self.dir == 3 then
				px = -40
				self.angle = math.rad(90)
			end
			
			self.movetimer = self.movetimer + DTMULT
			local prog = MathUtils.clamp(self.movetimer, 0, self.movetime) / self.movetime
			local pointAx = self.safex
			local pointBx = self.safex + px
			local pointAy = self.safey
			local pointBy = self.safey + py
			if self.movevistype == 0 then
				self.x = MathUtils.lerp(pointAx, pointBx, prog)
				self.y = MathUtils.lerp(pointAy, pointBy, prog)
			end
			if self.movevistype == 1 then
				self.x = MathUtils.lerp(pointAx, pointBx, MathUtils.easeInOutAccurate(prog, 2))
				self.y = MathUtils.lerp(pointAy, pointBy, MathUtils.easeInOutAccurate(prog, 2))
			end
			Object.startCache()
			self.pathing_collider = Hitbox(self, pointBx, pointBy, 40, 40)
			local collided, target = self.world:checkCollision(self.pathing_collider, true)
			Object.endCache()
			if collided and self.movetype ~= 3 then
				self.x = self.safex
				self.y = self.safey
				self.waittimer = 0
				self.movetimer = 0
				self.neutralcon = 0
				self.lastdir = self.dir
				self.failmovecount = self.failmovecount + 1
			end
			if self.movetimer >= self.movetime then
				self.failmovecount = 0
				self.lastdir = self.dir
				self.x = self.safex + px
				self.y = self.safey + py
				self.neutralcon = 0
				
				if self.updmove ~= -1 then
					self.movetime = self.updmove
					self.updmove = -1
				end			
				if self.updwait ~= -1 then
					self.waittime = self.updwait
					self.updwait = -1
				end
			end
		end
		self.sprite:setFrame(math.floor(self.animindex % 3) + 1)
		self.sprite.rotation = math.rad(-self.dir * 90)
	end
end

function PathingEnemy:draw()
	super.draw(self)
	local dodraw = false
    local x, y = self:getScreenPos()
	local margin = 80
    if x > -margin and x < SCREEN_WIDTH + margin and y < SCREEN_HEIGHT + margin and y > -margin then
		dodraw = true
    end
	if self.alpha < 0.1 then
		dodraw = false
	end
	if dodraw then
		self.animindex = self.animindex + 0.25 * DTMULT
		local player = Game.world.player
		local px, py = player:getRelativePos(20, 40)
		local dist = MathUtils.dist(self.x + 20, self.y + 20, px, py)
		local alpha = (1 - (dist / 80)) * self.alpha
		local blend = ColorUtils.mergeColor(COLORS.white, COLORS.red, MathUtils.clamp(alpha, 0, 1))
		local xoff, yoff = 20, 20
		Draw.setColor(1,1,1,self.alpha)
		if dist < 80 then
			local last_shader = love.graphics.getShader()
			local shader = Kristal.Shaders["AddColor"]
			love.graphics.setShader(shader)
			shader:send("inputcolor", COLORS.red)
			shader:send("amount", 1)
			Draw.setColor(1,1,1,alpha)
			Draw.draw(self.sprite.texture, 2 + xoff, yoff, self.sprite.rotation, 1, 1, 20, 20)
			Draw.draw(self.sprite.texture, -2 + xoff, yoff, self.sprite.rotation, 1, 1, 20, 20)
			Draw.draw(self.sprite.texture, xoff, 2 + yoff, self.sprite.rotation, 1, 1, 20, 20)
			Draw.draw(self.sprite.texture, yoff, -2 + yoff, self.sprite.rotation, 1, 1, 20, 20)
			Draw.setColor(1,1,1,alpha * 0.5)
			Draw.draw(self.sprite.texture, 4 + xoff, yoff, self.sprite.rotation, 1, 1, 20, 20)
			Draw.draw(self.sprite.texture, -4 + xoff, yoff, self.sprite.rotation, 1, 1, 20, 20)
			Draw.draw(self.sprite.texture, xoff, 4 + yoff, self.sprite.rotation, 1, 1, 20, 20)
			Draw.draw(self.sprite.texture, xoff, -4 + yoff, self.sprite.rotation, 1, 1, 20, 20)
			love.graphics.setShader(last_shader)
		end
		Draw.setColor(blend[1], blend[2], blend[3], self.alpha)
		Draw.draw(self.sprite.texture, xoff, yoff, self.sprite.rotation, 1, 1, 20, 20)
		Draw.setColor(1,1,1,1)
	end
end

return PathingEnemy