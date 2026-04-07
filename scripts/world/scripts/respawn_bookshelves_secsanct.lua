return function(script)
	local map = Game.world.map or nil
	if map and map.bookshelf_pos then
		for _, piano in ipairs(Game.world.map:getEvents("remotepianomove")) do
			if piano then
				piano:setPosition(piano.init_x, piano.init_y)
				piano:setFlag("last_x", piano.x)
				piano:setFlag("last_y", piano.y)
				piano.alpha = 0
				Game.world.timer:lerpVar(piano, "alpha", piano.alpha, 1, 4, -1, "out")
				piano.color_mask = piano:addFX(ColorMaskFX(ColorUtils.hexToRGB("#00b3ea")))
				Game.world.timer:lerpVar(piano.color_mask, "amount", 1, 0, 4, 2, "out")
				Game.world.timer:tween(4/30, piano.color_mask, {color = COLORS.white}, "linear")
				Game.world.timer:after(4/30, function()
					piano:removeFX(piano.color_mask)
				end)
			end
		end
		for _, shelf in ipairs(Game.stage:getObjects(BookshelfDestructable)) do
			if shelf then
				shelf:remove()
			end
		end
		if map.bookshelf_debris_sprites then
			for _, debris in ipairs(map.bookshelf_debris_sprites) do
				if debris then
					debris:remove()
				end
			end
		end
		Assets.playSound("ghostappear", 0.6, 1.4)
		Assets.playSound("ghostappear", 0.6, 0.8)
		for i, pos in ipairs(map.bookshelf_pos) do
			local shelf = BookshelfDestructable({x = pos.x, y = pos.y, width = pos.width, height = pos.height, properties = {sprite = pos.sprite, setflag = pos.setflag, setvalue = pos.setvalue, once = pos.once}})
			shelf.alpha = 0
			shelf.layer = pos.layer
			shelf.unique_id = pos.uid
			shelf.object_id = pos.oid
			if shelf.once and shelf:getFlag("used_once", nil) then
				shelf:setFlag("used_once", false)
			end
			Game.world:addChild(shelf)
			local lifetime = (i - 1) + 4
			Game.world.timer:lerpVar(shelf, "alpha", shelf.alpha, 1, lifetime, -1, "out")
			shelf.color_mask = shelf:addFX(ColorMaskFX(ColorUtils.hexToRGB("#00b3ea")))
			Game.world.timer:lerpVar(shelf.color_mask, "amount", 1, 0, lifetime, 2, "out")
			Game.world.timer:tween(lifetime/30, shelf.color_mask, {color = COLORS.white}, "linear")
			Game.world.timer:after(lifetime/30, function()
				shelf:removeFX(shelf.color_mask)
			end)
		end
	end
end