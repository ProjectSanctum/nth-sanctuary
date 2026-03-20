---@class Actor.kris : Actor
local actor, super = Class("ralsei", true)

function actor:init()
    super.init(self)
    TableUtils.merge(self.animations, {
        ["pirouette"] = {"battle/pirouette", 3/30, true}
    })
    TableUtils.merge(self.offsets, {
        ["pirouette"] = {-3, -5},
        ["shocked_left_landed"] = {-7, 4},
        ["shocked_right_landed"] = {-7, 4},
    })
end

return actor