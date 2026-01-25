local PathingEnemyGenerator, super = Class(Event, "pathenemygen")

function PathingEnemyGenerator:init(data)
    super.init(self, data)
    local properties = data and data.properties or {}
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

function PathingEnemyGenerator:getDebugRectangle()
    return {-5, -5, 10, 10}
end

function PathingEnemyGenerator:update()
    super.update(self)
	
	if not Game.world.player:isMovementEnabled() then
		return
	end
	self.timer = self.timer + DTMULT
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

return PathingEnemyGenerator