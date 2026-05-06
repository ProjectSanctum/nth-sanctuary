---@class SmokeFx : Object
local SmokeFx, super = Class(Object)

function SmokeFx:init(x, y, decay, scale_factor)
    super.init(self, x, y)
    self.timer = Timer()
    self:setOrigin(0.5, 0.5)
    self:addChild(self.timer)
    self.decaytime = decay or 1 -- Time in seconds for the smoke (particles) to fade
    self.scale_factor = scale_factor or 1 -- How much the smoke should scale up (multiplicative)
    self.timer:every(0.05, function()
        print("a")
        local darksmoke = Sprite("effects/darksmoke", x, y)
        darksmoke:setScale(0)
        darksmoke:setOrigin(0.5, 0.5)
        darksmoke.alpha = 1
        darksmoke.physics.speed_y = 0
        darksmoke.physics.speed_x = math.random(-10, 10) / 10
        darksmoke.layer = WORLD_LAYERS["ui"] - 3
        Game.world:addChild(darksmoke)
        Game.world.timer:tween(2, darksmoke.physics, { speed_y = -7 }, "linear")
        Game.world.timer:tween(1, darksmoke, { scale_x = 2*self.scale_factor, scale_y = 2*self.scale_factor }, "linear", function()
            if darksmoke.physics.speed_x >= 1 then
                Game.world.timer:tween(1, darksmoke.physics, { speed_x = -4 })
            elseif darksmoke.physics.speed_x <= 1 then
                Game.world.timer:tween(1, darksmoke.physics, { speed_x = 4 })
            end
            Game.world.timer:tween(self.decaytime, darksmoke, { alpha = 0, scale_x = 4*self.scale_factor, scale_y = 4*self.scale_factor }, "linear", function()
                darksmoke:remove()
            end)
        end)
    end)
end

function SmokeFx:update()
    super.update(self)
end

function SmokeFx:draw()
    super.draw(self)
end

return SmokeFx