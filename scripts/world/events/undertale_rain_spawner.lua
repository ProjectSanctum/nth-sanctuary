local UndertaleRainSpawner, super = Class(Event, "undertale_rain_spawner")

function UndertaleRainSpawner:init(data)
    super.init(self, data)
    local properties = data and data.properties or {}
    
	self.timer = 0
	self.debug_select = false
	self.spawn_rate = properties["spawn_rate"] or 1 -- drops per second
end

function UndertaleRainSpawner:update()
    super.update(self)
	
	if self.timer >= 1 / self.spawn_rate then
		local drop = RainSprite("effects/statuedrop", MathUtils.random(0, Game.world.map.width * Game.world.map.tile_width), 0 - MathUtils.random(50) - 70)
		drop.layer = self.layer
		drop:setScale(2,2)
		drop.physics.speed_y = 4 + MathUtils.random(2)
		drop.physics.gravity = 0.4
		Game.world:addChild(drop)
		self.timer = 0
	end
	self.timer = self.timer + DTMULT
end

return UndertaleRainSpawner