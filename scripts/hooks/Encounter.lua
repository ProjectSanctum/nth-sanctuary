local Encounter, super = HookSystem.hookScript(Encounter)


function Encounter:init()
    super.init(self)
    if StringUtils.contains(Game.world.map.id, "fractured") then
        
        Game.battle:addFX(FracturedHSVFX())
    end
end

function Encounter:createBackground()
    if StringUtils.contains(Game.world.map.id, "fractured") then
        return Game.battle:addChild(FracturedBattleBG())
    end
    return super.createBackground(self)
end

return Encounter