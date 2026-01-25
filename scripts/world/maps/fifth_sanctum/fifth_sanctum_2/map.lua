---@class Map.dark_place : Map
local map, super = Class(Map, "fifth_sanctum/fifth_sanctum_2")

function map:init(world, data)
    super.init(self, world, data)
    
	self.tspawn_circle_siner = 0
end

function map:onEnter()
	self.ripple_fx = RippleEffect()
	self.ripple_fx.layer = WORLD_LAYERS["above_events"]
	Game.world:addChild(self.ripple_fx)
	for _, event in ipairs(self.events) do
		if event.layer == self.layers["objects_parallax"] then
			 event.parallax_x = 0.5
			 event.parallax_y = 0.9
		end
	end
end

function map:update()
	super.update(self)
	if Game.world.player and Game.world.player.tspawn_circle_light then
		self.tspawn_circle_siner = self.tspawn_circle_siner + DTMULT
	end
end

return map