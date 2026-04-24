local PartyMember, super = HookSystem.hookScript(PartyMember)

function PartyMember:getStat(name, default, light)
    local stat = super.getStat(self, name, default, light)
    if name == "attack" then
        local success, amount = self:checkArmor("master_medallion")
        stat = stat * (2^amount)
    end
    return stat
end

function PartyMember:canAutoHeal()
	local success, amount = self:checkArmor("master_medallion")
	if amount == 2 then
		return false
	end
    return true
end

return PartyMember