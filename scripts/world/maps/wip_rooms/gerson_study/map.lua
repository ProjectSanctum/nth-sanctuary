---@class Map.dark_place : Map
local map, super = Class(Map, "gerson_study")

function map:init(world, data)
    super.init(self, world, data)
end

return map
