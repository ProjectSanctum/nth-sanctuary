---@class Map.dark_place : Map
local map, super = Class(Map, "dogcheck/dogcheck")

function map:init(world, data)
    super.init(self, world, data)

end

function map:onEnter()
	local cam = Game.world.camera
	Game.world.timer:tween(0, cam, {zoom_y = 2, zoom_x = 2, ox = -160, oy = 120}, 'linear')
	--_prophecy = instance_create(camerax() + 160, cameray() + 120, 115);
end

return map
