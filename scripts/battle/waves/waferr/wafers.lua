local Wafers, super = Class(Wave)

function Wafers:init()
    super.init(self)

    self.time = 200/30
    self.enemies = self:getAttackers()
	self.sameattack = #self.enemies
	self.ratio = 1
	if #Game.battle.enemies == 2 then
		self.ratio = 1.6
	elseif #Game.battle.enemies == 3 then
		self.ratio = 2.3
	end
end

function Wafers:onStart()
	for sameattacker = 0, #self.enemies-1 do
		local count = sameattacker
		self.timer:script(function(wait)
			while true do
				local x = count % 2 == 0 and Game.battle.arena.left - 120 or Game.battle.arena.right + 120
				local y = Game.battle.arena.y + MathUtils.random(-30, 30)
				if self.sameattack >= 3 then
					y = MathUtils.lerp(Game.battle.arena.top, Game.battle.arena.bottom, sameattacker/(self.sameattack-1))
				end
				local bullet = self:spawnBullet("waferr/wafer", x, y, math.rad(180), 8)
				bullet.alpha = 0
				bullet.physics.direction = count % 2 == 0 and math.rad(0) or math.rad(180)
				bullet.physics.speed = 3.5
				bullet.physics.friction = 0.5
				bullet:fadeTo(1, 10/30)
				wait(10/30)
				local buls_start = 1
				local buls_end = 8
				local target_type = 0
				local not_done_yet = 0
				if #Game.battle.enemies >= 2 then
					if self.sameattack >= 2 then
						buls_start = count % 2 == 0 and 1 or 5
						buls_end = count % 2 == 0 and 4 or 8
						not_done_yet = 1
					end
					target_type = 1
					if self.sameattack < 2 then
						target_type = 2
					end
				end
				if #Game.battle.enemies >= 3 then
					if self.sameattack < 2 then
						buls_start = count % 2 == 0 and 1 or 5
						buls_end = count % 2 == 0 and 4 or 8
						not_done_yet = 1
					end
					if self.sameattack >= 2 then
						if count % 4 == 0 then
							buls_start = 1
							buls_end = 2
						end
						if count % 4 == 1 then
							buls_start = 3
							buls_end = 4
						end
						if count % 4 == 2 then
							buls_start = 5
							buls_end = 6
						end
						if count % 4 == 3 then
							buls_start = 7
							buls_end = 8
						end
						not_done_yet = 2
					end
					if self.sameattack == #Game.battle.enemies then
						buls_start = count % 2 == 0 and 1 or 5
						buls_end = count % 2 == 0 and 4 or 8
						not_done_yet = 1
					end
					target_type = 1
					if self.sameattack < 3 then
						target_type = 2
					end
				end
				for i = buls_start, buls_end do
					local target = (i % 3 == 2 and true or false)
					if target_type == 1 then
						target = (i % 4 == 0 and true or false)
					elseif target_type == 2 then
						target = true
					end
					bullet:splitPiece(i, target)
					wait((self.ratio*2)/30)
				end
				wait((12*self.ratio)/30)
				if not_done_yet == 1 then
					buls_start = count % 2 == 0 and 5 or 1
					buls_end = count % 2 == 0 and 8 or 4
					for i = buls_start, buls_end do
						local target = (i % 3 == 2 and true or false)
						if target_type == 1 then
							target = (i % 4 == 0 and true or false)
						elseif target_type == 2 then
							target = true
						end
						bullet:splitPiece(i, target)
						wait((self.ratio*2)/30)
					end
					wait((12*self.ratio)/30)
				elseif not_done_yet == 2 then
					for i = 1, 3 do
						if count % 4 == (i % 4) then
							buls_start = 1
							buls_end = 2
						end
						if count % 4 == ((i + 1) % 4) then
							buls_start = 3
							buls_end = 4
						end
						if count % 4 == ((i + 2) % 4) then
							buls_start = 5
							buls_end = 6
						end
						if count % 4 == ((i + 3) % 4) then
							buls_start = 7
							buls_end = 8
						end
						for i = buls_start, buls_end do
							local target = (i % 3 == 2 and true or false)
							if target_type == 1 then
								target = (i % 4 == 0 and true or false)
							elseif target_type == 2 then
								target = true
							end
							bullet:splitPiece(i, target)
							wait((self.ratio*2)/30)
						end
						wait((12*self.ratio)/30)
					end
				end
				bullet:remove()
				count = count + 1
			end
		end)
	end
end

function Wafers:update()
    super.update(self)
end

return Wafers