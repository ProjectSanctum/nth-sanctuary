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

return EnemyBattler