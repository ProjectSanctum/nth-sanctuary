---@class Map.dark_place : Map
local Map, super = Class(Map, "final-1")

function Map:init(world, data)
    super.init(self, world, data)
    
end

function Map:onEnter()
self.world.color = COLORS.white
end

return Map