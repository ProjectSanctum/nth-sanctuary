local PrismBattleBackground, super = Class(BattleBackground)

function PrismBattleBackground:init()
    super.init(self)

    self.rainbow_timer = 0
    self.bg_texture = Assets.getTexture("battle/backgrounds/fountainbglooped")
	self.xx = 0
	self.transition_x = SCREEN_WIDTH
	self.shape_timer = 0
    self.particles = {}
	self.particle_tex = Assets.getFramesOrTexture("bullets/cube/cube")
	self.particle_dtmult = 0
	self.transition_end_alpha = 0
	self.siner = 0
end

function PrismBattleBackground:update()
	super.update(self)
	self.siner = self.siner + DTMULT
	self.rainbow_timer = self.rainbow_timer + DTMULT
	if not Kristal.Config["simplifyVFX"] and Game.battle.encounter.is_prism then
		if Game.battle.music.source and Game.battle.music:tell() >= 13.616 and Game.battle.encounter.prism_bg_con == 0 then
			Game.battle.encounter.prism_bg_con = 1
			Game.battle.timer:tween(15/30, self, {transition_x = 0}, "out-cubic")
		end
		if Game.battle.encounter.prism_bg_con == 1 then
			self.shape_timer = self.shape_timer + DT
			if self.shape_timer >= 0.4 then
				table.insert(self.particles, {
					x = MathUtils.random(SCREEN_WIDTH), y = SCREEN_HEIGHT + 40,
					speed = 8 * MathUtils.random(0.5, 2),
					xmove = TableUtils.pick({1, 2, 3, 4}),
					x_last = {-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,
							  -100,-100,-100,-100,-100,-100,-100,-100,-100,-100,
							  -100,-100,-100,-100,-100,-100,-100,-100,-100,-100},
					y_last = {-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,
							  -100,-100,-100,-100,-100,-100,-100,-100,-100,-100,
							  -100,-100,-100,-100,-100,-100,-100,-100,-100,-100},
				})
				self.shape_timer = 0
			end
		end
		if Game.battle.encounter.prism_bg_con == 2 then
			self.transition_end_alpha = 0
			Game.battle.timer:tween(1, self, {transition_end_alpha = 1}, "out-cubic")
			Game.battle.timer:tween(4, self, {transition_x = SCREEN_WIDTH}, "out-cubic")
			Game.battle.encounter.prism_bg_con = 3
		end
		local particle_to_remove = {}
		for _,particle in ipairs(self.particles) do
			if particle.xmove >= 2 then
				if particle.xmove == 3 then
					particle.x = particle.x - math.cos(self.siner/10)*2
				else
					particle.x = particle.x + math.cos(self.siner/10)*2
				end
			else
				if particle.xmove == 1 then
					particle.x = particle.x - math.sin(self.siner/10)*2
				else
					particle.x = particle.x + math.sin(self.siner/10)*2
				end
			end
			particle.y = particle.y - particle.speed * DTMULT
			if self.particle_dtmult >= 1 then
				for i = 30, 2, -1 do
					particle.x_last[i] = particle.x_last[i - 1]
					particle.y_last[i] = particle.y_last[i - 1]
				end
				particle.x_last[1] = particle.x
				particle.y_last[1] = particle.y
			end
			if particle.y <= -SCREEN_HEIGHT then
				table.insert(particle_to_remove, particle)
			end
		end
		for _,particle in ipairs(particle_to_remove) do
			TableUtils.removeValue(self.particles, particle)
		end
		if self.particle_dtmult >= 1 then
			self.particle_dtmult = 0
		end
		self.particle_dtmult = self.particle_dtmult + DTMULT
	end
end

function PrismBattleBackground:drawBackground()
    -- Draw the black background
    love.graphics.setColor(0, 0, 0, self.alpha)
    love.graphics.rectangle("fill", -10, -10, SCREEN_WIDTH + 10, SCREEN_HEIGHT + 10)
	local rr, rg, rb = ColorUtils.HSVToRGB((self.rainbow_timer / 255) % 1, 1, 66 / 255)
	if Game.battle.encounter.is_prism and Game.battle.encounter.prism_bg_con >= 2 then
		rr, rg, rb = ColorUtils.mergeColor({66/255, 66/255, 66/255}, {0, 0, 0}, self.transition_end_alpha)
	end
	if (Game.battle.encounter.is_prism and Game.battle.encounter.prism_bg_con >= 2 and self.transition_end_alpha >= 1) then
		return
	end
    -- Draw the background grid
    local background = Assets.getTexture("ui/battle/background_recolorable")

    love.graphics.setColor(rr, rg, rb, self.alpha / 2)
    Draw.drawWrapped(background, true, true, MathUtils.round(-100 + self.position), MathUtils.round(-100 + self.position))
    love.graphics.setColor(rr, rg, rb, self.alpha)
    Draw.drawWrapped(background, true, true, MathUtils.round(-200 - self.position2), MathUtils.round(-210 - self.position2))
	if not Kristal.Config["simplifyVFX"] and Game.battle.encounter.is_prism then
		rr, rg, rb = ColorUtils.HSVToRGB((self.rainbow_timer / 255) % 1, 233 / 255, 200 / 255)
		if Game.battle.encounter.prism_bg_con >= 2 then
			rr, rg, rb = ColorUtils.mergeColor({1, 1, 1}, {0, 0, 0}, self.transition_end_alpha or 1)
		end
		Draw.setColor(rr, rg, rb, 0.3 * self.alpha)
		self.xx = self.xx + -2
		if self.xx > 600 then
			self.xx = self.xx - 600
		end
		if self.xx < 0 then
			self.xx = self.xx + 600
		end
		for i = 0, 40 do
			local wp = 600 / 40
			Draw.drawPart(self.bg_texture, SCREEN_WIDTH/2 + (wp * i) - 6 + 32 - math.sin(self.rainbow_timer / 20) * 32 + self.transition_x, 0 - (wp * i) / 2, wp * i + self.xx, 0, wp * i, 999, 0, i, i)
			Draw.drawPart(self.bg_texture, SCREEN_WIDTH/2 - (wp * i) + 6 - 32 + math.sin(self.rainbow_timer / 20) * 32 - self.transition_x, 0 - (wp * i) / 2, wp * i + self.xx, 0, wp * i, 999, 0, -i, i)
		end
		for _,particle in ipairs(self.particles) do
			love.graphics.setBlendMode("add")
			for i = 30, 1, -1 do
				if Game.battle.encounter.is_prism and Game.battle.encounter.prism_bg_con >= 2 then
					local col = ColorUtils.mergeColor({1, 1, 1}, {0, 0, 0}, self.transition_end_alpha)
					if i > 25 then
						love.graphics.setColor(ColorUtils.mergeColor(COLORS["black"], col, ((30-i)/5)*self.alpha))
					else
						love.graphics.setColor(col[1]/2, col[2]/2, col[3]/2, self.alpha)
					end
				else
					local ar, ag, ab = ColorUtils.mergeColor(COLORS["gray"], {rr/2, rg/2, rb/2}, i/30)
					if i > 25 then
						love.graphics.setColor(ColorUtils.mergeColor(COLORS["black"], unpack({ar, ag, ab}), ((30-i)/5)*self.alpha))
					else
						love.graphics.setColor(ar, ag, ab, self.alpha)
					end
				end
				love.graphics.draw(self.particle_tex[(math.floor(self.rainbow_timer/4)%6)+1], particle.x_last[i], particle.y_last[i], particle.radius, 1, 1, 0, 0)
			end
			love.graphics.setBlendMode("alpha")
			love.graphics.setColor(1, 1, 1, self.alpha)
			if Game.battle.encounter.prism_bg_con >= 2 then
				love.graphics.setColor(1, 1, 1, (1-self.transition_end_alpha)*self.alpha)
			end
			love.graphics.draw(self.particle_tex[(math.floor(self.rainbow_timer/4)%6)+1], particle.x, particle.y, particle.radius, 1, 1, 0, 0)
		end
	end
end

return PrismBattleBackground