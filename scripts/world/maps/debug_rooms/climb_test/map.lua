local map, super = Class(Map, "debug_rooms/climb_test")

function map:onEnter()

	self.destructableblockpos = {}
	for _, climb in ipairs(Game.world.map:getEvents("destructableclimbarea")) do
		if climb then
			table.insert(self.destructableblockpos, {x = climb.x, y = climb.y, layer = climb.layer, width = climb.width, height = climb.height, sprite = climb.sprite, danger = climb.dangerous, dangertime = climb.dangertime})
			climb:remove()
		end
	end
end

return map