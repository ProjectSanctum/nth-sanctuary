
local Map, super = Class(Map, "final_1")

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
			 event:addFX(ProphecyShaderFX(0.5), "prop")
		end
		if event.layer == self.layers["objects_shadow"] then
			 event:addFX(ProphecyShaderFX(0.2), "prop")
		end
	end
	self:getTileLayer("tiles_texture"):addFX(ProphecyShaderFX(0.5), "prop")
	local man = Game.world:getCharacter("lobbyman")
	man.flip_x = true
end

return Map
