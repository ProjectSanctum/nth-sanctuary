---@class Map.dark_place : Map
local map, super = Class(Map, "0_base_sanctum/base_east2")

function map:init(world, data)
    super.init(self, world, data)
    
end

function map:onEnter()
	for _, event in ipairs(self.events) do
		if event.layer == self.layers["objects_parallax"] then
			 event.parallax_x = 0.5
			 event.parallax_y = 0.9
		end
	end
end

return map
