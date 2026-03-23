return {
    oldman = function(cutscene, event)
        local susie, ralsei, kris = cutscene:getCharacter("susie"),cutscene:getCharacter("ralsei"),cutscene:getCharacter("kris")
		cutscene:detachCamera()
		cutscene:detachFollowers()

		Assets.playSound("sussurprise")
		susie:setSprite("surprise_step")
		susie:shake()
		
		cutscene:setSpeaker(susie)
		cutscene:text("* ... Old man!", "dejected_scared")

		susie:resetSprite()
		susie:walkTo(481, susie.y, 1.5)
		cutscene:wait(cutscene:panTo(484, 784, 1.5))
		cutscene:wait(0.01)
		susie:setFacing("up")

		cutscene:wait(.5)
		cutscene:text("* ... [wait:5]He's not here.", "dejected")

		cutscene:wait(1)
		Assets.playSound("sussurprise")
		susie:shake()
		susie:setSprite("exasperated_left")
		cutscene:text("* Why,[wait:5] of COURSE he wouldn't be here!", "angry_e")
		cutscene:text("* If he would then he'd...", "angry_look")

		cutscene:wait(1.5)
		Assets.playSound("wing")
		susie:shake()
		susie:setFacing("down")
		susie:setSprite("walk_unhappy")
		cutscene:text("* ...", "dejected")
		susie:setFacing("left")
		cutscene:text("* ... Whatever.[wait:5]\n* Let's just explore this place for a bit.", "dejected_look")
		cutscene:text("* Maybe we can find something interesting.", "dejected_smile")
		
		cutscene:attachCamera()
        cutscene:wait(cutscene:attachFollowers())
		kris:setFacing("down")
		susie:setFacing("down")
    end,
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
			cutscene:text("* (Make sure to pay for it, Kris.)", "shy_b", "susie")
		--end
        local choicer = cutscene:choicer({"Buy", "Do not"})
        if choicer == 1 then
			Game:enterShop("gerson_table")
		end
    end,
	book = function (cutscene, event)
		local flag = Game:getFlag("readCount")
		local books = {
			[1] = {
				"* 'Our recent mission to bring forth our God had a minor setback.'",
				"* 'The church we desecrated had spread word to its inhabitants,'",
				"* 'And they came with their magic and weapons.'",
				"* 'We sent our seven strongest acolytes to shield us.'",
				"* 'They had the idea of enclosing the offendors in a mountain, and raise a barrier.'",
				"* 'We all agreed.'",
				"* 'Any second now, [wait:5]Shade rises.'"
			},
			[2] = {
				"* Interacted 2",
				"* 2 times!!!1!"
			},
			[3] = {
				"* 'The Order has tasked me with aiding them. [wait:10]I uphold their will.'",
				"* 'Their recent church has its people fighting back. And I, [wait:5]will enter this war.'",
				"* 'I will seal them with my fellows in hand. [wait:10]Let the Order prosper.'"
			},
			[4] = {
				"* Interacted 4",
				"ok"
			},
			[5] = {
				"* Interacted 5",
			},
			[6] = {
				"* Interacted 6",
			},
			[7] = {
				"* Interacted 7",
			},
			[8] = {
				"* Interacted 8",
			},
			[9] = {
				"* Interacted 9",
			},
			[10] = {
				"* (Wait, [wait:5]this passage feels like it was just written.)",
				"* 'Project Dusk is going very smoothly.'",
				"* 'A shame I've to be the undercover one.'",
				"* 'Oh well. [wait:10]Beggars can't be choosers.'",
				"* 'If I want to climb, [wait:5]then I will do so.'",
				"* '...By coordinating the fresh bodies that stepped right in.'",
				"* 'The one with the sword looks like the best candidate.'",
				"* 'I can feel their aura. [wait:10]It's so strong...'",
				"* 'It's as if their heart is the ark which guides them.'",
				"* 'The girl looks tough. [wait:10]With an axe and wits,[wait:5] she may be last.'",
				"* 'We break her down until her hope is the least of her worries.'",
				"* 'The other girl looks innocent. [wait:10]She may be the first.'",
				"* 'A dependant, [wait:5]lost girl.'",
				"* 'Yet she possesses magical prowess more than the one with a robe.'",
				"* 'That one. [wait:10]A fake. [wait:10]No aura. [wait:10]It's different.'",
				"* 'We can always throw him to the pit.'",
				"* 'It pains me to be the face that appears everywhere.'",
				"* 'I digress. [wait:10]Long Prosper.'",
				"* (For a moment, [wait:5]you felt like you were being watched.)",
			},
			--^ Add more passages in blanks. Ref Undertale or smth^--
		}
		if not flag then
			cutscene:text("* (It's a book.[wait:10] It has the...)")
			cutscene:text("* (Huh? [wait:5]This isn't the Delta Rune...)")
			cutscene:text("* (The triangles are replaced with a shield.)")
			cutscene:text("* (...and 6 triangles all pointed to a star in the center,[wait:10] on the shield.)")
			Game:setFlag("readCount", 0)
		end
		if Game:getFlag("readCount", 0) >= 10 then
			if Game:getFlag("fun") == 66 and love.math.random(1, 10) == 10 then
				cutscene:gotoCutscene("study.gaster")
			end
    		cutscene:text("* That's enough reading for now.")
    		return
		end

		::req::
		if not flag or flag < 1 then
			cutscene:text("* (Read a passage?)")
		else
			cutscene:text("* (Read another passage?)")
		end
		local choice = cutscene:choicer({"Yes", "No"})
		if choice == 1 then
			cutscene:text("* (You open the book to a random page...)")
			Game:addFlag("readCount", 1)
			flag = Game:getFlag("readCount")
			for i = 1, #books[flag] do
				cutscene:text(books[flag])
				if flag == 10 then
					cutscene:text("* (As you put the book back, [wait:5]you see something glinting behind.)")
					cutscene:text("* (You reach behind with your free hand...)")
					cutscene:text("* (And when you pull back, [wait:5]you find yourself holding a [color:9999ff]Dark Shard.[color:white])")
					Assets.playSound("shard_get")
					cutscene:text("* (You obtained a [color:9999ff]Dark Shard.[color:white])")
					Mod:setDarkShard(Mod.DarkShardID.BookShard, true)
					return
				end
				goto req
			end
		elseif choice == 2 then
			if Game:getFlag("readCount") == 1 then
				cutscene:text("* (You bookn't.)")
			else
				cutscene:text("* You close the book.")
			end
		end
	end,
	gaster = function(cutscene, event)
		cutscene:text({
			"* (The book changed.)",
			"* (The cover has a hand on it.)",
			"* (Instinctively, you open it.)",
		})
		Game.world.music:pause()
		cutscene:wait(2)
		Assets.playSound("smile", 1, 0.25)
		cutscene:text("* (It's filled with symbols.)")
		cutscene:text("* (Lines upon lines of symbols.)")
		cutscene:text("* (Nothing can be read.)")
		cutscene:text("* (You couldn't comprehend this, and close it.)")
		cutscene:text("* (...Where it then phases through the table.)")
		Assets.stopSound("smile")
		Game.world.music:play()
		
		
		
	end
}
