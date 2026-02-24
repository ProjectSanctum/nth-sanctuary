---@class Actor.kris : Actor
local actor, super = Class("kris", true)

function actor:init()
    super.init(self)
    TableUtils.merge(self.animations, {
        ["pirouette"] = {"battle/pirouette", 3/30, true},
        ["fall_hurt"] = {"fall_hurt", 0, true},
        ["fall_hurt_wind"] = {"fall_hurt_wind", 1/5, true},
    })
    TableUtils.merge(self.offsets, {
        -- TODO: Accuracy.
        ["climb/climb"] = {-5, 4},
        ["climb/charge"] = {-5, 7},
        ["climb/slip_left"] = {-5, 4},
        ["climb/slip_right"] = {-5, 4},
        ["climb/slip_fall"] = {-5, 4},
        ["climb/land_left"] = {-5, 4},
        ["climb/land_right"] = {-5, 4},
        ["climb/jump_up"] = {-5, 4},
        ["climb/jump_left"] = {-5, 4},
        ["climb/jump_right"] = {-5, 4},
        ["slide"] = {-5, -2},
        ["piano"] = {-6, -1},
    })
end

return actor