---@class CameraClimbStateNew: StateClass
local CameraClimbStateNew, super = Class(StateClass, "CameraClimbStateNew")

---@param camera Camera
function CameraClimbStateNew:init(camera)
    super.init(self)
    self.camera = camera
end

function CameraClimbStateNew:registerEvents(master)
    self:registerEvent("update", self.update)
end

function CameraClimbStateNew:update()
    local cameralerpspeed = 0.16
    -- TODO: Support overriding lerpstrength like how
    -- gml_Object_obj_climb_kris_Step_0:1506 responds to obj_camera_nudger
    local tx, ty = self.camera:getTargetPosition()
    local cx, cy = self.camera:getPosition()

	if Game.world.player.onrotatingtower then
		if Game.world.map.cyltower.horizontal then
			self.camera.x = MathUtils.roundToMultiple(MathUtils.lerp(cx, tx, cameralerpspeed * DTMULT), 2)
		else
			self.camera.y = MathUtils.roundToMultiple(MathUtils.lerp(cy, ty, cameralerpspeed * DTMULT), 2)
		end
	else
		self.camera:setPosition(
			MathUtils.roundToMultiple(MathUtils.lerp(cx, tx, cameralerpspeed * DTMULT), 2),
			MathUtils.roundToMultiple(MathUtils.lerp(cy, ty, cameralerpspeed * DTMULT), 2)
		)
	end
end

return CameraClimbStateNew
