local Basic, super = Class(Wave)

function Basic:init()
    super.init(self)
    self:setArenaSize(175)
    self:setSoulPosition(320, 230)
    self.diff = love.math.random(1,5)
end

local spr = Sprite("enemies/creature_a/eye")

function Basic:onStart()
    -- Every 0.33 seconds...
    local arena = Game.battle.arena
    spr.x, spr.y = arena:getCenter()
    spr.alpha = 0
    Game.battle.timer:tween(1, spr, {alpha = 1}, "out-cubic")
    spr:setOrigin(0.5, 0.5)
    spr:setScale(3)
    self:addChild(spr)
    self.timer:every(1/2, function()
        Game.battle.timer:tween(0.5, spr, {rotation = spr.rotation + math.rad(40)}, "out-circ")
        for i = 1,8 do
            local bullet = self:spawnBullet("guei/holyfire", spr.x, spr.y)
            if i <= 4 then
                bullet.physics.speed = 8
                bullet.physics.direction = spr.rotation - math.rad(90 * (i-1))
            else
                bullet.physics.speed = 4
                if self.diff == 5 then
                    bullet.physics.direction = spr.rotation - math.rad(45 * (i-1))
                else
                    bullet:setScale(2/3)
                    bullet.physics.direction = spr.rotation - math.rad((90 * (i-1))-45)
                end
            end
        end
    end)

end

function Basic:update()
    -- Code here gets called every frame
    super.update(self)
    spr.rotation = spr.rotation + (DTMULT/60)
end

return Basic