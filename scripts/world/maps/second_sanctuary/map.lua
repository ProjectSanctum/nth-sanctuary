---@class Map.dark_place : Map
local map, super = Class(Map, "secsanctuary")

function map:init(world, data)
    super.init(self, world, data)
    
end

function map:onEnter()
    local sa = self.world:getCharacter("noelle")
    if sa and not Game:getFlag("noellefall") then
        sa:setFacing("left")
    end
end

return map