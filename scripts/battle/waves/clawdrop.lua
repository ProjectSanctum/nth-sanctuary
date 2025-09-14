local Aiming, super = Class(Wave)

function Aiming:init()
    super.init(self)

    self:setArenaSize(100, 200)
    self.time = 15
end

function Aiming:onStart()
    -- Every 0.5 seconds...
    self.timer:every(1, function()
        -- Get all enemies that selected this wave as their attack
        local spawned = {}
        for i = 1,5 do
            local bul = self:spawnBullet("diamondbullet", Game.battle.arena.left+(25*(i-1)), Game.battle.arena.top-50, math.rad(90), 0.01, math.rad(90))
            table.insert(spawned, bul)
        end
        if #spawned > 0 then
            local rand = love.math.random(1, #spawned)
            local delete_that = spawned[rand]
            delete_that:remove()
        end
    end)
end

function Aiming:update()
    -- Code here gets called every frame

    super.update(self)
end

return Aiming