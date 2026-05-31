---@class Map.dark_place : Map
local map, super = Class(Map)

function map:init(world, data)
    super.init(self, world, data)
    
end

function map:update()
	super.update(self)
	-- if Game.world.player.x <= 960 then
		-- self.world:detachFollowers()
		-- Game.world.player.x = Game.world.player.x + 720
		-- for _, follower in ipairs(Game.world.followers) do
			-- follower.detached = true
			-- follower.x = follower.x + 720
		-- end
		-- self.world.player:interpolateFollowers()
		-- self.world:attachFollowers()
	-- end
end

return map
