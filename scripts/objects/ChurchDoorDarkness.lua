local ChurchDoorDarkness, super = Class(Sprite)

function ChurchDoorDarkness:init(x, y)
    super.init(self, "world/objects/church_door_darkness", x, y)
	
	self.timer = 0
	self:setScale(2)
end

function ChurchDoorDarkness:update()
    super.update(self)
	
	if self.frame > 1 then
		local ballregionl = 290
		local ballregionr = 300
		local bally = 265
		local timer_speed = 2
		if self.frame == 3 then
			ballregionl = 280
			ballregionr = 310
			bally = 265
			timer_speed = 0.5	
		end
		self.timer = self.timer + DTMULT
		if self.timer >= timer_speed then
			self.timer = 0
			local ball = Sprite("effects/ball", MathUtils.random(ballregionl * 2, ballregionr * 2), bally * 2)
			ball:setColor(COLORS.black)
			Game.world.timer:after(1, function()
				ball:remove()
			end)
			local randomscale = 0.3 + MathUtils.random(0.1)
			ball:setScale(0)
			ball.alpha = 0.4
			Game.world.timer:tween(10/30, ball, {scale_x = randomscale * 2, scale_y = randomscale * 2}, "out-back")
			Game.world.timer:tween(60/30, ball, {alpha = 0})
			ball:setLayer(self.layer + 0.1)
			ball.physics.gravity_direction = -math.pi / 2
			ball.physics.gravity = 0.4
			ball.physics.friction = 0.2
			ball.physics.speed_x = MathUtils.random(-6, 6)
			Game.world:addChild(ball)
		end
	end
end

return ChurchDoorDarkness