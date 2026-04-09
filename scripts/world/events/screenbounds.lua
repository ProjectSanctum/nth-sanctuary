---@overload fun(...) : ScreenBounds
local ObjectScreenBounds, super = Class(Event, "screenbounds")

function ObjectScreenBounds:init(data)
    super.init(self, data)

    self.solid = false
end

return ObjectScreenBounds