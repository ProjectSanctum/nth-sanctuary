local Basic, super = Class(Wave)

function Basic:onStart()
    self.time = 11
    for _, attacker in ipairs(self:getAttackers()) do
        attacker.orig_x_speed = attacker.x_speed
        attacker.orig_y_speed = attacker.y_speed
        attacker.orig_radius = attacker.radius
        
        attacker.x_speed = attacker.x_speed * 2
        attacker.y_speed = attacker.y_speed * 2
        attacker.radius = attacker.radius * 6
        attacker.enemy_hitbox = Hitbox(attacker, 0, 0, attacker.width, attacker.height)
    end

    self.timer:every(.75, function()
        local side = math.random(1, 5)
        for i = 1, math.random(2, 3) do
            local x, y, angle

            if side == 1 then
                x, y = math.random(Game.battle.arena.left, Game.battle.arena.right), -50 + Utils.random(-50, 50) - ((SCREEN_HEIGHT/2) - Game.battle.arena.y)
                angle = math.rad(90)
            elseif side == 2 then
                x, y = -50 + Utils.random(-50, 50), -50 + Utils.random(-50, 50) - ((SCREEN_HEIGHT/2) - Game.battle.arena.y)
                angle = math.rad(45)
            elseif side == 3 then
                x, y = -50 + Utils.random(-50, 50), math.random(Game.battle.arena.top, Game.battle.arena.bottom)
                angle = math.rad(0)
            elseif side == 4 then
                x, y = -50 + Utils.random(-50, 50), SCREEN_HEIGHT + 50 + Utils.random(-50, 50) 
                angle = math.rad(-45)
            else
                x, y = math.random(Game.battle.arena.left, Game.battle.arena.right), SCREEN_HEIGHT + 50 + Utils.random(-50, 50) 
                angle = math.rad(-90)
            end

            local bullet = self:spawnBullet("smallbullet", x, y, angle, 12)
            bullet.remove_offscreen = false
            bullet.physics.friction = 0.4
            bullet.is_reversing = false

            local old_update = bullet.update
            bullet.update = function(b)
                old_update(b)
                if not b.is_reversing and b.physics.speed <= 0.1 then
                    b.physics.speed = 0
                    b.physics.friction = 0
                    b.is_reversing = true
                    
                    self.timer:after(0.2, function()
                        b.remove_offscreen = true
                        b.physics.direction = MathUtils.angle(b.x, b.y, Game.battle.soul.x, Game.battle.soul.y)
                        b.physics.speed = 2
                        Assets.stopAndPlaySound("cardrive")
                    end)
                elseif b.is_reversing and b.physics.speed > 0 then
                    b.physics.speed = b.physics.speed + 0.4
                end

                for _, enemy in ipairs(self:getAttackers()) do
                    if enemy.enemy_hitbox and b:collidesWith(enemy.enemy_hitbox) then
                        local dmg = math.floor(enemy.max_health / 200) + math.random(-3, 6)

                        enemy:hurt(math.max(1, dmg), Game.battle.party[1])
                        Assets.stopAndPlaySound("damage")
                        
                        enemy:shake(6, 0)
                        b:remove()
                        return
                    end
                end
            end
        end
    end)
end

function Basic:onEnd()
    for _, attacker in ipairs(self:getAttackers()) do
        attacker.x_speed = attacker.orig_x_speed or attacker.x_speed
        attacker.y_speed = attacker.orig_y_speed or attacker.y_speed
        attacker.radius = attacker.orig_radius or attacker.radius
        attacker.enemy_hitbox = nil
    end
    super.onEnd(self)
end

return Basic