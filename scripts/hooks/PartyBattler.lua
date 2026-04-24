local PartyBattler, super = HookSystem.hookScript(PartyBattler)

function PartyBattler:hurt(amount, exact, color, options)
    local success, amount_armor = self.chara:checkArmor("master_medallion")
	
	if success then
		amount = math.huge
		
		if amount_armor == 2 then
			options["swoon"] = true
		end
	end
	
	super.hurt(self, amount, exact, color, options)
end

return PartyBattler