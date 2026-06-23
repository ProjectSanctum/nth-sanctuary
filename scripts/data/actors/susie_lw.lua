---@class Actor.kris : Actor
local actor, super = Class("susie_lw", true)

function actor:init()
    super.init(self)
    TableUtils.merge(self.animations, {
        ["rain_windblow"] = {"rain_windblow", 4.5/30, true},
    })
    TableUtils.merge(self.offsets, {
        ["rain_windblow"] = {0, -2},
        ["look_down_left"] = {0, 0},
        ["walk_look_down/down"] = {0, 0},
        ["walk_unhappy/down"] = {0, -2},
        ["walk_unhappy/left"] = {0, -2},
        ["walk_unhappy/right"] = {0, -2},
        ["walk_unhappy/up"] = {0, -2},
    })
end

return actor