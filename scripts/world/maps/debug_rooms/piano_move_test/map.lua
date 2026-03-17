
local Map, super = Class(Map, "piano_move_test")

function Map:init(world, data)
    super.init(self, world, data)
    
end

function Map:onEnter()
    self.world.color = COLORS.white
    
	for _, event in ipairs(self.events) do
		if event.layer == self.layers["objects_towers"] then
			 event:addFX(ProphecyShaderFX(0.2), "prop")
		end
		if event.layer == self.layers["objects_towers2"] then
			 event:addFX(ProphecyShaderFX(0.2), "prop")
		end
		if event.layer == self.layers["objects_towers3"] then
			 event:addFX(ProphecyShaderFX(0.2), "prop")
		end
		if event.layer == self.layers["objects_shadow"] then
			 event:addFX(ProphecyShaderFX(0.2), "prop")
		end
	end
	self:getTileLayer("tiles_texture"):addFX(ProphecyShaderFX(0.5), "prop")
end

return Map
