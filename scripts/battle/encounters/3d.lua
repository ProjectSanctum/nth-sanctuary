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

    self.reduced_tension = true
    self.siner = 0
	self.rage_anim_speed = 1
	self.raged = false
	
    -- Add the dummy enemy to the encounter
    self.g = self:addEnemy("3d", 501, 269)

	self.prism_bg_con = 0
    self.holdbreath = false
	self.is_prism = true
	--self.con = 1
	--Game.battle.timer:tween(15/30, self, {transition_x = 0}, "out-cubic")
	--self.g.mercy = 100
	--self.g.health = 1
end

function ThreeDPrism:createBackground()
    return Game.battle:addChild(PrismBattleBackground())
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
	if self.prism_bg_con <= 2 then
		self.g.y = self.g.y + math.cos(self.siner/10)*2
	end
end

function ThreeDPrism:canSwoon(target)
    return Game.battle.encounter.raged
end

function ThreeDPrism:isAutoHealingEnabled(target)
    return not Game.battle.encounter.raged
end

return ThreeDPrism