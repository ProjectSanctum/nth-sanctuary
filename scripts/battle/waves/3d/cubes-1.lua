local Basic, super = Class(Wave)

function Basic:init()
    super.init(self)
    self.time = 15
    self:setSoulPosition(320, 230)
end

function Basic:onStart()
    -- Every 0.33 seconds...
    self.spawned = {}
    local arena = Game.battle.arena
    local a, b = arena:getCenter()
    self.g = self:spawnBullet("3d/smallcube", a, b, math.rad(180), 0)
    self.timer:every(1/10, function()
        -- Our X position is offscreen, to the right
        local x = SCREEN_WIDTH + 20
        -- Get a random Y position between the top and the bottom of the arena
        local y = Utils.random(Game.battle.arena.top, Game.battle.arena.bottom)

        -- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
        local bullet = self:spawnBullet("3d/smallcube", a, b, math.rad(180), 8)
        local bullet2 = self:spawnBullet("3d/smallcube", a, b, math.rad(180), -8)

        -- Dont remove the bullet offscreen, because we spawn it offscreen
        table.insert(self.spawned, bullet)
        table.insert(self.spawned, bullet2)
    end)
end

function Basic:update()
    -- Code here gets called every frame
    super.update(self)
    if self.spawned then
        for i = 1, #self.spawned do
            self.spawned[i].physics.direction = math.rad((i-1)*10)
            self.spawned[i].physics.friction = self.spawned[i].physics.friction-0.1
        end
    end
end

return Basic