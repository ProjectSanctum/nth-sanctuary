local Wall, super = Class(Wave)

function Wall:onStart()
    self.time = 13
    for _, attacker in ipairs(self:getAttackers()) do
        attacker.orig_radius = attacker.radius
        attacker.radius = attacker.radius * 4
        attacker.enemy_hitbox = Hitbox(attacker, 0, 0, attacker.width, attacker.height)
    end

    self.timer:everyInstant(1.25, function()
        for y = 0, SCREEN_HEIGHT, Utils.random(12, 36) do
            local bullet = self:spawnBullet("smallbullet", SCREEN_WIDTH + 20, y, math.rad(180), 4)
            bullet.remove_offscreen = false
            bullet.ignore = false
            bullet.is_negative = false
            bullet.can_graze = false

            local old_update = bullet.update
            bullet.update = function(b)
                old_update(b)
                
                if not b.is_negative and b.x < 100 then
                    b.remove_offscreen = true
                    b.is_negative = true
                    Game.battle.timer:tween(1, b.physics, {speed = -4}, "in-out-quad")
                end

                for _, enemy in ipairs(self:getAttackers()) do
                    if enemy.enemy_hitbox and b:collidesWith(enemy.enemy_hitbox) then
                        if b.is_negative and b.physics.speed < 0 then
                            local dmg = math.floor(enemy.max_health / 200 + Utils.random(-2, 3))
                            enemy:hurt(math.max(1, dmg), Game.battle.party[1])
                            Assets.stopAndPlaySound("damage")
                            enemy:shake(6, 0)
                            b:remove()
                            return
                        elseif not b.is_negative and not b.ignore then
                            Assets.stopAndPlaySound("bump")
                            b:shake()
                            b.ignore = true
                            self.timer:after(1/math.abs(b.physics.speed), function()
                                b.ignore = false
                            end)
                            b.physics.speed = -b.physics.speed
                            self.timer:tween(1, b.physics, {speed = -b.physics.speed/2}, "in-out-quad")
                        end
                    end
                end
            end
        end
    end)
end

function Wall:onEnd()
    for _, attacker in ipairs(self:getAttackers()) do
        attacker.radius = attacker.orig_radius or attacker.radius
        attacker.enemy_hitbox = nil
    end
    super.onEnd(self)
end

return Wall