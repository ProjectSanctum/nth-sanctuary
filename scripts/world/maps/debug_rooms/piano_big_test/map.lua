---@class Map.dark_place : Map
local map, super = Class(Map, "big_painotest")

function map:init(world, data)
    super.init(self, world, data)
end

function map:onEnter()
    local bells_1 = Sprite("world/parallax/bells_parallax_01", 0, -80)
    local bells_2 = Sprite("world/parallax/bells_parallax_02", 0, -80)
    local bells_3 = Sprite("world/parallax/bells_parallax_01", 0, -40)
	
    bells_1:setParallax(0.9, 0)
	bells_1:setScale(2,2)
    bells_1.wrap_texture_x = true
    Game.world:addChild(bells_1)
    bells_1:setLayer(Game.world:parseLayer("objects_parallax")+0.02)

    bells_2:setParallax(0.8, 0)
	bells_2:setScale(2,2)
    bells_2.wrap_texture_x = true
    Game.world:addChild(bells_2)
    bells_2:setLayer(Game.world:parseLayer("objects_parallax")+0.01)

    bells_3:setParallax(0.7, 0)
	bells_3:setScale(2,2)
    bells_3.wrap_texture_x = true
	bells_3:setColor(COLORS.gray)
    Game.world:addChild(bells_3)
    bells_3:setLayer(Game.world:parseLayer("objects_parallax"))

	for _, event in ipairs(self.events) do
		if event.layer == self.layers["objects_bell_btm"]
		or event.layer == self.layers["objects_bell"]
		or event.layer == self.layers["objects_bell_top"] then
			event.parallax_x = 0.9
			event:setColor(COLORS.gray)
		end
		if event.tileset then
			local draw_id = event.tileset:getDrawTile(event.tile)
			local info = event.tileset.tile_info[draw_id]
			if info then
				if info.path == "world/objects/bell_single_drum" then
					event:setColor(ColorUtils.hexToRGB("#679CBCFF"))
				elseif info.path == "world/objects/bell_enemy" then
					event:setColor(COLORS.white)
					event.visible = false
				end
			end
		end
	end
end

return map
