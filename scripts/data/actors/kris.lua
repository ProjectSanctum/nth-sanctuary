---@class Actor.kris : Actor
local actor, super = Class("kris", true)

function actor:init()
    super.init(self)
    TableUtils.merge(self.animations, {
        ["slide"] = {"slide_animated", 4/30, true},
        ["pirouette"] = {"battle/pirouette", 3/30, true},
        ["fall_hurt"] = {"fall_hurt", 0, true},
        ["fall_hurt_wind"] = {"fall_hurt_wind", 1/5, true},
        ["run"] = {"run", 3/30, true}
    })
end

return actor