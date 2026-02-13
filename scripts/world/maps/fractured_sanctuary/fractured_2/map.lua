local map, super = Class(Map)

function map:load() --When the map loads....
    super.load(self)
	for _, event in ipairs(self.events_by_name["window_glow"]) do
		event.scale_y = -1
	end
end

return map