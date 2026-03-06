local PathingEnemySpawnNum, super = Class(Event, "pathenemynum")

function PathingEnemySpawnNum:init(data)
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
	local world = Game.world
	
	if self.spawnamount > 0 then
		for i=1, self.spawnamount do
			local bullet = world:spawnBullet("pathingenemy", self.x, self.y, {
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
				progress = (i-1)/self.spawnamount,
			})
			bullet:setLayer(self.layer)
		end
	end
end

return PathingEnemySpawnNum