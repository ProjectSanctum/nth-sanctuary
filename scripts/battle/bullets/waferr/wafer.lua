local WaferBullet, super = Class(Bullet)

function WaferBullet:init(x, y)
    super.init(self, x, y, "bullets/waferr/wafer_1")
	self.pieces_taken = {false, false, false, false, false, false, false, false}
	self:addFX(OutlineFX(COLORS.black, {thickness = 1, amount = 1}))
end

function WaferBullet:update()
    super.update(self)
end

function WaferBullet:splitPiece(piece, target_soul_directly)
	Assets.stopAndPlaySound("break1", 1, 1.5)
	self.pieces_taken[piece] = true
	local piece_dir = math.rad((piece - 1) * 45)
	local x_pos = self.x + MathUtils.lengthDirX(15, -piece_dir)
	local y_pos = self.y + MathUtils.lengthDirY(15, -piece_dir)
	self.wave:spawnBullet("waferr/wafer_piece", x_pos, y_pos, piece_dir, target_soul_directly)
    for i = 1, 12 do 
		local length = MathUtils.random(0, 30)
		local x_pos = self.x + MathUtils.lengthDirX(length, -piece_dir + math.rad(MathUtils.random(-22, 22)))
		local y_pos = self.y + MathUtils.lengthDirY(length, -piece_dir + math.rad(MathUtils.random(-22, 22)))
		local particle = self.wave:spawnSprite("bullets/waferr/wafer_particle", x_pos, y_pos, self.layer + 0.01)
		particle:setOrigin(0.5, 0.5)
		particle:setScale(1, 1)
		particle:fadeOutSpeedAndRemove(0.1)
        particle.physics.direction = piece_dir + math.rad(MathUtils.random(-10, 10))
		particle.physics.speed = MathUtils.random(1, 2)
    end
end

function WaferBullet:draw()
	love.graphics.stencil(function()
		local last_shader = love.graphics.getShader()
		love.graphics.setShader(Kristal.Shaders["Mask"])
		for i = 0, 7 do
			if self.pieces_taken[i+1] then
				local rot = math.rad(math.floor(i / 2) * 90)
				Draw.draw(Assets.getTexture("bullets/waferr/wafer_"..tostring(i % 2 == 0 and 2 or 3)), 15.5, 15.5, rot, 1, 1, 15.5, 15.5)
			end
		end
		love.graphics.setShader(last_shader)
	end, "replace", 1)
	love.graphics.setStencilTest("less", 1)
	super.draw(self)
	love.graphics.setStencilTest()
end

return WaferBullet