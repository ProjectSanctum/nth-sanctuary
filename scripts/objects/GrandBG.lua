local GrandBG, super = Class(BattleBackground)

function GrandBG:init()
    super.init(self)

	self.shader = Assets.getShader("prophecy")
    self.texture_1 = Assets.getTexture("backgrounds/IMAGE_DEPTH_EXTEND_MONO_SEAMLESS_POW2")
    self.texture_2 = Assets.getTexture("backgrounds/perlin_noise_looping")
    self.shader:send("sampler_1", self.texture_1)
    self.shader:send("sampler_2", self.texture_2)
	self.col = color or {0.2588, 0.8157, 1}
    self.highlight = ColorUtils.hexToRGB("#42D0FFFF")
    self.darkcol = ColorUtils.hexToRGB("#404040FF")
	for _, chara in ipairs(Game.battle.party) do
		if chara and not chara.no_highlight then
			chara.sprite:addFX(ChurchHighlightFX(0, self.highlight, {darkcol = self.darkcol}, 1), "highlight")
		end
	end
	for _, chara in ipairs(Game.battle.enemies) do
		if chara and not chara.no_highlight then
			chara.sprite:addFX(ChurchHighlightFX(0, self.highlight, {darkcol = self.darkcol}, 1), "highlight")
		end
	end
end

function GrandBG:update()
	super.update(self)
	for _, chara in ipairs(Game.battle.party) do
		if chara and not chara.no_highlight then
			chara.sprite:getFX("highlight").alpha = self.alpha
		end
	end
	for _, chara in ipairs(Game.battle.enemies) do
		if chara and not chara.no_highlight then
			chara.sprite:getFX("highlight").alpha = self.alpha
		end
	end
end

function GrandBG:drawBackground()
    -- Draw the black background
    Draw.setColor(0, 0, 0, self.alpha)
    love.graphics.rectangle("fill", -10, -10, SCREEN_WIDTH + 20, SCREEN_HEIGHT + 20)

    -- Draw the background grid
	love.graphics.setBlendMode("add")
    local background = Assets.getTexture("ui/battle/background_recolorable")
    local gradient = Assets.getTexture("world/parallax/spr_dw_castle_gradient")
    local last_shader = love.graphics.getShader()
    love.graphics.setShader(self.shader)
    self.shader:send("time", Kristal.getTime() * 15)
    self.shader:send("opacity", 1)
	self.shader:send("camx", 0)
	self.shader:send("camy", 0)
    self.shader:sendColor("col", self.col)
    Draw.setColor(1, 1, 1, self.alpha / 12)
    Draw.drawWrapped(gradient, false, true, 0, 900, math.rad(-90))
    self.shader:send("time", Kristal.getTime() * 4.5)
    Draw.setColor(1, 1, 1, self.alpha / 16)
    for i = -1, 1 do
        for j = -1, 1 do
            if i ~= 0 or j ~= 0 then
				Draw.drawWrapped(background, true, true, MathUtils.round(-100 + self.position + i), MathUtils.round(-100 + self.position + j))
            end
        end
    end
    Draw.setColor(1, 1, 1, self.alpha / 8)
    Draw.drawWrapped(background, true, true, MathUtils.round(-100 + self.position), MathUtils.round(-100 + self.position))
    Draw.drawWrapped(background, true, true, MathUtils.round(-100 + self.position), MathUtils.round(-100 + self.position))
    self.shader:send("time", -Kristal.getTime() * 7)
    Draw.setColor(1, 1, 1, self.alpha / 12)
    for i = -1, 1 do
        for j = -1, 1 do
            if i ~= 0 or j ~= 0 then
				Draw.drawWrapped(background, true, true, MathUtils.round(-200 - self.position2 + i), MathUtils.round(-210 - self.position2 + j))
            end
        end
    end
	Draw.setColor(1, 1, 1, self.alpha / 4)
    Draw.drawWrapped(background, true, true, MathUtils.round(-200 - self.position2), MathUtils.round(-210 - self.position2))
    Draw.drawWrapped(background, true, true, MathUtils.round(-200 - self.position2), MathUtils.round(-210 - self.position2))
    love.graphics.setShader(last_shader)
	love.graphics.setBlendMode("alpha")
end

return GrandBG