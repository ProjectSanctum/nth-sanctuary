---@class Map.dark_place : Map
local map, super = Class(Map, "second_sanctum_5")

function map:onEnter()
	self.world.camera:setBounds(0, 0, 30 * self.tile_width, self.height * self.tile_height)
	if self.world.player.y >= ((self.height * self.tile_height) / 2) then
		self.cyltower.tower_angle = 278.59
	end
	self.cyltower:update()
end

function map:onExit()
	self.world.camera:setBounds()
end

return map