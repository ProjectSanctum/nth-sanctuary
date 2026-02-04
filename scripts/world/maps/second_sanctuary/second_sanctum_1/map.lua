---@class Map.dark_place : Map
local map, super = Class(Map, "secsanctuary/second_sanctum_1")

function map:init(world, data)
    super.init(self, world, data)
    
end

function map:onEnter()
	for _, event in ipairs(self.events) do
		if event.layer == self.layers["objects_parallax"] then
			 event.parallax_x = 0.5
			 event.parallax_y = 0.5
		end
		if event.layer == self.layers["objects_parallax2"] then
			 event.parallax_x = 0.4
			 event.parallax_y = 0.4
		end
	end
end

return map