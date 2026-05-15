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
    self.description = "Per 16% TP, Increase MAGIC by 2 for a selected ally.\n(16% TP = 1 stack, up to 6)"

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
    -- Apply the effect based on the number of stacks
    target:inflictStatus("compelled", 2, stacks)
    
end

return spell