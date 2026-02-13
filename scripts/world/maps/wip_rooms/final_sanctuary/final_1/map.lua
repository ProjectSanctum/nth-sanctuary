
local Map, super = Class(Map, "final-1")

function Map:init(world, data)
    super.init(self, world, data)
    
end

function Map:onEnter()
    self.world.color = COLORS.white
    Game.world:spawnObject(BaseSanctumBG(), self.layers["objects_towers"]-0.1)
	for _, event in ipairs(self.events) do
		if event.layer == self.layers["objects_towers"] then
			 event.parallax_x = 0.5
			 event.parallax_y = 0.9 
		end
	end
end

return Map
