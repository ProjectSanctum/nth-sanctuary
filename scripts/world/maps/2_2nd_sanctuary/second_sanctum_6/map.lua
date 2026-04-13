---@class Map.dark_place : Map
local map, super = Class(Map, "second_sanctum_6")

function map:init(world, data)
	super.init(self, world, data)
	self.bookshelf_pos = {}
	self.bookshelf_debris_sprites = {}
end

function map:onEnter()
	for _, shelf in ipairs(Game.world.map:getEvents("bookshelf_destructable")) do
		if shelf then
			table.insert(self.bookshelf_pos, {x = shelf.x, y = shelf.y, layer = shelf.layer, width = shelf.width, height = shelf.height, uid = shelf.unique_id, oid = shelf.object_id, sprite = shelf.texture, setflag = shelf.setflag, setvalue = shelf.setvalue, once = shelf.once})
		end
	end
end

function map:update()
	super.update(self)
	local player = Game.world.player
	for _, piano in ipairs(self:getEvents("remotepianomove")) do
		if piano and piano.engaged then
			if (Game.world.player.x <= 0) or (Game.world.player.x >= self.width * self.tile_width)
			or (Game.world.player.y <= 0) or (Game.world.player.y >= self.height * self.tile_height) then
				self:outOfBoundsFailsafe()
			end
			return
		end
	end
end

function map:outOfBoundsFailsafe()
	if self.bookshelf_pos then
		Assets.playSound("churchbell_short", 0.8, 1)
		Assets.playSound("churchbell_short", 0.8, 0.6)
		Assets.playSound("churchbell_short", 0.8, 0.2)
		Game.world.fader:fadeIn(nil, {color = ColorUtils.hexToRGB("#00b3ea"), speed = 15/30, alpha = 1})
		for _, piano in ipairs(self:getEvents("remotepianomove")) do
			if piano then
				piano:setPosition(piano.init_x, piano.init_y)
				piano:setFlag("last_x", piano.x)
				piano:setFlag("last_y", piano.y)
				piano.camcontrol = false
				piano.camcon = 0
				piano.engaged = false
				piano.show_instructions = false
				piano.ubuff = 0
				piano.dbuff = 0
				piano.lbuff = 0
				piano.rbuff = 0
				piano.xbuff = 0
				piano.zbuff = 0
				piano.timer = 0
				piano.con = 0
			end
		end
		Game.lock_movement = false
		local xx, yy = self:getMarker("spawn")
		Game.world.player:setPosition(xx, yy)
		Game.world.player:resetSprite()
		Game.world.player:setFacing("down")
		Game.world.player.layer = Game.world.map.object_layer
		for _, follower in ipairs(Game.world.followers) do
			follower:setPosition(xx, yy)
			follower:resetSprite()
			follower:setFacing("down")
			follower.layer = Game.world.map.object_layer
		end
		Game.world.player:interpolateFollowers()
		Game.world:attachFollowersImmediate()
		for _, shelf in ipairs(Game.stage:getObjects(BookshelfDestructable)) do
			if shelf then
				shelf:remove()
			end
		end
		if self.bookshelf_debris_sprites then
			for _, debris in ipairs(self.bookshelf_debris_sprites) do
				if debris then
					debris:remove()
					TableUtils.removeValue(self.bookshelf_debris_sprites, debris)
				end
			end
		end
		Assets.playSound("ghostappear", 0.6, 1.4)
		Assets.playSound("ghostappear", 0.6, 0.8)
		Assets.playSound("ghostappear", 0.6, 0.4)
		for i, pos in ipairs(self.bookshelf_pos) do
			local shelf = BookshelfDestructable({x = pos.x, y = pos.y, width = pos.width, height = pos.height, properties = {sprite = pos.sprite, setflag = pos.setflag, setvalue = pos.setvalue, once = pos.once}})
			shelf.layer = pos.layer
			shelf.unique_id = pos.uid
			shelf.object_id = pos.oid
			if shelf.once and shelf:getFlag("used_once", nil) then
				shelf:setFlag("used_once", false)
			end
			Game.world:addChild(shelf)
		end
	end
end

return map