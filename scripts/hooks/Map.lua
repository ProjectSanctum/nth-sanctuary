local Map, super = Class("Map", true)

function Map:onExit()
	super.onExit(self)
	if Game.world.map.id and 
	Game.world.map.id ~= "fast_travel" and 
	Game.world.map.id ~= "grand_door" and 
	Game.world.map.id ~= "citadel_room" and
	Game.world.map.id ~= "citadel_room2" and
	Game.world.map.id ~= "Map" then
		Game:setFlag("ft_last_map", Game.world.map.id)
	end
end

function Map:load()
	super.load(self)
	if DISCORD_RPC_AVAILABLE and Kristal.Config["discordRPC"] then
        local presence = Kristal.getPresence()
		print(Game.world.map.name)
        presence.state = "Map: "..(Game.world.map.name or "???")
        presence.details = "Shards: "..tostring(Mod:getDarkShardCount() or 0)
        Kristal.setPresence(presence)
    end
	if Kristal.Config["simplifyVFX"] then
		for _, value in ipairs(Game.world.stage:getObjects(TileObject)) do
			if value.light_area and value.light_dust then
				value.light_dust = false
			end
		end
		for e, value in ipairs(self.events_by_name.window_glow or {}) do
			value.glows = 1
		end
		for e, value in ipairs(self.events_by_name.eye_glow or {}) do
			value.glows = 1
		end
		for e, value in ipairs(self.events_by_name.darkness or {}) do
			if value.alpha <= 0.2 then
				value:remove()
			end
		end
	end
	if Kristal.Config["nthSanctuary/removeHSV"] then
		for _, h in ipairs(TableUtils.mergeMany(
			self.events_by_name.filter or {},
			self.events_by_name.tile_oscillate or {},
			self.events_by_name.texturescroller or {},
			self.events_by_name.churchfog or {}
		) or {}) do
			h:remove()
		end
	end
end

return Map
