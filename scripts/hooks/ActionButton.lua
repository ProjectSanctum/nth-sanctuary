---@class ActionButton : Object
---@overload fun(...) : ActionButton
local ActionButton, super = HookSystem.hookScript(ActionButton)

function ActionButton:init(type, battler, x, y)
    super.init(self, type, battler, x, y)
    self.type = type
    self.battler = battler
    if self.type == "spare" and battler.chara:checkArmor("doctrine_veil") then
        self.disabled = true
    end
end

return ActionButton