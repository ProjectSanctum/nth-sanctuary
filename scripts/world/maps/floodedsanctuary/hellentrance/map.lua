---@class Map.dark_place : Map
local map, super = Class(Map, "hellentrance")

function map:init(world, data)
    super.init(self, world, data)
	self.riptimer = 119
end

function map:onEnter()
	Game.world.map:getTileLayer("Basin").visible = false
	Game.world.map:getTileLayer("BasinBottom").visible = false
end

function map:update(world, data)
	for _,enemy in ipairs(Game.stage:getObjects(ChaserEnemy)) do
		for _,ripplefloor in ipairs(Game.world.map:getEvents("ripplefloor")) do
			if enemy:collidesWith(ripplefloor.collider) and self.riptimer >= 120 then
				local effect = RippleEffect(enemy, COLORS.red)
				local x, y = enemy:getRelativePos(enemy.width/2, enemy.height/2)
				RippleEffect:MakeRipple(x, y, 60, COLORS.red, 120, 1, 10)
				self.riptimer = 0
			end
		end
	end
	self.riptimer = self.riptimer + 1 * DTMULT
end

---@param char Player
function map:onFootstep(char, num)
    if not char.is_player then return end
	local make_steps = false
	for _,ripplefloor in ipairs(Game.world.map:getEvents("ripplefloor")) do
		if Game.world.player:collidesWith(ripplefloor.collider) then
			make_steps = true
		end
	end
	if make_steps then
		Assets.playSound("step1", 1, 0.8)
		---@type RippleEffect
		local effect = RippleEffect(char, {Game.party[1]:getColor()})
		local x, y = char:getRelativePos(18/2, 72/2)
		-- TODO: I couldn't find the right numbers
		if Input.down("cancel") then
			RippleEffect:MakeRipple(x,y, 60, {74/255, 145/255, 246/255}, 192, 1, 15):applySpeedFrom(char, 0.75)
		else
			-- RippleEffect:MakeRipple(x,y, 30, nil, 192/2, 1, 8):applySpeedFrom(char, 0.75)
			-- RippleEffect:MakeRipple(x,y, 30, nil, 192/3, 1, 8):applySpeedFrom(char, 0.75)
			self.world:addChild(RippleEffect(x, y, 30, 192/2, 8, {74/255, 145/255, 246/255})):applySpeedFrom(char, 0.75)
			self.world:addChild(RippleEffect(x, y, 30, 192/3, 8, {74/255, 145/255, 246/255})):applySpeedFrom(char, 0.75)
		end
	end
end

return map