---@class Map.dark_place : Map
local map, super = Class(Map, "gerson_study")

function map:init(world, data)
    super.init(self, world, data)
end

function map:onEnter()
	if Game:getFlag("enteredGersonStudy", false) then
		local susie = Game.world:getCharacter("susie")
		if susie then
			susie:setSprite("walk_unhappy")
		end
	end
end

return map
