local Basic, super = Class(Wave)

function Basic:onStart()
    self.timer:every(1, function()
        local x = Utils.pick({Game.battle.arena.left +math.random(0, 200), Game.battle.arena.right-math.random(0, 200)})
        local y = Utils.pick({Game.battle.arena.top - 50, Game.battle.arena.bottom + 50})
        self.timer:script(function (wait)
         local a = self:spawnBullet("holyfirespawner", x, y, 0, 0, self)

         wait(1)
            a.physics.speed = 10
            a.physics.direction = Utils.angle(a.x, a.y, Game.battle.soul.x, Game.battle.soul.y)
            for i = 1,3 do
                a.subs[i].physics.speed = 8
                a.subs[i].physics.direction = Utils.angle(a.x, a.y, Game.battle.soul.x, Game.battle.soul.y)
            end

         --bullet.remove_offscreen = true
        end)
    end)
end

function Basic:update()
    -- Code here gets called every frame
    super.update(self)
end

function Basic:onEnd()
        for _,v in ipairs(Game.battle.enemies) do
            if v.exercism_used then
                            v:setTired(true)
            end
        end
end

return Basic