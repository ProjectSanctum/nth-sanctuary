---@class Map.dark_place : Map
local map, super = Class(Map, "hell-1")

function map:init(world, data)
    super.init(self, world, data)
	self.riptimer = 119
end

function map:onEnter()
	self.ripple_fx = RippleEffect()
	self.ripple_fx.layer = WORLD_LAYERS["bottom"]
	Game.world:addChild(self.ripple_fx)
end

function map:update(world, data)
	for _,enemy in ipairs(Game.stage:getObjects(ChaserEnemy)) do
		for _,ripplefloor in ipairs(Game.world.map:getEvents("ripplefloor")) do
			if enemy:collidesWith(ripplefloor.collider) and self.riptimer >= 120 then
				local x, y = enemy:getRelativePos(enemy.width/2, enemy.height/2)
				self.ripple_fx:makeRipple(x, y, 60, COLORS.red, 120, 1, 10)
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
		local x, y = char:getRelativePos(18/2, 72/2)
		-- TODO: I couldn't find the right numbers
		local sizemod = 1
		self.ripple_fx:makeRipple(x,y, 60, ColorUtils.hexToRGB("#4A91F6"), 220 * sizemod, 1, 18 * sizemod, 1999000, Game.world.player.moving_x * 1.05, Game.world.player.moving_y * 1.05)
		self.ripple_fx:makeRipple(x,y, 60, ColorUtils.hexToRGB("#4A91F6"), 140 * sizemod, 1, 15 * sizemod, 1999000, Game.world.player.moving_x * 1.05, Game.world.player.moving_y * 1.05)
	end
end

return map