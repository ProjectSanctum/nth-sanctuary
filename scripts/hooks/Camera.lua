---@class Camera : Camera
---@field tower CylinderTower
local Camera, super = HookSystem.hookScript(Camera)
---@cast super Camera

function Camera:init(parent, x, y, width, height, keep_in_bounds)
    super.init(self, parent, x, y, width, height, keep_in_bounds)
    self.climb = CameraClimbStateNew(self)
    self.state_manager:addState("CLIMB", self.climb)
end

return Camera
