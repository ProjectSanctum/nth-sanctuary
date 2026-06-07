local Battle, super = HookSystem.hookScript(Battle)

function Battle:nextTurn()
	super.nextTurn(self)
	
	for _, battler in ipairs(self.party) do
        if battler.chara:hasAssist() and (battler.chara:getAssistHealth() <= 0) and battler.chara:canAutoHeal() and self.encounter:isAutoHealingEnabled(battler) then
            battler:healAssist(battler.chara:autoHealAssistAmount(), nil, true)
        end
    end
end

return Battle