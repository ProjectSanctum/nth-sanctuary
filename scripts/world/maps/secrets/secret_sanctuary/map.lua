local map, super = Class(Map, "secrets/secret_sanctuary")

function map:init(...)
    super.init(self, ...)
	self.siner = 0

end

function map:onEnter()
	local flag = Game:getFlag("passed_savepoint")
	if flag == true then
		Game.world.map:getEvent(70):remove()
	end
	local angles = {math.rad(0), math.rad(45), math.rad(90), math.rad(135), math.rad(180), math.rad(225), math.rad(270), math.rad(315)}
	for _, event in ipairs(self.events) do
		if event.layer == self.layers["objects_parallax"] then
			event:setOrigin(0.5, 0.5)
			event.x = math.random(100, 400)
			event.y = math.random(150, 200)
			event.rotation = TableUtils.pick(angles)
		end
	end
end

function map:update()
    super.update(self)

end

function map:onExit()
	Game:setFlag("passed_savepoint", true)
end

return map
