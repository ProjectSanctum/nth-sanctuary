local RemotePianoMove, super = Class(Event, "remotepianomove")

function RemotePianoMove:init(data)
    super.init(self, data)
	
    local properties = data.properties or {}
	
	self.carpet_spr = properties["carpettex"] or "world/objects/spr_dw_churchb_movingpianocarpet"
	self.carpet_tex = Assets.getTexture(self.carpet_spr)
	self.piano_spr = properties["sprite"] or "world/objects/spr_dw_churchb_movingpiano"
	self.piano_tex = Assets.getTexture(self.piano_spr)
	self.shadow_tex = Assets.getTexture("world/objects/saucershadow")
	self.draw_children_above = 1
	self.solid = true
	self.con = 0
	self.timer = 0
	self.yoffset = 0
	self.yspeed = 0
	self.shakex = 0
	self.ralsei_knocked_down = 0
	self.ralshakex = 0
	self.currentdir = -1
	self.movedir = -1
	self.shakey = 0
	self.collider = Hitbox(self, 6, 32, 68, 18)
	self.instrument = "piano"
	self.buffer = 0
	self.soundtoplay = -1
	self.canceltimer = 0
	self.canceltime = 15
	self.engaged = false
	self.siner = 0
	self.no_cancel = properties["nocancel"] or false
	self.final_mode = properties["final"] ~= false
	self.ubuff = 0
	self.rbuff = 0
	self.lbuff = 0
	self.dbuff = 0
	self.xbuff = 0
	self.zbuff = 0
	self.myhspeed = 0
	self.myvspeed = 0
	self.camcontrol = false
	self.camx = 0
	self.camy = 0
	self.camcon = 0
	self.camstrength = 1
	self.siner = 0
	self.makenote = false
	self.drawx = self.x + 40
	self.drawy = self.y - 70
	self.hitstop = 0
	self.drawalpha = 0
	self.show_instructions = false
	self.remember_pos = properties["rememberxy"] or true
	self.cam_marker = properties["cammarker"] or nil
end

function RemotePianoMove:onAdd(parent)
    super.onAdd(self,parent)
    if not Game.stage:getObjects(TutorialText)[1] then
		local tuttext = TutorialText(4, self)
		Game.world:addChild(tuttext)
	end
	if self.remember_pos then
		if self:getFlag("last_x") then
			self.x = self:getFlag("last_x")
		end
		if self:getFlag("last_y") then
			self.y = self:getFlag("last_y")
		end
	end
	self.drawx = self.x + 40
	self.drawy = self.y - 70
	self.ui = RemotePianoMoveUI(self)
	self.ui.layer = WORLD_LAYERS["above_events"]
	Game.world:addChild(self.ui)
end

local function scr_returnwait(x1, y1, x2, y2, spd)
	return math.max(1, MathUtils.round(MathUtils.dist(x1, y1, x2, y2) / spd))
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

function RemotePianoMove:onInteract(player, dir)
	if self.con == 0 and self.buffer <= 0 then
		self.con = 1.1
		local pos = {self.x + self.width / 2 - 1, self.y + self.height - 10}
		local walktime = math.max(MathUtils.round(MathUtils.dist(pos[1], pos[2], Game.world.player.x, Game.world.player.y) / 4), 4)
		local cutscene
		if walktime <= 11 and (self.y - 10) < Game.world.player.y then
			Game.lock_movement = true
			cutscene = self.world:startCutscene(function(cutscene)
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
				cutscene:walkTo(leader, pos[1], pos[2], walktime/30, "up")
				if party2 then
					pos = {self.x + self.width / 2 + 22 - 1, self.y + self.height}
					cutscene:walkTo(party2, pos[1], pos[2], walktime/30, "up")
				end
				if party3 then
					pos = {self.x + self.width / 2 - 14 - 1, self.y + self.height}
					cutscene:walkTo(party3, pos[1], pos[2], walktime/30, "up")
				end
				if party4 then
					pos = {self.x + self.width / 2 - 1, self.y + self.height}
					cutscene:walkTo(party4, pos[1], pos[2], walktime/30, "up")
				end
				if self.cam_marker and not self.final_mode then
					if walktime < 15 then
						walktime = 15
					end
					cutscene:panTo(self.cam_marker, 15/30)
				else
					pos = {self.x - 281 + SCREEN_WIDTH/2, self.y - 206 + SCREEN_HEIGHT/2}
					local min_x, min_y = Game.world.camera:getMinPosition()
					local max_x, max_y = Game.world.camera:getMaxPosition()
					pos[1] = MathUtils.clamp(pos[1], min_x, max_x)
					pos[2] = MathUtils.clamp(pos[2], min_y, max_y)
					cutscene:panTo(pos[1], pos[2], walktime/30)
				end
				cutscene:wait(walktime/30)
			end)
		else
			Game.lock_movement = true
			cutscene = self.world:startCutscene(function(cutscene)
				cutscene:detachCamera()
				cutscene:detachFollowers()	
				if self.cam_marker then
					if walktime < 15 then
						walktime = 15
					end
					cutscene:panTo(self.cam_marker, 15/30)
				else
					local pos = {self.x - 281 + SCREEN_WIDTH/2, self.y - 206 + SCREEN_HEIGHT/2}
					local min_x, min_y = Game.world.camera:getMinPosition()
					local max_x, max_y = Game.world.camera:getMaxPosition()
					pos[1] = MathUtils.clamp(pos[1], min_x, max_x)
					pos[2] = MathUtils.clamp(pos[2], min_y, max_y)
					cutscene:panTo(pos[1], pos[2], walktime/30)
				end
				Assets.playSound("wing")
				local last_layer = self.layer
				self.layer = Game.world.player.layer - 0.1
				local jumpstrength = 12
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
				if party2 then
					pos = {self.x + self.width / 2 + 22 - 1, self.y + self.height}
					party2.sprite:set("jump_ball")
					cutscene:jumpTo(party2, pos[1], pos[2], jumpstrength, 16/30)
				end
				if party3 then
					pos = {self.x + self.width / 2 - 14 - 1, self.y + self.height}
					party3.sprite:set("jump_ball")
					cutscene:jumpTo(party3, pos[1], pos[2], jumpstrength, 16/30)
				end
				if party4 then
					pos = {self.x + self.width / 2 - 1, self.y + self.height}
					party4.sprite:set("jump_ball")
					cutscene:jumpTo(party4, pos[1], pos[2], jumpstrength, 16/30)
				end
				pos = {self.x + self.width / 2 - 1, self.y + self.height - 10}
				cutscene:jumpTo(leader, pos[1], pos[2], jumpstrength, 16/30)
				leader.sprite:set("jump_ball")
				cutscene:wait(16/30)
				Assets.playSound("noise")
				self.layer = last_layer
				leader:resetSprite()
				if party2 then
					party2:resetSprite()
				end
				if party3 then
					party3:resetSprite()
				end
				if party4 then
					party4:resetSprite()
				end
			end)
		end
		if Game.stage:getObjects(TutorialText)[1] then
			Game.stage:getObjects(TutorialText)[1].target = self
		end
		cutscene:after(function()
			Game.lock_movement = true
			self.con = 2
			self.engaged = true
			self.show_instructions = true
			if self.cam_marker then
				self.camcon = 1
				self.camcontrol = true
				local marker = self.world.map.markers[self.cam_marker]
				if marker then
					self.camx, self.camy = marker.center_x, marker.center_y
				end
			else
				Game.world:setCameraAttached(true)
			end
		end)
		return true
	end
end

function RemotePianoMove:getSortPosition()
    return self:getRelativePos(self.width / 2, self.height - 22)
end

function RemotePianoMove:update()
	super.update(self)
	local mywidth = 80
	local myheight = 80
	if self.engaged then
		self.ubuff = self.ubuff - DTMULT
		self.rbuff = self.rbuff - DTMULT
		self.lbuff = self.lbuff - DTMULT
		self.dbuff = self.dbuff - DTMULT
		self.xbuff = self.xbuff - DTMULT
		self.zbuff = self.zbuff - DTMULT
		local this_frame_directions = {}
		if Input.down("up") then
			table.insert(this_frame_directions, 2)
		end
		if Input.down("down") then
			table.insert(this_frame_directions, 0)
		end
		if Input.down("right") then
			table.insert(this_frame_directions, 1)
		end
		if Input.down("left") then
			table.insert(this_frame_directions, 3)
		end
		local num_inputs = #this_frame_directions
		self.movedir = -1
		if num_inputs == 0 then
			self.currentdir = -1
		elseif self.num_inputs == 1 and self.currentdir == -1 then
			self.currentdir = this_frame_directions[1]
			self.movedir = self.currentdir
		else
			for i = 1, num_inputs do
				if this_frame_directions[1] == self.currentdir then
					table.remove(this_frame_directions, i)
					break
				end
			end
			self.movedir = this_frame_directions[1]
		end
		if self.movedir == 3 then
			if self.lbuff < 3 then
				self.lbuff = 3
			end
		end
		if self.movedir == 1 then
			if self.rbuff < 3 then
				self.rbuff = 3
			end
		end
		if self.movedir == 2 then
			if self.ubuff < 3 then
				self.ubuff = 3
			end
		end
		if self.movedir == 0 then
			if self.dbuff < 3 then
				self.dbuff = 3
			end
		end
		if Input.down("cancel") then
			self.xbuff = 3
		end
		if Input.down("confirm") then
			self.zbuff = 3
		end
		Object.startCache()
		local collider = Hitbox(self, 0, 0, 80, 80)
		--[[for _, killblock in ipairs(Game.world:getEvents("killpiano")) do
			if killblock:collidesWith(collider) then
				if self.con < 400 then
					self.con = 400
					self.timer = 0
				end
			end
		end]]
		Object.endCache()
	end
	local version = 1
	if self.con == 2 and version == 1 then
		local dir = -1
		if self.xbuff > 0 and not self.no_cancel then
			self.dbuff = 0
			self.rbuff = 0
			self.ubuff = 0
			self.lbuff = 0
			self.zbuff = 0
			self.canceltimer = self.canceltimer + DTMULT
		else
			self.canceltimer = 0
		end
		if self.canceltimer >= self.canceltime then
			self.timer = 0
			self.con = 98
			self.canceltimer = 0
		end
		local dir = self.movedir
		if Input.pressed("confirm") then
			self.soundtoplay = -1
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
			local mypitch = scr_piano_determinepitch(self.soundtoplay)
			self.makenote = true
			Assets.playSound(self.instrument, 0.7, mypitch)
		end
		if dir ~= -1 and self.zbuff > 0 then
			self.zbuff = 0
			local px = 0
			local py = 0
			local stoppingpoint = false
			local mysol = self.collider
			local checkstep = 0
			local checkcount = 0
			if dir == 0 then
				py = 1
			elseif dir == 1 then
				px = 1
			elseif dir == 2 then
				py = -1
			elseif dir == 3 then
				px = -1
			end
			Object.startCache()
			local collided = false
			local bound_check = Hitbox(self.world, self.x + 1 + px * 40, self.y + 1 + py * 40, mywidth - 2, myheight - 2)
			for _, collider in ipairs(Game.world.map.block_collision) do
				if collider:collidesWith(bound_check) then
					collided = true
					break
				end
			end
			if not collided then
				self.collidable = false
				collided = self.world:checkCollision(bound_check)
				self.collidable = true
			end
			Object.endCache()
			if collided then
				stoppingpoint = true
			end
			if not stoppingpoint then
				if self.camcon == 1 then
					self.camcon = 2
				end
				self.con = 3
				if self.ralsei_knocked_down > 0 then
					self.ralshakex = 8
				end
				self.ralsei_knocked_down = 0
				Assets.playSound("wing")
				self.myhspeed = 0
				self.myvspeed = 0
				if dir == 0 then
					self.myvspeed = 2
				elseif dir == 1 then
					self.myhspeed = 2
				elseif dir == 2 then
					self.myvspeed = -2
				elseif dir == 3 then
					self.myhspeed = -2
				end
			end
		end
	end
	if self.con == 3 then
		local maxspeed = 28
		if self.myhspeed ~= 0 then
			self.myhspeed = MathUtils.lerp(math.abs(self.myhspeed), maxspeed, 0.25*DTMULT) * MathUtils.sign(self.myhspeed)
		end
		if self.myvspeed ~= 0 then
			self.myvspeed = MathUtils.lerp(math.abs(self.myvspeed), maxspeed, 0.25*DTMULT) * MathUtils.sign(self.myvspeed)
		end	
		local stoppingpoint = false
		Object.startCache()
		local collided = false
		local bound_check = Hitbox(self.world, self.x + 1 + self.myhspeed, self.y + 1 + self.myvspeed, mywidth - 2, myheight - 2)
		for _, collider in ipairs(Game.world.map.block_collision) do
			if collider:collidesWith(bound_check) then
				collided = true
				break
			end
		end
		if not collided then
			self.collidable = false
			collided = self.world:checkCollision(bound_check)
			self.collidable = true
		end
		Object.endCache()
		if collided then
			stoppingpoint = true
		end
		if math.floor(Kristal.getTime()*30) % 2 == 0 then
			local xoffset = 0.5
			local yoffset = MathUtils.random(0.6) + 0.2
			if self.myvspeed ~= 0 then
				xoffset = yoffset
				yoffset = 0.5
			end
			local dust = Sprite("effects/climb_dust_small")
			dust:play(1 / 15, false, function () dust:remove() end)
			dust:setOrigin(0.5, 0)
			dust:setScale(2, 2)
			dust:setPosition(self.x + (xoffset * self.piano_tex:getWidth()), self.y + (yoffset * self.piano_tex:getHeight()))
			dust.physics.speed_x = MathUtils.random(-1, 1)
			dust.layer = self.layer - 0.1
			Game.world:addChild(dust)
		end
		if stoppingpoint then
			self.myhspeed = MathUtils.round(self.myhspeed)
			self.myvspeed = MathUtils.round(self.myvspeed)
			self.x = MathUtils.round(self.x)
			self.y = MathUtils.round(self.y)
			Object.startCache()
			local endloop = false
			for i = 0, (math.max(math.abs(self.myhspeed), math.abs(self.myvspeed)) + 1) do
				if not endloop then
					local collided = false
					local bound_check = Hitbox(self.world, self.x + self.myhspeed, self.y + self.myvspeed, mywidth - 1, myheight - 1)
					for _, collider in ipairs(Game.world.map.block_collision) do
						if collider:collidesWith(bound_check) then
							collided = true
							break
						end
					end
					if not collided then
						self.collidable = false
						collided = self.world:checkCollision(bound_check)
						self.collidable = true
					end
					if collided then
						if self.myhspeed ~= 0 then
							self.myhspeed = (math.abs(self.myhspeed) - 1) * MathUtils.sign(self.myhspeed)
						end
						if self.myvspeed ~= 0 then
							self.myvspeed = (math.abs(self.myvspeed) - 1) * MathUtils.sign(self.myvspeed)
						end
					else
						endloop = true
						self.x = self.x + self.myhspeed * DTMULT
						self.y = self.y + self.myvspeed * DTMULT
					end
				end
			end
			Object.endCache()
			self.x = MathUtils.round(self.x / 40) * 40
			self.y = MathUtils.round(self.y / 40) * 40
			Assets.playSound("bomb")
			if self.myhspeed ~= 0 then
				self.shakex = 8
			else
				self.shakey = 8
			end
			self.con = 2
		elseif self.hitstop <= 0 then
			self.x = self.x + MathUtils.round(self.myhspeed) * DTMULT
			self.y = self.y + MathUtils.round(self.myvspeed) * DTMULT
		else
			self.hitstop = self.hitstop - DTMULT
		end
	end	
	if self.con == 4 then
		local maxspeed = 16
		if self.myhspeed ~= 0 then
			self.myhspeed = MathUtils.lerp(math.abs(self.myhspeed), maxspeed, 0.25*DTMULT) * MathUtils.sign(self.myhspeed)
		end
		if self.myvspeed ~= 0 then
			self.myvspeed = MathUtils.lerp(math.abs(self.myvspeed), maxspeed, 0.25*DTMULT) * MathUtils.sign(self.myvspeed)
		end	
		self.x = self.x + MathUtils.round(self.myhspeed) * DTMULT
		self.y = self.y + MathUtils.round(self.myvspeed) * DTMULT
		self.yspeed = self.yspeed + 0.65 * DTMULT
		self.yoffset = self.yoffset + self.yspeed * DTMULT
		if self.yoffset >= 0 then
			self.yoffset = 0
			self.con = 3
			Assets.playSound("impact")
			self.shakex = 12
			self.yspeed = 0
		end
	end
	if self.con == 98 then
		self.camcontrol = false
		self.camcon = 0
		self.engaged = false
		self.show_instructions = false
		self:setFlag("last_x", self.x)
		self:setFlag("last_y", self.y)
		self.con = 99
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
			local py = Game.world.player.y
			local krpos = {self.x + self.width / 2 - 1, py + 6}
			local walktime = math.max(MathUtils.round(MathUtils.dist(krpos[1], krpos[2], Game.world.player.x, Game.world.player.y) / 4), 1)
			leader:resetSprite()
			leader.layer = Game.world.map.object_layer
			cutscene:walkTo(leader, krpos[1], krpos[2], walktime/30, "down")
			if party2 then
				krpos = {self.x + self.width / 2 + 14 - 1, py - 4}
				party2:resetSprite()
				party2.layer = Game.world.map.object_layer
				cutscene:walkTo(party2, krpos[1], krpos[2], walktime/30, "down")
			end
			if party3 then
				krpos = {self.x + self.width / 2 - 16 - 1, py - 4}
				party3:resetSprite()
				party3.layer = Game.world.map.object_layer
				cutscene:walkTo(party3, krpos[1], krpos[2], walktime/30, "down")
			end
			if party4 then
				krpos = {self.x + self.width / 2 - 1, py - 4}
				party4:resetSprite()
				party4.layer = Game.world.map.object_layer
				cutscene:walkTo(party4, krpos[1], krpos[2], walktime/30, "down")
			end
			local tx, ty = self.world.camera:getTargetPosition()
			local pantime = MathUtils.clamp(MathUtils.round(ty / 8), walktime, 15)
			cutscene:attachCamera(pantime/30)
			cutscene:interpolateFollowers()
			cutscene:attachFollowers()
		end)
		cutscene:after(function()
			self.ubuff = 0
			self.dbuff = 0
			self.lbuff = 0
			self.rbuff = 0
			self.xbuff = 0
			self.zbuff = 0
			Game.world.player:setFacing("down")
			self.timer = 0
			self.con = 0
			Game.lock_movement = false
		end)
	end
	if self.con == 400 then
		local jumptime = 16
		local jumpheight = 20
		local explodedelay = 26
		local maxspeed = 16
		if self.myhspeed ~= 0 then
			self.myhspeed = MathUtils.lerp(math.abs(self.myhspeed), maxspeed, 0.25*DTMULT) * MathUtils.sign(self.myhspeed)
		end
		if self.myvspeed ~= 0 then
			self.myvspeed = MathUtils.lerp(math.abs(self.myvspeed), maxspeed, 0.25*DTMULT) * MathUtils.sign(self.myvspeed)
		end	
		self.x = self.x + MathUtils.round(self.myhspeed) * DTMULT
		self.y = self.y + MathUtils.round(self.myvspeed) * DTMULT
		self.yspeed = self.yspeed + 0.65 * DTMULT
		self.yoffset = self.yoffset + self.yspeed * DTMULT
		if self.yoffset >= 0 then
			self.alpha = self.alpha - 0.1 * DTMULT
		end
		if self.alpha <= 0 then
			self.visible = false
			Assets.playSound("impact")
			Game.world.camera:shake(0, 8)
			self:remove()
		end	
		local cutscene = self.world:startCutscene(function(cutscene)
			cutscene:detachCamera()
			if self.cam_marker then
				if walktime < 15 then
					walktime = 15
				end
				cutscene:panTo(self.cam_marker, 15/30)
			else
				local pos = {self.x - 281 + SCREEN_WIDTH/2, self.y - 206 + SCREEN_HEIGHT/2}
				local min_x, min_y = Game.world.camera:getMinPosition()
				local max_x, max_y = Game.world.camera:getMaxPosition()
				pos[1] = MathUtils.clamp(pos[1], min_x, max_x)
				pos[2] = MathUtils.clamp(pos[2], min_y, max_y)
				cutscene:panTo(pos[1], pos[2], walktime/30)
			end
			Assets.playSound("wing")
			local jumpstrength = 12
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
			if party2 then
				pos = {self.x + 36, self.y - 10}
				cutscene:jumpTo(party2, pos[1], pos[2], jumpstrength, jumptime/30)
			end
			if party3 then
				pos = {self.x + 4, self.y - 10}
				cutscene:jumpTo(party3, pos[1], pos[2], jumpstrength, jumptime/30)
			end
			if party4 then
				pos = {self.x + 20, self.y - 16}
				cutscene:jumpTo(party4, pos[1], pos[2], jumpstrength, jumptime/30)
			end
			pos = {self.x + 20, self.y - 4}
			cutscene:jumpTo(leader, pos[1], pos[2], jumpstrength, jumptime/30)
			cutscene:wait(jumptime/30)
			Assets.playSound("noise")
			cutscene:interpolateFollowers()
			cutscene:attachFollowers()
			cutscene:attachCamera()
		end)
	end
	if self.shakex > 0 then
		self.shakex = self.shakex - DTMULT
	end
	if self.shakey > 0 then
		self.shakey = self.shakey - DTMULT
	end
	local party2, party3, party4 = nil, nil, nil
	if #Game.party >= 2 then
		party2 = Game.world:getCharacter(Game.party[2]:getActor().id)
	end
	if #Game.party >= 3 then
		party3 = Game.world:getCharacter(Game.party[3]:getActor().id)
	end
	if #Game.party >= 4 then
		party4 = Game.world:getCharacter(Game.party[4]:getActor().id)
	end
	if self.engaged then
		Game.world.player:setPosition(self.x + self.width / 2 - 1, self.y + self.height - 10)
		Game.world.player:setSprite("piano")
		Game.world.player.layer = self.layer + 0.1
		for i, follower in ipairs(Game.world.followers) do
			local custom_spr = false
			local xpos = self.x + self.width / 2
			local ypos = self.y + self.height - 10
			local xoff = 0
			local yoff = (self.yoffset * 1.1)
			if i == 1 then
				xpos = self.x + self.width / 2 + 22 - 1
				ypos = self.y + self.height
				follower.layer = self.layer + 0.2
			end
			if i == 2 then
				xpos = self.x + self.width / 2 - 14 - 1
				ypos = self.y + self.height
				follower.layer = self.layer + 0.1
			end
			if i == 3 then
				xpos = self.x + self.width / 2 - 1
				ypos = self.y + self.height
				follower.layer = self.layer + 0.3
			end
			if follower.actor.id == "susie" then
				yoff = (self.yoffset * 1.05)
				if self.shakex >= 9 then
					custom_spr = true
					follower:setSprite("fall_brace_1")
					if self.myhspeed < 0 then
						follower.flip_x = true
						follower:setPosition(self.x + 96, ypos + yoff)
					end
				end
			end
			if follower.actor.id == "ralsei" then
				if self.ralshakex > 0 then
					xoff = ((self.ralshakex % 2 - 0.5) * 2 * self.ralshakex)
				end
				yoff = (self.yoffset * 1.2)
				if self.yoffset < 0 then
					self.ralsei_knocked_down = 16
					custom_spr = true
					follower:setPosition(xpos + xoff, ypos + yoff)
					if self.myhspeed > 0 then
						follower:setSprite("shocked_right_landed_1")
					else
						follower:setSprite("shocked_left_landed_1")
					end
				elseif self.ralsei_knocked_down <= 0 then
					custom_spr = false
				else
					self.ralsei_knocked_down = self.ralsei_knocked_down - DTMULT
					if self.ralsei_knocked_down <= 0 then
						self.ralshakex = 8
					end
					if self.myhspeed > 0 then
						follower:setSprite("shocked_right_landed_2")
					else
						follower:setSprite("shocked_left_landed_2")
					end
					custom_spr = true
				end
				self.ralshakex = self.ralshakex - DTMULT
			end
			follower:setPosition(xpos + xoff, ypos + yoff)
			follower:setFacing("up")
		end
	end
	if self.camcontrol then
		Game.world:setCameraAttached(false)
		local min_x, min_y = Game.world.camera:getMinPosition()
		local max_x, max_y = Game.world.camera:getMaxPosition()
		local camx = MathUtils.clamp(self.camx, min_x, max_x)
		local camy = MathUtils.clamp(self.camy, min_y, max_y)
		Game.world.camera:setPosition(camx, camy)
		if self.camcon == 2 then
			local plcamx = MathUtils.clamp(Game.world.player.x, min_x, max_x)
			local plcamy = MathUtils.clamp(Game.world.player.y, min_y, max_y)
			self.camstrength = MathUtils.lerp(self.camstrength, 4, 0.010101010101010102 * DTMULT)
			self.camx = MathUtils.lerp(camx, plcamx, (self.camstrength / 8) * DTMULT)
			self.camy = MathUtils.lerp(camy, plcamy, (self.camstrength / 8) * DTMULT)
			if MathUtils.dist(plcamx, plcamy, self.camx, self.camy) < 2 then
				self.camcon = 3
				self.camcontrol = false
				local tx, ty = Game.world.camera:getTargetPosition()
				Game.world:setCameraAttached(true)
				Game.world.camera:setPosition(tx, ty)
			end
		end
	end
end

function RemotePianoMove:draw()
	if self.con == 4 then
		Draw.setColor(0,0,0,0.5)
		Draw.draw(self.shadow_tex, 0, 0, 0, 1.5, 3.5)
	end
	Draw.setColor(1,1,1,1)
	if self.carpet_tex then
        Draw.draw(self.carpet_tex, 0, self.yoffset, 0, 1, 1)
	end
	if self.piano_tex then
        Draw.draw(self.piano_tex, (math.sin(self.shakex * 1.5) * (self.shakex / 2)), self.yoffset + (math.sin(self.shakey * 1.5) * (self.shakey / 2)), 0, 2, 2, 2, 10)
	end
	super.draw(self)
end

return RemotePianoMove