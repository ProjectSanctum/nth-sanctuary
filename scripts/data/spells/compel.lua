local spell, super = Class(Spell, "compel")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Compel"
    -- Name displayed when cast (optional)
    self.cast_name = "Compel"

    -- Battle description
    self.effect = "Push ATK\n& power"
    -- Menu description
    self.description = "Per 16% TP, Increase MAGIC by 2 for a selected ally. (16% TP = 1 stack, up to 6)"

    -- TP cost
    self.cost = 16

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"

    -- Tags that apply to this spell
    self.tags = {"buff"}
    self.stacks = 0
end

function spell:getTPCost(chara)
    local cost = super.getTPCost(self, chara)
    self.stacks = math.floor(Game.tension / 16)
    return (Game.battle and cost * self.stacks) or 16
end

function spell:onCast(user, target)
    local stacks = self.stacks
    print("stacks : ", self.stacks)

    Assets.playSound("great_shine", 1, 1.2)
    Assets.playSound("dtrans_twinkle")
    target:flash()

    local afterimage1 = AfterImage(target, 0.5)
    local afterimage2 = AfterImage(target, 0.6)
    afterimage1.physics.speed_x = -2.5
    afterimage2.physics.speed_x = -5
    afterimage1:setLayer(target.layer + 1)
    afterimage2:setLayer(target.layer + 2)
    Game.battle:addChild(afterimage1)
    Game.battle:addChild(afterimage2)
    Game.battle.timer:after(0.5, function()
    target:statusMessage("msg", "compelled")
         target:inflictStatus("compelled", 2, stacks)
     end)
    
end

return spell