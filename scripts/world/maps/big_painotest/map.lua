---@class Map.dark_place : Map
local map, super = Class(Map, "big_painotest")

function map:init(world, data)
    super.init(self, world, data)
end

function map:onEnter()
    local bells_1 = Sprite("world/parallax/bells_parallax_01", 0, -80)
    local bells_2 = Sprite("world/parallax/bells_parallax_02", 0, -80)
    local bells_3 = Sprite("world/parallax/bells_parallax_01", 0, -40)
	
    bells_1:setParallax(0.9, 0)
	bells_1:setScale(2,2)
    bells_1.wrap_texture_x = true
    Game.world:addChild(bells_1)
    bells_1:setLayer(Game.world:parseLayer("objects_parallax")+0.02)

    bells_2:setParallax(0.8, 0)
	bells_2:setScale(2,2)
    bells_2.wrap_texture_x = true
    Game.world:addChild(bells_2)
    bells_2:setLayer(Game.world:parseLayer("objects_parallax")+0.01)

    bells_3:setParallax(0.7, 0)
	bells_3:setScale(2,2)
    bells_3.wrap_texture_x = true
	bells_3:setColor(COLORS.gray)
    Game.world:addChild(bells_3)
    bells_3:setLayer(Game.world:parseLayer("objects_parallax"))

end

return map