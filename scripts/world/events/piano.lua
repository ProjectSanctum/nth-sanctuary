local ChurchPiano, super = Class(Event, "piano")

function ChurchPiano:init(data)
    super.init(self, data)
	
	self.draw_children_above = 1
	self.solid = true
	self.leader_x = data.center_x
	self.leader_y = self.y + self.height + 24
	self.catafollow = true
	self.con = 0
	self.forceend = false
	self.timer = 0
	self.resetlight = false
	self.instrument = "piano"
	self.buffer = 0
	self.soundtoplay = -1
	self.difficulty = 0
	self.canceltimer = 0
	self.canceltime = 15
	self.drawspace = 30
	self.engaged = false
	self.siner = 0
	self.dontdrawmenu = false
	self.drawalpha = 0
	self.memvolume = -1
	progress = ""
	solution = "777335"
	self.arrowspr = "ui/arrow_10x10"
	self.circlespr = "ui/circle_7x7"
	self.drawunits = {}
	local space = 28
	table.insert(self.drawunits, {sound = 3, x = 0, y = space, offx = 5, offy = 5, rot = math.rad(0), tex = self.arrowspr})
	table.insert(self.drawunits, {sound = 5, x = space, y = 0, offx = 5, offy = 5, rot = math.rad(-90), tex = self.arrowspr})
	table.insert(self.drawunits, {sound = 7, x = 0, y = -space, offx = 5, offy = 5, rot = math.rad(180), tex = self.arrowspr})
	table.insert(self.drawunits, {sound = 1, x = -space, y = 0, offx = 5, offy = 5, rot = math.rad(-270), tex = self.arrowspr})
	table.insert(self.drawunits, {sound = 0, x = 0, y = 0, offx = 3, offy = 3, rot = math.rad(0), tex = self.circlespr})
end

function ChurchPiano:onAdd(parent)
    super.onAdd(self,parent)
    if not Game.stage:getObjects(PianoTutorialText)[1] then
		local tuttext = PianoTutorialText(1, self)
		Game.world:addChild(tuttext)
	end
end

local function scr_returnwait(x1, y1, x2, y2, spd)
	return math.max(1, Utils.round(Utils.dist(x1, y1, x2, y2) / spd))
end

local function scr_piano_determinepitch(sound)
	if sound == 0 then
		return 1
	elseif sound == 1 then
		return 1.12
	elseif sound == 2 then
		return 1.155
	elseif sound == 3 then
		return 1.19
	elseif sound == 4 then
		return 1.0414285714285714
	elseif sound == 5 then
		return 0.8928571428571428
	elseif sound == 6 then
		return 0.6964285714285714
	elseif sound == 7 then
		return 0.5
	elseif sound == 8 then
		return 0.3035714286
	end
end

function ChurchPiano:onInteract(player, dir)
	if self.con == 0 then
		if Game.stage:getObjects(PianoTutorialText)[1] then
			Game.stage:getObjects(PianoTutorialText)[1].target = self
		end
		if Game.world.music then
			self.memvolume = Game.world.music.volume
			Game.world.music:fade(self.memvolume * 0.125, 15/30)
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

function ChurchPiano:update()
	super.update(self)
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
					Game.world.music:fade(self.memvolume, 15/30)
				end
				local tx, ty = Game.world.camera:getTargetPosition()
				Game.world.camera:panTo(tx, ty, 4/30, "linear", function() Game.world:setCameraAttached(true) end)
				Game.world.timer:after(8/30, function() self.con = 4 end)
			else
				if skipcamreset == 2 then
					if Game.world.music and self.memvolume ~= -1 then
						Game.world.music:fade(self.memvolume, 5/30)
					end
					local tx, ty = Game.world.camera:getTargetPosition()
					Game.world:setCameraAttached(true)
					Game.world.camera:setPosition(tx, ty)
				end
				self.con = 4
			end
		end
		
		self.soundtoplay = -1
		if self.difficulty == 0 then
			if not Input.down("left") and not Input.down("down") and not Input.down("right") and not Input.down("up") then
				self.soundtoplay = 0
			end
			if Input.down("left") then
				self.soundtoplay = 1
			end
			if Input.down("down") then
				self.soundtoplay = 3
			end
			if Input.down("right") then
				self.soundtoplay = 5
			end
			if Input.down("up") then
				self.soundtoplay = 7
			end
		end
		if self.difficulty == 1 then
			if not Input.down("left") and not Input.down("down") and not Input.down("right") and not Input.down("up") then
				self.soundtoplay = 0
			end
			if Input.down("left") and not Input.down("down") and not Input.down("right") and not Input.down("up") then
				self.soundtoplay = 1
			end
			if Input.down("left") and Input.down("down") and not Input.down("right") and not Input.down("up") then
				self.soundtoplay = 2
			end
			if Input.down("down") and not Input.down("left") and not Input.down("right") and not Input.down("up") then
				self.soundtoplay = 3
			end
			if Input.down("down") and Input.down("right") and not Input.down("left") and not Input.down("up") then
				self.soundtoplay = 4
			end
			if Input.down("right") and not Input.down("left") and not Input.down("down") and not Input.down("up")  then
				self.soundtoplay = 5
			end
			if Input.down("up") and Input.down("right") and not Input.down("down") and not Input.down("left") then
				self.soundtoplay = 6
			end
			if Input.down("up") and not Input.down("down") and not Input.down("right") and not Input.down("left") then
				self.soundtoplay = 7
			end
			if Input.down("up") and Input.down("left") and not Input.down("down") and not Input.down("right") then
				self.soundtoplay = 8
			end
		end
		local soundplayed = 0
		if Input.pressed("confirm") and self.soundtoplay ~= -1 and not Input.down("cancel") then
			local mypitch = scr_piano_determinepitch(self.soundtoplay)
			Assets.playSound(self.instrument, 0.7, mypitch)
			soundplayed = 1
			self.notesplayed = true
			self.buffer = 0
		end
		
		if soundplayed then
		
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

function ChurchPiano:draw()
	super.draw(self)
	
	self.siner = self.siner + 1 * DTMULT
	if self.con == 1 then
		self.engaged = true
	else
		self.engaged = false
	end
	
	local alphtarg = 0
	if self.con == 1 and not self.dontdrawmenu then
		alphtarg = 1
	end
	self.drawalpha = Utils.lerp(self.drawalpha, alphtarg, 0.1*DTMULT)
	self.drawspace = 18
	local drawx = 0 + self.width/2
	local drawy = 0 - 80
	love.graphics.setColor(0,0,0,self.drawalpha*0.5)
	love.graphics.circle("fill", drawx, drawy, 44 + math.sin(self.siner / 64) * 2)
	local litblue = Utils.hexToRgb("#698DE6")
	local sinstrength = 2
	local basealpha = 0.35
	for i, unit in ipairs(self.drawunits) do
		local bonusalpha = 0
		local xloc = drawx + unit.x
		local yloc = drawy + unit.y + (math.sin((self.siner + (i * 42)) / 9) * sinstrength)
		
		if self.soundtoplay == unit.sound then
			bonusalpha = 0.6
			if Input.pressed("confirm") and self.con == 1 and not Input.down("cancel") then
                local note = Sprite(unit.tex, xloc, yloc)
				note.layer = self.layer + 1
                note:setColor(litblue)
				note:setScale(2,2)
				note:setOriginExact(unit.offx, unit.offy)
				note.rotation = unit.rot
                note.physics.direction = math.rad(Utils.random(360))
                note.physics.speed = 5
                note.physics.friction = 0.35
				note.physics.direction = unit.rot + math.rad(90)
				if self.soundtoplay == 0 then
					note.physics.speed = 0
				end
				Game.world.timer:tween(20/30, note, {alpha = 0}, 'out-quad', function()
					note:remove()
				end)
				self:addChild(note)
			end
		end
		love.graphics.setColor(litblue[1], litblue[2], litblue[3], (basealpha + bonusalpha) * self.drawalpha)
		Draw.draw(Assets.getTexture(unit.tex), xloc, yloc, unit.rot, 2, 2, unit.offx, unit.offy)
	end
	love.graphics.setColor(1,1,1,1)
end

return ChurchPiano