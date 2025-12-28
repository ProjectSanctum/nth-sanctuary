local ThreeDPrism, super = Class(Encounter)

function ThreeDPrism:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    if #Game.party == 1 and Game.party[1].name == "Jamm" then
		self.text = "* Wait, this isn't a Porta Potty."
	else
		self.text = "* Holy fuck\n* ([color:yellow]TP Gain[color:reset] reduced because [color:red]FUCK YOU[color:reset])"
	end

    -- Battle music ("battle" is rude buster)
    self.music = "3d_boss"
    -- Enables the purple grid battle background
    self.background = false

    self.reduced_tension = true
    self.siner = 0
	self.rage_anim_speed = 1
	self.raged = false
	
    -- Add the dummy enemy to the encounter
    self.g = self:addEnemy("3d", 501, 269)

    self.rainbow_timer = 0
    self.bg_texture = Assets.getTexture("battle/backgrounds/fountainbglooped")
	self.xx = 0
	self.transition_x = SCREEN_WIDTH
	self.con = 0
	self.shape_timer = 0
    self.particles = {}
	self.particle_tex = Assets.getFramesOrTexture("bullets/cube/cube")
	self.particle_dtmult = 0
    self.holdbreath = false
	self.transition_end_alpha = 0
	--self.con = 1
	--Game.battle.timer:tween(15/30, self, {transition_x = 0}, "out-cubic")
	--self.g.mercy = 100
	--self.g.health = 1
end

function ThreeDPrism:createSoul(x, y, color)
	local soul = Soul(x, y, color)
	if self.holdbreath then
		soul.speed = 5
	end
    return soul
end

function ThreeDPrism:update()
    self.siner = self.siner + DTMULT
	if self.con <= 2 then
		self.g.y = self.g.y + math.cos(self.siner/10)*2
	end
	if Game.battle.music.source and Game.battle.music:tell() >= 13.616 and self.con == 0 then
		self.con = 1
		Game.battle.timer:tween(15/30, self, {transition_x = 0}, "out-cubic")
	end
	if self.con == 1 then
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
	if self.con == 2 then
		self.transition_end_alpha = 0
		Game.battle.timer:tween(1, self, {transition_end_alpha = 1}, "out-cubic")
		Game.battle.timer:tween(4, self, {transition_x = SCREEN_WIDTH}, "out-cubic")
		self.con = 3
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

function ThreeDPrism:canSwoon(target)
    return Game.battle.encounter.raged
end

function ThreeDPrism:isAutoHealingEnabled(target)
    return not Game.battle.encounter.raged
end

function ThreeDPrism:drawBackground(fade)
	self.rainbow_timer = self.rainbow_timer + DTMULT
    Draw.setColor(0, 0, 0, fade)
    love.graphics.rectangle("fill", -8, -8, SCREEN_WIDTH+16, SCREEN_HEIGHT+16)

    love.graphics.setLineStyle("rough")
    love.graphics.setLineWidth(1)
	local rr, rg, rb = ColorUtils.HSVToRGB((self.rainbow_timer / 255) % 1, 1, 66 / 255)
	if self.con >= 2 then
		rr, rg, rb = ColorUtils.mergeColor({66/255, 66/255, 66/255}, {0, 0, 0}, self.transition_end_alpha)
	end
	if (self.con >= 2 and self.transition_end_alpha >= 1) then
		return
	end
    for i = 2, 16 do
        Draw.setColor(rr, rg, rb, fade / 2)
        love.graphics.line(0, -210 + (i * 50) + math.floor(Game.battle.offset / 2), 640, -210 + (i * 50) + math.floor(Game.battle.offset / 2))
        love.graphics.line(-200 + (i * 50) + math.floor(Game.battle.offset / 2), 0, -200 + (i * 50) + math.floor(Game.battle.offset / 2), 480)
    end

    for i = 3, 16 do
        Draw.setColor(rr, rg, rb, fade)
        love.graphics.line(0, -100 + (i * 50) - math.floor(Game.battle.offset), 640, -100 + (i * 50) - math.floor(Game.battle.offset))
        love.graphics.line(-100 + (i * 50) - math.floor(Game.battle.offset), 0, -100 + (i * 50) - math.floor(Game.battle.offset), 480)
    end
	rr, rg, rb = ColorUtils.HSVToRGB((self.rainbow_timer / 255) % 1, 233 / 255, 200 / 255)
	if self.con >= 2 then
		rr, rg, rb = ColorUtils.mergeColor({1, 1, 1}, {0, 0, 0}, self.transition_end_alpha)
	end
	Draw.setColor(rr, rg, rb, 0.3 * fade)
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
			if self.con >= 2 then
				local col = ColorUtils.mergeColor({1, 1, 1}, {0, 0, 0}, self.transition_end_alpha)
				if i > 25 then
					love.graphics.setColor(ColorUtils.mergeColor(COLORS["black"], col, ((30-i)/5)*fade))
				else
					love.graphics.setColor(col[1]/2, col[2]/2, col[3]/2, fade)
				end
			else
				local ar, ag, ab = ColorUtils.mergeColor(COLORS["gray"], {rr/2, rg/2, rb/2}, i/30)
				if i > 25 then
					love.graphics.setColor(ColorUtils.mergeColor(COLORS["black"], unpack({ar, ag, ab}), ((30-i)/5)*fade))
				else
					love.graphics.setColor(ar, ag, ab, fade)
				end
			end
			love.graphics.draw(self.particle_tex[(math.floor(self.rainbow_timer/4)%6)+1], particle.x_last[i], particle.y_last[i], particle.radius, 1, 1, 0, 0)
		end
		love.graphics.setBlendMode("alpha")
        love.graphics.setColor(1, 1, 1, fade)
		if self.con >= 2 then
			love.graphics.setColor(1, 1, 1, (1-self.transition_end_alpha)*fade)
		end
        love.graphics.draw(self.particle_tex[(math.floor(self.rainbow_timer/4)%6)+1], particle.x, particle.y, particle.radius, 1, 1, 0, 0)
	end
end

return ThreeDPrism