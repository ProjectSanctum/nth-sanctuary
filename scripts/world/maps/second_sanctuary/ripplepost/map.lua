---@class Map.dark_place : Map
local map, super = Class(Map, "secsanctuary/ripplepost")

function map:init(world, data)
    super.init(self, world, data)
    
end

function map:onEnter()
    local sa = self.world:getCharacter("noelle")
    if sa and not Game:getFlag("noellefall") then
        sa:setFacing("left")
    end
	for _, event in ipairs(self.events) do
		if event.layer == self.layers["objects_parallax"] then
			 event.parallax_x = 0.5
			 event.parallax_y = 0.9
		end
		if event.layer == self.layers["objects_parallax2"] then
			 event.parallax_x = 0.4
			 event.parallax_y = 0.85
		end
		if event.layer == self.layers["objects_parallax3"] then
			 event.parallax_x = 0.3
			 event.parallax_y = 0.82
		end
	end
end

return map