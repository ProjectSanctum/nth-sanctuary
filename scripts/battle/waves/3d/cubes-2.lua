local Basic, super = Class(Wave)

function Basic:init()
    super.init(self)
    self.time = 15
	self.count = 0
end

function Basic:onStart()
    -- Every 0.33 seconds...
    self.spawned = {}
    local arena = Game.battle.arena
    local a, b = arena:getCenter()
	self.timer:everyInstant(2.5, function()
		Assets.playSound("spearappear", 1, 0.8)
		self.count = self.count + 1
		local slower = love.math.random(0, 5)
		local play_sound = true
		if self.count % 2 == 1 then
			for i = 0, 5 do
				if slower == i then
					self.g = self:spawnBullet("3d/trailcube", arena.left-120, arena.top+i*25+5, math.rad(180), -1, 10)
					self.g.physics.speed = 2
					self.g.start_spd = -2
					self.g.start_fric = -0.1
					self.g.sprite:play(1/10, true)
					self.g.sound_pitch = 1.1
					self.g.play_sound = true
				else
					self.g = self:spawnBullet("3d/trailcube", arena.left-120, arena.top+i*25+5, math.rad(180), -1, 15)
					self.g.physics.speed = 3
					self.g.start_spd = -3
					self.g.start_fric = -0.2
					self.g.play_sound = play_sound
					play_sound = false
				end
				self.g.backup = true
				self.g.alpha = 0
				Game.battle.timer:tween(10/30, self.g, {alpha = 1}, "in-cubic")
			end
		else
			for i = 0, 5 do
				if slower == i then
					self.g = self:spawnBullet("3d/trailcube", arena.right+120, arena.bottom-i*25-5, math.rad(180), 1, 10)
					self.g.physics.speed = -2
					self.g.start_spd = 2
					self.g.start_fric = -0.1
					self.g.sprite:play(1/10, true)
					self.g.sound_pitch = 1.1
					self.g.play_sound = true
				else
					self.g = self:spawnBullet("3d/trailcube", arena.right+120, arena.bottom-i*25-5, math.rad(180), 1, 15)
					self.g.physics.speed = -3
					self.g.start_spd = 3
					self.g.start_fric = -0.2
					self.g.play_sound = play_sound
					play_sound = false
				end
				self.g.backup = true
				self.g.alpha = 0
				Game.battle.timer:tween(10/30, self.g, {alpha = 1}, "in-cubic")
			end
		end
	end)
end

function Basic:onEnd()
	Assets.stopSound("3dprism_cubetravel")
end

function Basic:update()
    -- Code here gets called every frame
    super.update(self)
    if self.spawned then
        for i = 1, #self.spawned do
            self.spawned[i].physics.direction = math.rad((i-1)*10)
            self.spawned[i].physics.friction = self.spawned[i].physics.friction-0.1
        end
    end
end

return Basic