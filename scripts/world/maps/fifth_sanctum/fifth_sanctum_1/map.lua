local map, super = Class(Map)

function map:load() --When the map loads....
    super.load(self)
    self.siner = 0 --[i] Required setup variable. 
end

function map:onEnter()
	for _, event in ipairs(self.events) do
		if event.layer == self.layers["objects_parallax"] then
			 event.parallax_x = 0.5
			 event.parallax_y = 0.9
		end
		if event.layer == self.layers["objects_parallax2"] then
			 event.parallax_x = 0.4
			 event.parallax_y = 0.85
		end
		if event.layer == self.layers["objects_parallax3"] then
			 event.parallax_x = 0.3
			 event.parallax_y = 0.82
		end
	end
end

function map:update() --Every time the game updates...
    super.update(self)
   -- self.world.color = {ColorUtils.HSLToRGB(Kristal.getTime()/5 %1, 1, 1)}
end


return map