local Aiming, super = Class(Wave)

function Aiming:onStart()
    self.time = 11
    
    local arena = Game.battle.arena
    arena.right_side_alpha = 1

    local old_draw = arena.sprite.draw
    arena.sprite.draw = function(s)
        local parent = s.parent
        if parent.bg_color then
            love.graphics.setColor(parent.bg_color)
            love.graphics.polygon("fill", Utils.unpackPolygon(parent.shape))
        end

        for i, edge in ipairs(Utils.getPolygonEdges(parent.shape)) do
            local x1, y1, x2, y2 = edge[1][1], edge[1][2], edge[2][1], edge[2][2]
            local alpha = 1
            
            local is_vertical = math.abs(x1 - x2) < 0.1
            local is_right_side = is_vertical and math.max(x1, x2) >= parent.width - 1
            
            if is_right_side then
                alpha = parent.right_side_alpha
            end
            
            local r, g, b = unpack(parent.color)
            love.graphics.setColor(r, g, b, alpha)
            love.graphics.setLineWidth(parent.line_width)
            love.graphics.line(x1, y1, x2, y2)
        end
    end

    local attackers = self:getAttackers()
    for _, attacker in ipairs(attackers) do
        attacker.orig_y_speed = attacker.y_speed
        attacker.orig_radius = attacker.radius
        
        attacker.enemy_hitbox = Hitbox(attacker, 0, 0, attacker.width, attacker.height)
    end

    self.timer:everyInstant(2, function()
        local attackers = self:getAttackers()
        for _, attacker in ipairs(attackers) do
            local x, y = attacker:getRelativePos(attacker.width/2, attacker.height/2)
            local angle = MathUtils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)

            local bullet = self:spawnBullet("smallbullet", x, y, angle, 8.75)
            bullet.destroy_on_hit = false
            bullet.remove_offscreen = false 
            bullet.physics.match_rotation = true
            bullet.rotation = angle
            
            attacker:shake(4, 0)
            Assets.playSound("wing", 2)

            bullet.bounce_state = 0
            bullet.prev_line = nil
            
            self.timer:every(0.1, function()
                if bullet then
                    bullet:addChild(AfterImage(bullet, 0.5))
                end
            end)

            local old_update = bullet.update
            bullet.update = function(b)
                old_update(b)
                local arena = Game.battle.arena
                
                if b.bounce_state == 2 then
                    for _, enemy in ipairs(self:getAttackers()) do
                        if enemy.enemy_hitbox and b:collidesWith(enemy.enemy_hitbox) then
                            local dmg = math.floor(enemy.max_health / 50) + math.random(-6, 12)
                            
                            enemy:hurt(math.max(1, dmg), Game.battle.party[1])
                            Assets.stopAndPlaySound("damage")
                            
                            enemy:shake(6, 0)
                            b:remove()
                            return
                        end
                    end
                end

                local is_inside = b.x > arena:getLeft() + 8 and b.x < arena:getRight() - 8 and 
                                 b.y > arena:getTop() + 8 and b.y < arena:getBottom() - 8

                if b.bounce_state == 0 then
                    if is_inside then b.bounce_state = 1 end
                elseif b.bounce_state == 1 then
                    if not is_inside then b.bounce_state = 2 end
                elseif b.bounce_state == 2 then
                    local can_bounce = true
                    if b.x >= arena:getRight() - 12 and arena.right_side_alpha <= 0 then
                        can_bounce = false
                    end

                    if can_bounce then
                        for _, line in ipairs(arena.collider.colliders) do
                            if b:collidesWith(line) and b.prev_line ~= line then
                                Assets.stopAndPlaySound("bump")
                                local vx, vy = Vector.fromPolar(b.physics.direction, b.physics.speed)
                                
                                local is_horizontal = math.abs(line.x - line.x2) > math.abs(line.y - line.y2)
                                if is_horizontal then
                                    arena.y = (vy < 0) and arena.y - 2 or arena.y + 2
                                else
                                    arena.x = (vx < 0) and arena.x - 2 or arena.x + 2
                                    if math.max(line.x, line.x2) >= arena.width - 2 then
                                        arena.right_side_alpha = math.max(0, arena.right_side_alpha - 0.05)
                                    end
                                end

                                local nvx, nvy = Vector.mirror(vx, vy, line.x - line.x2, line.y - line.y2)
                                b.physics.direction = Vector.toPolar(nvx, nvy)
                                b.rotation = b.physics.direction
                                b.prev_line = line
                                break
                            end
                        end
                    end
                    
                    if not b:collidesWith(arena.collider) then
                        b.prev_line = nil
                    end
                end
            end
        end
    end)
end

function Aiming:update()
    local attackers = self:getAttackers()
    for _, attacker in ipairs(attackers) do
        attacker.y_speed = attacker.y_speed + (0.01 * DT)
        attacker.radius = attacker.radius + (10 * DT)
    end
    super.update(self)
end

function Aiming:onEnd()
    local attackers = self:getAttackers()
    for _, attacker in ipairs(attackers) do
        attacker.y_speed = attacker.orig_y_speed or attacker.y_speed
        attacker.radius = attacker.orig_radius or attacker.radius
        attacker.enemy_hitbox = nil
    end
    super.onEnd(self)
end

return Aiming