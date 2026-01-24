local Basic, super = Class(Wave)
function Basic:init()
    super.init(self)
    self.time = 10
    self:setArenaSize(150, 50)
	self.attacks = 0
end

function Basic:onStart()
    -- Every 0.33 seconds...
    self.timer:every(0.5, function()
		self.attacks = self.attacks + 1
		local x = MathUtils.random(Game.battle.arena.left, Game.battle.arena.right)
		if self.attacks % 3 == 0 then
			x = Game.battle.soul.x
		end
        self:spawnBullet("jellycruel/rise_jelly", x, Game.battle.arena.top - 120)
    end)
end

function Basic:update()
    -- Code here gets called every frame

    super.update(self)
end

return Basic