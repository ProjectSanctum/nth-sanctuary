---@class Map.dark_place : Map
local map, super = Class(Map, "between")

function map:init(world, data)
    super.init(self, world, data)
	self.hell_border_alpha = nil
end

function map:onEnter()
	self.hell_border_alpha = MathUtils.clamp((Game.world.camera.y - SCREEN_HEIGHT/2) / ((self.height * self.tile_height)) * 2, 0, 1)
end

function map:update()
	super.update(self)
	self.hell_border_alpha = MathUtils.clamp((Game.world.camera.y - SCREEN_HEIGHT/2) / ((self.height * self.tile_height)) * 2, 0, 1)
end

return map