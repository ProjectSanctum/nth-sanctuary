local EnemyBattler, super = HookSystem.hookScript(EnemyBattler)

function EnemyBattler:hurt(amount, battler, on_defeat, color, show_status, attacked)
    if amount == 0 or (amount < 0 and Game:getConfig("damageUnderflowFix")) then
        if show_status ~= false then
            self:statusMessage("msg", "miss", color or (battler and { battler.chara:getDamageColor() }), nil, 2, battler and battler.chara)
        end

        self:onDodge(battler, attacked)
        return
    end

    self.health = self.health - amount
    if show_status ~= false then
        self:statusMessage("damage", amount, color or (battler and { battler.chara:getDamageColor() }), nil, 2, battler and battler.chara)
    end

    if amount > 0 then
        self.hurt_timer = 1
        self:onHurt(amount, battler)
    end

    self:checkHealth(on_defeat, amount, battler)
end

function EnemyBattler:freezeCompel()
    if not self.can_freeze then
        self:onDefeat()
        return
    end
    Assets.playSound("indoct_up")
    Assets.playSound("petrify")

    self:toggleOverlay(true)

    local sprite = self:getActiveSprite()
    if not sprite:setAnimation("frozen") then
        sprite:setAnimation("hurt")
    end
    sprite:stopShake()

    self:recruitMessage("frozen")

    self.hurt_timer = -1

    sprite.frozen = true
    sprite.freeze_progress = 0

    Game.battle.timer:tween(1, sprite, { freeze_progress = 1 }, 'out-circ')

    Game.battle.money = Game.battle.money + 24
    self:defeat("FROZEN", true)
end

return EnemyBattler