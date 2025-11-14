return function(script)
	script:remove()
	local bell_drum = nil
	local bell_enemy = nil
	local bell_x, bell_y = 0, 0
	for _, event in ipairs(Game.world.map.events) do
		if event.tileset then
			local draw_id = event.tileset:getDrawTile(event.tile)
			local info = event.tileset.tile_info[draw_id]
			if info then
				if info.path == "world/objects/bell_single_drum" then
					bell_drum = event
				elseif info.path == "world/objects/bell_enemy" then
					bell_x = event.x * 1.1 + 11
					bell_y = event.y
				end
			end
		end
	end
	bell_enemy = WicabelChaser(bell_x, bell_y)
	bell_enemy.no_highlight = true
	bell_enemy:setLayer(Game.world.map.layers["objects_bell"])
	local mask = bell_enemy:addFX(AlphaFX(0), "alpha")
	Game.world:addChild(bell_enemy)
	Game.world.timer:script(function(wait)
		wait(1/30)
		Game.world.timer:tween(8/30, bell_drum, {alpha = 0}, "linear")
		wait(8/30)
		bell_drum:remove()
		local movetime = 24
		local delaytime = 8
		if Game:getFlag("bigpiano_wicabel") ~= true then
			movetime = 16
			delaytime = 6
		end
		Assets.playSound("churchbell_short")
		Game.world.timer:tween(3/30, mask, {alpha = 1}, "linear")
		Game.world.timer:tween(3/30, bell_enemy, {scale_y = 2}, "linear")
		Game.world.timer:lerpVar(bell_enemy, "y", bell_enemy.y, 250, movetime, -1, "out")
		wait((movetime+delaytime)/30)
		bell_enemy.con = 1
	end)
end
