local Basic, super = Class(Wave)



function Basic:init()
    super.init(self)
    self.g = Game.battle.enemies[1].sprite
    self.time = 11
end

function Basic:onStart()
    self.timer:tween(1, self.g.hand, {alpha = 0}, 'linear')
    self.timer:tween(1, self.g.hand3, {alpha = 0}, 'linear')
    
    -- Every 0.33 seconds...
    self.timer:script(function (wait)
        local hand = Sprite("enemies/creature_a/hand")
        hand:addFX(ShaderFX(Mod.staticBulletShader, {
            ["time"] = function() return Kristal.getTime() end,
            ["brightness"] = 2
        }), "static_fx")
        Game.battle.arena:addChild(hand)
        hand:setPosition(-50, 125)
        hand:setLayer(9999)
        hand:setScale(2)
        hand.flip_x = true
        hand.alpha = 0
        self.timer:tween(0.5, hand, {alpha = 1, x = 0}, "out-circ", function() 
            Assets.playSound("noise")
        end)
        wait(17/30)


        local hand2 = Sprite("enemies/creature_a/hand")
        hand2:addFX(ShaderFX(Mod.staticBulletShader, {
            ["time"] = function() return Kristal.getTime() end,
            ["brightness"] = 2
        }), "static_fx")
        self:spawnObject(hand2, Game.battle.arena.right+100, Game.battle.arena.bottom - Game.battle.arena.height/2)
        hand2:setLayer(9999)
        hand2:setScale(2)
        hand2.alpha = 0
        self.timer:tween(0.5, hand2, {x = Game.battle.arena.right + 50, alpha = 1}, "out-circ", function() end)
        wait(0.25)
        Assets.playSound("heavyswing", 1.5)
        self.timer:tween(0.2, hand2, {x = hand2.x + 50}, "out-circ", function() 
            self.timer:tween(0.5, hand2, {x = Game.battle.arena.right}, 'in-expo', function()
                Game.battle.arena:shake(10, 0, 0.5, 1/30)
                Assets.playSound("impact", 1, 0.9)
            end)
        end)
        self.timer:tween(0.5, Game.battle.arena, {x = Game.battle.arena.right + 50}, 'in-expo', function()
        end)
        wait(1)
        local x1, x2 = 0, Game.battle.arena.width
        self.timer:every(1/7, function()
            local p = love.math.random(x1, x2)
            local bullet = self:spawnBulletTo(Game.battle.arena.mask, "guei/holyfire", p, -10)
            bullet.physics.direction = math.rad(love.math.random(70, 110))
            bullet.physics.speed = 2
            bullet.physics.friction = -0.25
        end)
    end)
end

function Basic:onEnd(death)
    super.onEnd(self, death)
    Game.battle.timer:tween(1, self.g.hand, {alpha = 1}, 'linear')
    Game.battle.timer:tween(1, self.g.hand3, {alpha = 1}, 'linear')
end

function Basic:update()
    -- Code here gets called every frame

    super.update(self)
end

return Basic