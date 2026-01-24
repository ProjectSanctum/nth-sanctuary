local map, super = Class(Map)

function map:load()
    super.load(self)
    self.siner = 0
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
	end
end

function map:update() --Every time the game updates...
    super.update(self)
end


return map