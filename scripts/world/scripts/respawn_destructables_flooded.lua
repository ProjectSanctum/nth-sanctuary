return function(script)
	local map = Game.world.map or nil
	if map and map.destructableblockpos then
		for _, climb in ipairs(Game.stage:getObjects(DestructableClimbArea)) do
			if climb then
				climb:remove()
			end
		end
		for i, pos in ipairs(map.destructableblockpos) do
			local climb = DestructableClimbArea({x = pos.x, y = pos.y, width = pos.width, height = pos.height, properties = {sprite = pos.sprite, dangerous = pos.danger, dangertime = pos.dangertime}})
			climb.alpha = 0
			climb.layer = pos.layer
			Game.world:addChild(climb)
			local lifetime = (i - 1) + 4
			Game.world.timer:lerpVar(climb, "alpha", climb.alpha, 1, lifetime, -1, "out")
			climb.color_mask = climb:addFX(ColorMaskFX(ColorUtils.hexToRGB("#00b3ea")))
			Game.world.timer:lerpVar(climb.color_mask, "amount", 1, 0, lifetime, 2, "out")
			Game.world.timer:tween(lifetime/30, climb.color_mask, {color = COLORS.white}, "linear")
			Game.world.timer:after(lifetime/30, function()
				climb:removeFX(climb.color_mask)
			end)
		end
	end
end