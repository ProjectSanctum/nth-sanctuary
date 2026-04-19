---@class Soul : Object
local Soul, super = HookSystem.hookScript(Soul)

function Soul:init(x, y, color)
    super.init(self, x, y, color)
    if Game.battle.party[1].chara.id == "noelle" then
        self:setColor(1, 1, 1)
        self.sprite:setSprite("player/n_heart_sq")
        self.graze_sprite.texture = Assets.getTexture("player/n_graze")
    end

    if Game.battle and Game.battle:getFX(FracturedHSVFX) then
        self:addFX(FracturedHSVFXRevert())
    end
end

return Soul