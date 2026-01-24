return {
    fountain = function(cutscene, event)
		if event.interact_count == 1 then
			cutscene:text("* (It's a pool of water. ...[wait:5] huh?)")
			cutscene:text("* (A feather drifted into it...[wait:5] and turned into coins!)")
			cutscene:text("* (Throw something inside?)")
		else
			cutscene:text("* (It's a pool of water. Throw something in?)")		
		end
        Game:enterShop("toss_fountain")
    end
}
