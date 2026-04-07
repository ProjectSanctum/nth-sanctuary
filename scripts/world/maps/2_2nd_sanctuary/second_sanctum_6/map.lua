---@class Map.dark_place : Map
local map, super = Class(Map, "second_sanctum_6")

function map:onEnter()
	self.bookshelf_pos = {}
	self.bookshelf_debris_sprites = {}
	for _, shelf in ipairs(Game.world.map:getEvents("bookshelf_destructable")) do
		if shelf then
			table.insert(self.bookshelf_pos, {x = shelf.x, y = shelf.y, layer = shelf.layer, width = shelf.width, height = shelf.height, uid = shelf.unique_id, oid = shelf.object_id, sprite = shelf.texture, setflag = shelf.setflag, setvalue = shelf.setvalue, once = shelf.once})
		end
	end
end

return map