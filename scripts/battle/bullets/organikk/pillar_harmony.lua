---@diagnostic disable: undefined-field
local PillarHarmony, super = Class(Bullet)

function PillarHarmony:init(x, y, green)
    super.init(self, x, y, "battle/bullets/organikk/bar")
    self.sprite:play(1 / 30)

    self.wall_destroy = 1
    self.bottom_fade = 0
    self.green = green or false
    self.highlight = nil
    self.green_timer = 0
    self.play_piano_sfx = false
    self.touching_player = false
    self.chorus = false
    self.tp = 4

    self:setScale(0, 2)
    self.destroy_on_hit = false
    self:setHitbox(self.width / 4, self.height / 4, self.width / 2, 6 * self.height / 8)
    self.collidable = false
    self:setColor(COLORS.gray)
    self.damage = 56
    self.sprite.anim_speed = 0
    self.vm = 1
    self.charge_sfx = nil
    self.layer = 400
    self.showtempmercy = true
end

function PillarHarmony:onWaveSpawn()
    if self.wave.difficulty > 0 then
        self.green = true
        self:setColor(COLORS.lime)
        self.rotation = math.rad(90)
    end
    if self.wave.difficulty == 2 then
        self.chorus = true
    end
    self:addFX(MaskFX(Game.battle.arena))

    self.wave.timer:everyInstant(3 / 30, function()
        if self:isRemoved() or self.wave.del then
            return false
        end
        if not self.touching_player then
            return
        end
        local afterimage = self.wave:spawnObject(OrganikkPillarAfterImage("bullets/organikk/bar_1", 0.4 + MathUtils.random(0.25), 0.05))
        afterimage:setLayer(self.layer - 1)
        afterimage:setPosition(self:getPosition())
        afterimage:setOrigin(self:getOrigin())
        afterimage:setScale(self:getScale())
        afterimage.rotation = self.rotation
        afterimage.color = self.color
    end)

    self.wave.timer:lerpVar(self, "scale_x", 0, 0.4, 13, 3, "in")
    self.wave.timer:after(13 / 30, function()
        self.wave.timer:lerpVar(self, "scale_x", 0.4, 1.25, 3, -1, "in")
    end)

    self.wave.timer:after(16 / 30, function()
        Assets.playSound("sneo_overpower", 1, 1.9)
        self.collidable = true
        self.sprite.anim_speed = 1
    end)

    if not self.green then
        self.wave.timer:after(16 / 30, function()
            self:setColor(COLORS.white)
        end)
    end

    self.wave.timer:after(self.wave.interval / 30, function()
        self:setColor(ColorUtils.hexToRGB("808080"))
        self.collidable = false
        self.sprite.anim_speed = 0
        self.wave.timer:lerpVar(self, "scale_x", 1, 0, 4)
    end)

    self.wave.timer:everyInstant(2 / 60, function()
        if self:isRemoved() or self.wave.del then
            return false
        end
        if not self.touching_player then
            return
        end
        for _, attacker in ipairs(self.wave:getAttackers()) do
            attacker.mercyget = 1
        end
    end)

    self.wave.timer:everyInstant(4 / 60, function()
        if self:isRemoved() or self.wave.del then
            return false
        end
        if not self.touching_player then
            return
        end
        for _, attacker in ipairs(self.wave:getAttackers()) do
            attacker.mercyget2 = 1
        end
    end)
end

function PillarHarmony:update()
    super.update(self)

    if self.wave.del then
        if self.charge_sfx then
            self.charge_sfx:stop()
            self.charge_sfx = nil
        end
        if self.highlight then
            self.highlight:remove()
            self.highlight = nil
        end
    end

    local touching = false
    if self.green and self.collidable and Game.battle and Game.battle.soul and Game.battle.soul.collider and self.collider then
        if self.collider.collides then
            touching = self.collider:collides(Game.battle.soul.collider)
        elseif self.collider.collidesWith then
            touching = self.collider:collidesWith(Game.battle.soul.collider)
        end
    end
    self.touching_player = touching

    if self.touching_player then
        if not self.charge_sfx then
            self.charge_sfx = Assets.getSound("harmonize_act_b")
            self.charge_sfx:setLooping(true)
            self.charge_sfx:setVolume(0)
            local timer = 0
            Game.battle.timer:during(1 / 2, function()
                timer = timer + DT
                if self.charge_sfx then
                    self.charge_sfx:setVolume(MathUtils.rangeMap(timer, 0, 1 / 2, 0, 1))
                end
            end)
            self.charge_sfx:play()
        end

        for _, attacker in ipairs(self.wave:getAttackers()) do
            if not self.highlight then
                self.highlight = Game.battle:addChild(OrganikkHighlight(attacker.x - 54, attacker.y - 11))
                self.highlight:setLayer(BATTLE_LAYERS["above_battlers"])
            end
        end

        if not self.particle_timer then
            self.particle_timer = 0
        end
        self.particle_timer = self.particle_timer + DT
        if self.particle_timer >= 3 / 30 then
            for _, attacker in ipairs(self.wave:getAttackers()) do
                local particle_1 = Game.battle:addChild(OrganikkParticle(attacker.x - 15 + MathUtils.random(-20, 20), attacker.y - 20))
                particle_1:setLayer(BATTLE_LAYERS["above_battlers"])
                local particle_2 = Game.battle:addChild(OrganikkParticle(Game.battle.soul.x - 12 + MathUtils.random(-5, 5), Game.battle.soul.y - 4))
                particle_2:setLayer(BATTLE_LAYERS["above_soul"])
            end
            self.particle_timer = self.particle_timer - 3 / 30
        end
    elseif self.green then
        if self.charge_sfx then
            self.charge_sfx:stop()
            self.charge_sfx = nil
        end
        if self.highlight then
            self.highlight:remove()
            self.highlight = nil
        end
    end
end

function PillarHarmony:onCollide(soul)
    if self.green then
        self.touching_player = true
    else
        if soul.inv_timer == 0 then
            self:onDamage(soul)
        end
    end
end

return PillarHarmony