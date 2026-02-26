---@class Map.dark_place : Map
local Map, super = Class(Map, "final-intro")

function Map:init(world, data)
    super.init(self, world, data)
    
end

function Map:onEnter()
    self.world.color = COLORS.black
    Game.world:startCutscene("finale_test.intro")
end

function Map:onExit()
    self.world.color = COLORS.white
end

return Map
