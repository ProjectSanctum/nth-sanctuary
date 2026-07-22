local map, super = Class(Map, "secrets/secret_sanctuary")

function map:init(...)
    super.init(self, ...)
	self.siner = 0
	self.d = {love.math.random(5, 20), love.math.random(10, 20)}
	self.rand = love.math.random(1,100)
end

function map:onEnter()
	local flag = Game:getFlag("passed_savepoint")

	if flag == true then
		Game.world.map:getEvent(70):remove()
	end
	
	if self.rand == 5 then	
		Game:setFlag("funni_tower_shenanigans", true)
	end

	if self.rand >= 9 and self.rand <= 15 then	
		Game:setFlag("spire_watcher", true)
	else
		Game:setFlag("spire_watcher", false)
	end

	local angles = {math.rad(45), math.rad(90), math.rad(135), math.rad(180), math.rad(225), math.rad(270), math.rad(315), math.rad(360)}
	for _, event in ipairs(self.events) do
			if event.layer == self.layers["objects_parallax"] then
				event:setOrigin(0.5, 0.5)
				event.x = math.random(120, 460)
				event.y = math.random(190, 350)
				event.rotation = TableUtils.pick(angles)
			end
		end
end

function map:update()
    super.update(self)
	local angles = {math.rad(45), math.rad(90), math.rad(135), math.rad(180), math.rad(225), math.rad(270), math.rad(315), math.rad(360)}
	self.siner = self.siner + (DTMULT/30)
	local events = {}
	local stars = {}

	if self.rand == 5 then	
		Game:setFlag("funni_tower_shenanigans", true)
	else
		Game:setFlag("funni_tower_shenanigans", false)
	end

	if (9 <= self.rand) and (self.rand <= 15) then	
		Game:setFlag("spire_watcher", true)
	else
		Game:setFlag("spire_watcher", false)
	end

	for _, event in ipairs(self.events) do
		if event.layer == self.layers["objects_parallax"] then
			table.insert(events, event)
		end
		if event.layer == self.layers["objects_bg"] then
			table.insert(stars, event)
		end
	end
	if Game:getFlag("funni_tower_shenanigans") == true and not Kristal.Config["simplifyVFX"] then
		for _, event in ipairs(self.events) do
			if event.layer == self.layers["objects_parallax"] then
				event:setOrigin(0.5, 0.5)
				event.x = math.random(120, 460)
                event.y = math.random(190, 350)
				event.rotation = TableUtils.pick(angles)
			end
		end
	end
	events[1].x = events[1].x + math.sin(self.d[1]+self.siner)/24
	events[1].y = events[1].y + math.cos(self.d[2]+self.siner)/24

	events[2].x = events[2].x - math.sin(self.d[2]+self.siner)/24
	events[2].y = events[2].y - math.cos(self.d[1]+self.siner)/24

	--stars[1].sprite.alpha = math.sin(self.siner)

end

function map:onExit()
	Game:setFlag("passed_savepoint", true)
	if Game:getFlag("funni_tower_shenanigans") == true then
		Game:setFlag("funni_tower_shenanigans", false)
	end
end

function map:draw()
    super.draw(self)
	if Kristal.Config and Kristal.Config["showFPS"] then
	    love.graphics.setFont(Assets.getFont("main"))
	    local text = tostring(self.rand)
	    local x, y = 4, -4

	    Draw.setColor(0, 0, 0)
	    for ox = -1, 1 do
	        for oy = -1, 1 do
	            if ox ~= 0 or oy ~= 0 then
	                love.graphics.print("ROOM " .. text, x + (ox * 2), y + (oy * 2))
	            end
	        end
	    end

	    Draw.setColor(1, 1, 1)
	    love.graphics.print("ROOM " .. text, x, y)
	end
	Draw.setColor(1, 1, 1, 1)
end

return map
