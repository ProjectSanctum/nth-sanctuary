local PathingEnemyGenerator, super = Class(Event, "pathenemygen")

function PathingEnemyGenerator:init(data)
    super.init(self, data)
    local properties = data and data.properties or {}
	self.spawnamount = properties["spawnamount"] or 1
	self.timer = properties["timer"] or 0
	self.rate = properties["rate"] or 0
	self.damage = properties["damage"] or 25
	self.waittime = properties["waittime"] or 30
	self.waittimer = properties["waittimer"] or 0
	self.movetime = properties["movetime"] or 30
	self.movetimer = properties["movetimer"] or 0
	self.speed = properties["speed"] or 12
	self.influenceable = properties["influence"] or true
	self.homedistance = properties["homedist"] or 120
	self.movetype = properties["movetype"] or 0
	self.movevistype = properties["movevistype"] or 0
	self.dir = properties["dir"] or 0
	self.prefdir = properties["prefdir"] or "left"
    self.path = properties["path"]
    self.progress = (properties["progress"] or 0) % 1
end

function PathingEnemyGenerator:onAdd(parent)
    super.onAdd(self, parent)

    self:snapToPath()
end

function PathingEnemyGenerator	:snapToPath()
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

                    self.x = x
					self.y = y
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

            self.x = x
			self.y = y
			self.sprite.rotation = angle
        end
    end
end

function PathingEnemyGenerator:getDebugRectangle()
    return {-5, -5, 10, 10}
end

function PathingEnemyGenerator:update()
    super.update(self)
	
	if not Game.world.player:isMovementEnabled() then
		return
	end
	self.timer = self.timer + DTMULT
	if self.spawnamount > 0 then
		if self.timer >= self.rate then
		local bullet = self.world:spawnBullet("pathingenemy", self.x, self.y, {
			damage = self.damage,
			movetype = self.movetype,
			movevistype = self.movevistype,
			dir = self.dir,
			waittime = self.waittimer,
			waittimer = self.waittimer,
			movetime = self.movetime,
			movetimer = self.movetimer,
			speed = self.speed,
			prefdir = self.prefdir,
			influence = self.influenceable,
			homedist = self.homedistance,
			path = self.path,
			progress = self.progress,
		})
		bullet:setLayer(self.layer)
		self.timer = 0
	end
	end
	
end

return PathingEnemyGenerator