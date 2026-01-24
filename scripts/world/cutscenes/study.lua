return {
    fountain = function(cutscene, event)
		if not Game:getFlag("interactedWithFountain", false) then
			cutscene:text("* (It's a pool of water. ...[wait:5] huh?)")
			cutscene:text("* (A feather drifted into it...[wait:5] and turned into coins!)")
			cutscene:text("* (Throw something inside?)")
			Game:setFlag("interactedWithFountain", true)
		else
			cutscene:text("* (It's a pool of water. Throw something in?)")		
		end
        Game:enterShop("toss_fountain")
    end,
    table = function(cutscene, event)
		--[[if not Game:getFlag("interactedWithTable", false) then
			Game:setFlag("interactedWithTable", true)
		else]]
			cutscene:text("* Umm,[wait:5] would you like anything,[wait:5] Kris?", "blush_smile", "ralsei")
		--end
        local choicer = cutscene:choicer({"Buy", "Do not"})
        if choicer == 1 then
			Game:enterShop("gerson_table")
		end
    end,
}
