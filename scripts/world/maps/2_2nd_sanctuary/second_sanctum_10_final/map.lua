---@class Map.dark_place : Map
local map, super = Class(Map, "second_sanctum_10_final")

function map:init(world, data)
	super.init(self, world, data)
	if Game:getFlag("chase_cutscene_prog") == 1 then
		self.music = "creepychase"
	else
		self.music = "second_church"
	end
end

function map:onEnter()
	super.onEnter(self)	
end

function map:update()
	super.update(self)
end

function map:update()
	super.update(self)

end


return map