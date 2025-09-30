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
	return math.max(1, Utils.round(Utils.dist(x1, y1, x2, y2) / spd))
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
		if Game.world.music then
			self.memvolume = 1
			Game.world.music:fade(0, 30/30)
		end
		local cutscene = self.world:startCutscene(function(cutscene)
			cutscene:detachCamera()
			cutscene:detachFollowers()
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
			local pointdist = Utils.dist(self.leader_x, self.leader_y, leader.x, leader.y)
			if pointdist > 4 then
				local walkwait = math.min(scr_returnwait(leader.x, leader.y, self.leader_x, self.leader_y, 4), 15)
				cutscene:wait(cutscene:walkToSpeed(leader, self.leader_x, self.leader_y, walkwait, "up"))
			else
				leader.x = self.leader_x
				leader.y = self.leader_y
				cutscene:look(leader, "up")
				print("no need to move")
			end
			if self.catafollow then
				if party2 then
					local p2x, p2y = self.leader_x + 30, self.leader_y + 30
					pointdist = Utils.dist(p2x, p2y, party2.x, party2.y)
					if pointdist > 4 then
						local walkwait = math.min(scr_returnwait(party2.x, party2.y, p2x, p2y, 4), 15)
						cutscene:wait(cutscene:walkToSpeed(party2, p2x, p2y, walkwait, "up"))
					else
						party2.x = p2x
						party2.y = p2y
						cutscene:look(party2, "up")
					end
				end
				if party3 then
					local p3x, p3y = self.leader_x - 30, self.leader_y + 30
					pointdist = Utils.dist(p3x, p3y, party3.x, party3.y)
					if pointdist > 4 then
						local walkwait = math.min(scr_returnwait(party3.x, party3.y, p3x, p3y, 4), 15)
						cutscene:wait(cutscene:walkToSpeed(party3, p3x, p3y, walkwait, "up"))
					else
						party3.x = p3x
						party3.y = p3y
						cutscene:look(party3, "up")
					end
				end
				if party4 then
					local p4x, p4y = self.leader_x, self.leader_y + 30
					pointdist = Utils.dist(p4x, p4y, party4.x, party4.y)
					if pointdist > 4 then
						local walkwait = math.min(scr_returnwait(party4.x, party4.y, p4x, p4y, 4), 15)
						cutscene:wait(cutscene:walkToSpeed(party4, p4x, p4y, walkwait, "up"))
					else
						party4.x = p4x
						party4.y = p4y
						cutscene:look(party4, "up")
					end
				end
			end
			self.resetlight = true
			cutscene:wait(1/30)
			cutscene:interpolateFollowers()
			cutscene:attachFollowers()
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
		self.engaged = true
	end
	
	if self.con == 1 then
		Game.lock_movement = true
		if Input.down("cancel") then
			self.canceltimer = self.canceltimer + 1 * DTMULT
		else
			self.canceltimer = 0
		end
		
		if self.canceltimer >= self.canceltime or self.forceend then
			local skipcamreset = 0
			
			--[[if Game.world.camera.x == 0 or Game.world.camera.x == (Game.world.map.width * Game.world.map.tile_width) - SCREEN_WIDTH then
				skipcamreset = 2
			end]]
			if skipcamreset == 0 then
				if Game.world.music and self.memvolume ~= -1 then
					if self.reset_music then
						Game.world.music:seek(0)
					end
					Game.world.music:fade(self.memvolume, 120/30)
				end
				local tx, ty = Game.world.camera:getTargetPosition()
				Game.world.camera:panTo(tx, ty, 4/30, "linear", function() Game.world:setCameraAttached(true) end)
				Game.world.timer:after(8/30, function() self.con = 4 end)
			else
				if skipcamreset == 2 then
					if Game.world.music and self.memvolume ~= -1 then
						if self.reset_music then
							Game.world.music:seek(0)
						end
						Game.world.music:fade(self.memvolume, 120/30)
					end
					local tx, ty = Game.world.camera:getTargetPosition()
					Game.world:setCameraAttached(true)
					Game.world.camera:setPosition(tx, ty)
				end
				self.con = 4
			end
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
		if Input.pressed("confirm") and self.soundtoplay ~= -1 and not Input.down("cancel") then
			local mypitch, passkey = scr_piano_determinepitch(self.soundtoplay)
			Assets.playSound(self.instrument, 0.8, mypitch)
			soundplayed = true
			self.makenote = true
			self.notesplayed = true
			self.buffer = 0
			self.endlessplaylog = self.endlessplaylog..passkey
			local i = 1
			while i <= utf8.len(self.endlessplaylog) do
				if Utils.sub(self.endlessplaylog, i, utf8.len(self.endlessplaylog)) == self.solution then
					Assets.playSound("bell")
					self.endlessplaylog = ""
					break
				elseif Utils.sub(self.endlessplaylog, i, utf8.len(self.endlessplaylog)) == "nnfc" then
					self.endlessplaylog = ""
					Game.world:startCutscene("events.tobykillsyou")
					break
				end
				i = i + 1
			end
			if Utils.len(self.endlessplaylog) >= 200 then
				self.endlessplaylog = Utils.sub(self.endlessplaylog, 1, Utils.len(self.endlessplaylog) - 1)
			end
			print(self.endlessplaylog)
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
		Game.lock_movement = false
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