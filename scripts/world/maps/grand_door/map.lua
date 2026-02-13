---@class Map.dark_place : Map
local map, super = Class(Map, "grand_door")

function map:init(world, data)
    super.init(self, world, data)
end

function map:onEnter()
	local finished = Game:getFlag("finished")
	for _, event in ipairs(self.events) do
		if event.layer == self.layers["objects_opendoor"] then
			 event.visible = finished
		end
		if event.layer == self.layers["objects_closeddoor"] then
			 event.visible = not finished
		end
	end
	for _,solid in ipairs(self:getEvents("interactable")) do
		solid.solid = true
		if finished then solid:remove() end
	end
    local bells_1 = Sprite("world/parallax/bells_parallax_golden_01", 0, -85)
    local bells_2 = Sprite("world/parallax/bells_parallax_golden_02", 0, -85)
    local bells_3 = Sprite("world/parallax/bells_parallax_golden_01", 0, -45)
	
    bells_1:setParallax(0.9, 0.9)
	bells_1:setScale(2,2)
    bells_1.wrap_texture_x = true
    Game.world:addChild(bells_1)
    bells_1:setLayer(Game.world:parseLayer("objects_parallax")+0.02)

    bells_2:setParallax(0.8, 0.8)
	bells_2:setScale(2,2)
    bells_2.wrap_texture_x = true
    Game.world:addChild(bells_2)
    bells_2:setLayer(Game.world:parseLayer("objects_parallax")+0.01)

    bells_3:setParallax(0.7, 0.7)
	bells_3:setScale(2,2)
    bells_3.wrap_texture_x = true
	bells_3:setColor(COLORS.gray)
    Game.world:addChild(bells_3)
    bells_3:setLayer(Game.world:parseLayer("objects_parallax"))
	
    self.display = GrandShardDoorDisplay(finished)
    self.display:setLayer(Game.world:parseLayer("objects_top"))
    Game.world:addChild(self.display)
    self.display.x = SCREEN_WIDTH/2
    self.display.y = 180
end

return map
