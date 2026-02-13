local Map, super = Class(Map, "pianolighttest")

function Map:init(world, data)
    super.init(self, world, data)
    
end

function Map:onEnter()
	local light = Registry.createLegacyEvent("lightfollowing", {x = Game.world.player.x, y = Game.world.player.y})
	light.target = Game.world.player
	light.x, light.y = Game.world.player:getRelativePos(0, 0)
	if Game.world.player.actor.id == "kris" then
		light.xoff, light.yoff = 18, 38
	elseif Game.world.player.actor.id == "susie" then
		light.xoff, light.yoff = 26, 46
	elseif Game.world.player.actor.id == "ralsei" then
		light.xoff, light.yoff = 18, 40
	else
		light.xoff, light.yoff = Game.world.player.width, Game.world.player.height
	end
	self.world:spawnObject(light)
	for _, follower in ipairs(Game.world.followers) do
		local light = Registry.createLegacyEvent("lightfollowing", {x = follower.x, y = follower.y})
		light.target = follower
		light.x, light.y = follower:getRelativePos(0, 0)
		if follower.actor.id == "kris" then
			light.xoff, light.yoff = 18, 38
		elseif follower.actor.id == "susie" then
			light.xoff, light.yoff = 26, 46
		elseif follower.actor.id == "ralsei" then
			light.xoff, light.yoff = 18, 40
		else
			light.xoff, light.yoff = follower.width, follower.height
		end
		self.world:spawnObject(light)
	end
end

return Map
