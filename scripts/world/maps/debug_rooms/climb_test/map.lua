local map, super = Class(Map, "debug_rooms/climb_test")

function map:onEnter()

	self.destructableblockpos = {}
	for _, climb in ipairs(Game.world.map:getEvents("fallingclimbarea")) do
		if climb then
			table.insert(self.destructableblockpos, {x = climb.x, y = climb.y, layer = climb.layer, shape = climb.shape, data = climb.data, 
			dont_break = climb.dont_break, breaks_on_leave = climb.breaks_on_leave, fall_time = climb.fall_time,
			timed = climb.timed, no_unsafe_area = climb.no_unsafe_area})
			climb:remove()
		end
	end
end

return map