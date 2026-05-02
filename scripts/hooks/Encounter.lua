local Encounter, super = HookSystem.hookScript(Encounter)

function Encounter:init()
    super.init(self)
	self.frac_hsv_fx = FracturedHSVFX()
end

function Encounter:onBattleInit()
    if StringUtils.contains(Game.world.map.id, "fractured") then
		for _, battler in ipairs(Game.battle.party) do
			battler:addFX(self.frac_hsv_fx)
		end
		for _, battler in ipairs(Game.battle.enemies) do
			battler:addFX(self.frac_hsv_fx)
		end
	end
    super.onBattleInit(self)
end

function Encounter:createBackground()
    if StringUtils.contains(Game.world.map.id, "fractured") then
		local frac_bg = FracturedBattleBG()
        frac_bg:addFX(self.frac_hsv_fx)
        return Game.battle:addChild(frac_bg)
    end
    return super.createBackground(self)
end

function Encounter:update()
    super.update(self)
end

return Encounter