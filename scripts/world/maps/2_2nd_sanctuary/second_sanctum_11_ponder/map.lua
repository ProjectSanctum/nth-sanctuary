---@class Map.dark_place : Map
local map, super = Class(Map)

function map:onEnter()
    super.onEnter(self)
	for _, follower in ipairs(Game.world.followers) do
		follower:remove()
	end
end

return map