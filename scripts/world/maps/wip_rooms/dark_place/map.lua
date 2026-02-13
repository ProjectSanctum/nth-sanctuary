---@class Map.dark_place : Map
local map, super = Class(Map, "dark_place")

function map:init(world, data)
    super.init(self, world, data)
end

function map:onEnter()
    self.world.color = COLORS.black
	self.ripple_fx = RippleEffect()
	self.ripple_fx.layer = WORLD_LAYERS["bottom"]
	Game.world:addChild(self.ripple_fx)
end

function map:onExit()
    self.world.color = COLORS.white
end

---@param char Player
function map:onFootstep(char, num)
    if not char.is_player or num ~= 1 then return end
	Assets.playSound("step1", 1, 0.8)
    local x, y = char:getRelativePos(18/2, 72/2)
	local sizemod = 1
    local running = (Input.down("cancel") or self.force_run) and not self.force_walk
    if Kristal.Config["autoRun"] and not self.force_run and not self.force_walk then
        running = not running
    end

	local px = Game.world.player.moving_x * Game.world.player:getCurrentSpeed(running)
	local py = Game.world.player.moving_y * Game.world.player:getCurrentSpeed(running)
	if Game.world.player.last_collided_x then px = 0 end
	if Game.world.player.last_collided_y then py = 0 end
    self.ripple_fx:makeRipple(x, y, 60, ColorUtils.hexToRGB("#4A91F6"), 220 * sizemod, 1, 18 * sizemod, 1999000, px * 1.05, py * 1.05)
	self.ripple_fx:makeRipple(x, y, 60, ColorUtils.hexToRGB("#4A91F6"), 140 * sizemod, 1, 15 * sizemod, 1999000, px * 1.05, py * 1.05)
end

return map
