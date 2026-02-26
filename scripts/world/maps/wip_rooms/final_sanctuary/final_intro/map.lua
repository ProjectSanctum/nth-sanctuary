---@class Map.dark_place : Map
local Map, super = Class(Map, "final-intro")

function Map:init(world, data)
    super.init(self, world, data)
    
end

function Map:onEnter()
    self.world.color = COLORS.black
    if Game.world.cutscene then
        Game.world.cutscene:gotoCutscene("finale_test.intro")
    end
end

function Map:onExit()
    self.world.color = COLORS.white
end

return Map
