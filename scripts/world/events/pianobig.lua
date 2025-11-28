local BigChurchPiano, super = Class(Event, "pianobig")

function BigChurchPiano:init(data)
    super.init(self, data)
	
    local properties = data.properties or {}

	self.prop = properties["cutscene"]
	
	self.draw_children_above = 1
	self.solid = true
	self.leader_x = data.center_x
	self.leader_y = self.y + self.height + 24
	self.catafollow = true
	self.con = 0
	self.forceend = false
	self.timer = 0
	self.resetlight = false
	self.instrument = "bigpiano"
	self.buffer = 0
	self.soundtoplay = -1
	self.difficulty = 1
	self.canceltimer = 0
	self.canceltime = 15
	self.drawspace = 30
	self.engaged = false
	self.engaged_alpha = 0
	self.siner = 0
	self.dontdrawmenu = false
	self.drawalpha = 0
	self.memvolume = -1
	self.endlessplaylog = ""
	self.solution = properties["solution"] or "aoamcdbaaoaebcdeeeeeacbnaaocdeeeeefghgfecaoamcdbaklji"
	self.oct = false
	self.cutscene = properties["cutscene"] or nil
	self.notedisplay = nil
	self.makenote = false
	self.reset_music = properties["resetmus"] ~= false
end

function BigChurchPiano:onAdd(parent)
    super.onAdd(self,parent)
    if not Game.stage:getObjects(TutorialText)[1] then
		local tuttext = TutorialText(2, self)
		Game.world:addChild(tuttext)
	end
    if not Game.stage:getObjects(OrganNoteDisplay)[1] then
		self.notedisplay = OrganNoteDisplay(self)
		Game.world:addChild(self.notedisplay)
	end
end

local function scr_returnwait(x1, y1, x2, y2, spd)
	return math.max(1, MathUtils.round(MathUtils.dist(x1, y1, x2, y2) / spd))
end

local function scr_piano_determinepitch(sound)
	local a = 0
	local passentry = ""
	if sound == 0 then
		if not Input.down("menu") then
			a = 1
			passentry = "a"
		else
			a = 0.5
			passentry = "i"
		end
	elseif sound == 5 then
		if not Input.down("menu") then
			a = 1.125
			passentry = "b"
		else
			a = 0.5625
			passentry = "j"
		end
	elseif sound == 4 then
		if not Input.down("menu") then
			a = 1.25
			passentry = "c"
		else
			a = 0.625
			passentry = "k"
		end
	elseif sound == 3 then
		if not Input.down("menu") then
			a = 4/3
			passentry = "d"
		else
			a = 2/3
			passentry = "l"
		end
	elseif sound == 2 then
		if not Input.down("menu") then
			a = 1.5
			passentry = "e"
		else
			a = 0.75
			passentry = "m"
		end
	elseif sound == 1 then
		if not Input.down("menu") then
			a = 1.6666666666666667
			passentry = "f"
		else
			a = 0.8333333333333334
			passentry = "n"
		end
	elseif sound == 8 then
		if not Input.down("menu") then
			a = 1.875
			passentry = "g"
		else
			a = 0.9375
			passentry = "o"
		end
	elseif sound == 7 then
		if not Input.down("menu") then
			a = 2
			passentry = "h"
		else
			a = 1
			passentry = "a"
		end
	end
	return a, passentry
end

function BigChurchPiano:onInteract(player, dir)
	if self.con == 0 and self.buffer <= 0 then
		self.endlessplaylog = ""
		if Game.stage:getObjects(TutorialText)[1] then
			Game.stage:getObjects(TutorialText)[1].target = self
		end
		local cutscene = self.world:startCutscene(function(cutscene)
			cutscene:detachCamera()
			cutscene:detachFollowers()
			Game.world.music:fade(0, 30/30)
			Game.world.camera:panTo(560+SCREEN_WIDTH/2, Game.world.camera.y, 15/30)
			local leader = cutscene:getCharacter(Game.party[1]:getActor().id)
			local party2, party3, party4 = nil, nil, nil
			if #Game.party >= 2 then
				party2 = cutscene:getCharacter(Game.party[2]:getActor().id)
			end
			if #Game.party >= 3 then
				party3 = cutscene:getCharacter(Game.party[3]:getActor().id)
			end
			if #Game.party >= 4 then
				party4 = cutscene:getCharacter(Game.party[4]:getActor().id)
			end
			cutscene:walkTo(leader, 269 + 560, leader.y, 12/30)
			Game.world.timer:after(13/30, function() cutscene:walkTo(leader, 269 + 560, 300, 12/30) end)
			Game.world.timer:after(26/30, function() cutscene:walkTo(leader, 321 + 560, 300, 12/30) end)
			Game.world.timer:after(39/30, function() cutscene:look(leader, "up") end)
			if party2 then
				if #Game.party < 3 then
					cutscene:walkTo(party2, 321 + 560, 382, 12/30)
				else
					cutscene:walkTo(party2, 371 + 560, 362, 12/30)
				end
			end
			if party3 then
				cutscene:walkTo(party3, 271 + 560, 362, 12/30)
			end
			if party4 then
				cutscene:walkTo(party4, 321 + 560, 382, 12/30)
			end
			cutscene:wait(12/30)
			if party2 then
				cutscene:look(party2, "up")
			end
			if party3 then
				cutscene:look(party3, "up")
			end
			if party4 then
				cutscene:look(party4, "up")
			end
			cutscene:wait(30/30)
		end)
		cutscene:after(function()
			Game.lock_movement = true
			self.con = 0.2
		end)
		return true
	end
end

function BigChurchPiano:update()
	super.update(self)
	if self.buffer > 0 then
		self.buffer = self.buffer - 1 * DTMULT
	end
	
	if self.resetlight then
		self.resetlight = false
	end
	
	if self.con == 0.2 then
		self.con = 1
		Game.world.player:setSprite("piano")
		self.engaged = true
	end
	
	if self.con == 1 then
		Game.lock_movement = true
		if Input.down("cancel") and not Game.world.cutscene then
			self.canceltimer = self.canceltimer + 1 * DTMULT
		else
			self.canceltimer = 0
		end
		
		if self.canceltimer >= self.canceltime or self.forceend then
			self.con = 4
			Game.world.player:resetSprite()
			local cutscene = self.world:startCutscene(function(cutscene)
				cutscene:detachCamera()
				cutscene:detachFollowers()
				Game.world.music:seek(0)
				Game.world.music:setVolume(0)
				Game.world.music:fade(1, 120/30)
				Game.world.camera:panTo(560+SCREEN_WIDTH/2, Game.world.camera.y, 15/30)
				local leader = cutscene:getCharacter(Game.party[1]:getActor().id)
				cutscene:walkTo(leader, leader.x - 50, leader.y, 12/30)
				Game.world.timer:after(13/30, function() cutscene:walkTo(leader, leader.x, leader.y + 40, 12/30) end)
				Game.world.timer:after(26/30, function() cutscene:walkTo(leader, leader.x + 50, leader.y, 12/30) end)
				Game.world.timer:after(39/30, function() cutscene:look(leader, "down") end)
				cutscene:wait(44/30)
				cutscene:panTo(leader, 15/30)
				cutscene:wait(16/30)
				cutscene:walkToSpeed(leader, leader.x, leader.y + 4, 4) -- lol
				cutscene:interpolateFollowers()
				cutscene:attachFollowers()
				cutscene:attachCamera()
			end)
			cutscene:after(function()
				Game.lock_movement = false
			end)
		end
		
		self.soundtoplay = 0
		if Input.down("left") and not Input.down("down") and not Input.down("right") and not Input.down("up") then
			self.soundtoplay = 1
		end
		if Input.down("left") and Input.down("down") and not Input.down("up") and not Input.down("right") then
			self.soundtoplay = 2
		end
		if Input.down("down") and not Input.down("left") and not Input.down("right") and not Input.down("up") then
			self.soundtoplay = 3
		end
		if Input.down("down") and Input.down("right") and not Input.down("left") and not Input.down("up") then
			self.soundtoplay = 4
		end
		if Input.down("right") and not Input.down("left") and not Input.down("down") and not Input.down("up") then
			self.soundtoplay = 5
		end
		if Input.down("up") and Input.down("right") and not Input.down("down") and not Input.down("left") then
			self.soundtoplay = 7
		end
		if Input.down("up") and not Input.down("left") and not Input.down("down") and not Input.down("right") then
			self.soundtoplay = 7
		end
		if Input.down("up") and Input.down("left") and not Input.down("down") and not Input.down("right") then
			self.soundtoplay = 8
		end
		local soundplayed = false
		if Input.pressed("confirm") and self.soundtoplay ~= -1 and not Input.down("cancel") and not Game.world.cutscene then
			local mypitch, passkey = scr_piano_determinepitch(self.soundtoplay)
			Assets.playSound(self.instrument, 0.8, mypitch)
			soundplayed = true
			self.makenote = true
			self.notesplayed = true
			self.buffer = 0
			self.endlessplaylog = self.endlessplaylog..passkey
			local i = 1
			while i <= utf8.len(self.endlessplaylog) do

                --solution
				if StringUtils.sub(self.endlessplaylog, i, utf8.len(self.endlessplaylog)) == self.solution then
					Assets.playSound("bell")
					self.endlessplaylog = ""
					break
					
                --His Theme
				elseif StringUtils.sub(self.endlessplaylog, i, utf8.len(self.endlessplaylog)) == "mbamooamamooa" then
					self.endlessplaylog = ""
					Game.world:startCutscene("bigpiano.histheme")
					break

                --Your Best Friend
				elseif StringUtils.sub(self.endlessplaylog, i, utf8.len(self.endlessplaylog)) == "ccdecddebm" then
					Input.clear("menu", true)
					self.endlessplaylog = ""
					Game.world:startCutscene("bigpiano.yourbestfriend")
					break

                --Unknown "Annoying" Song
				elseif StringUtils.sub(self.endlessplaylog, i, utf8.len(self.endlessplaylog)) == "adefddcdbadedcdd" then
					self.endlessplaylog = ""
					Game.world:startCutscene("bigpiano.annoying")
					break

                --MEGALOVANIA
				elseif StringUtils.sub(self.endlessplaylog, i, utf8.len(self.endlessplaylog)) == "nnfc" then
					self.endlessplaylog = ""
					Game.world:startCutscene("bigpiano.megalovania")
					break
					
                --Penumbra Phantasm
                elseif StringUtils.sub(self.endlessplaylog, i, utf8.len(self.endlessplaylog)) == "dceccd" then
                    self.endlessplaylog = ""
                    Game.world:startCutscene("bigpiano.megalovania")
                    break
					
                --You've Got A Friend in Me/Chopsticks/Heart & Soul
				elseif StringUtils.sub(self.endlessplaylog, i, utf8.len(self.endlessplaylog)) == "cecfeafhfhe" then
					self.endlessplaylog = ""
					Game.world:startCutscene("bigpiano.misc")
					break
				elseif StringUtils.sub(self.endlessplaylog, i, utf8.len(self.endlessplaylog)) == "ddddddddccccccccgggggfghhhhgf" then
					self.endlessplaylog = ""
					Game.world:startCutscene("bigpiano.annoying")
					break
				elseif StringUtils.sub(self.endlessplaylog, i, utf8.len(self.endlessplaylog)) == "aaaaonoabccccbabcd" then
					self.endlessplaylog = ""
					Game.world:startCutscene("bigpiano.misc")
					break
				end
				i = i + 1
			end
			if StringUtils.len(self.endlessplaylog) >= 200 then
				self.endlessplaylog = StringUtils.sub(self.endlessplaylog, 1, StringUtils.len(self.endlessplaylog) - 1)
			end
			print(self.endlessplaylog)
			Kristal.Console:log(self.endlessplaylog)
		end
	end
	
	if self.con == 30 then
	end
	
	if self.con == 4 then
		self.forceend = false
		self.con = 0
		self.timer = 0
		self.buffer = 6
		self.canceltimer = 0
		self.dontdrawmenu = false
	end
end

function BigChurchPiano:draw()
	super.draw(self)
	
	self.siner = self.siner + 1 * DTMULT
	if self.con == 1 then
		self.engaged = true
		self.engaged_alpha = 1
	else
		self.engaged = false
		self.engaged_alpha = 0
	end
end

return BigChurchPiano